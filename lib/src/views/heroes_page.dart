import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/src/providers/heroes_service.dart';

class HeroesPage extends StatefulWidget {
  static const String routeName = '/heroes';
  @override
  _HeroesPageState createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController ??= ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  /// handles the end of list scroll notification
  /// for pagination
  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll && !_scrollController.position.outOfRange) {
      if (Provider.of<HeroesService>(context, listen: false).hasNextPage) {
        await Provider.of<HeroesService>(context, listen: false)
            .getHeroesAsync();
      }
    }
  }
}
