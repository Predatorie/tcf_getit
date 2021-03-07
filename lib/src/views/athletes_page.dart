import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/src/models/athletes.dart';
import 'package:tcf_getit/src/services/athletes_repository.dart';

class AthletesPage extends StatefulWidget {
  static const String routeName = '/athletes';

  @override
  _AthletesPageState createState() => _AthletesPageState();
}

class _AthletesPageState extends State<AthletesPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // _scrollController ?? ScrollController();
    //  _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // _scrollController?.dispose();

    super.dispose();
  }

  /// handles the end of list scroll notification
  /// for pagination
  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    /// todo: are we near the bottom and do we have a next page url available?
    if (context.watch<AthletesRepository>().hasNextPage) {
      await context.read<AthletesRepository>().getNextAthletesAsync();
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<AthletesRepository>();

    return Scaffold(
        appBar: AppBar(
          title: Text('ATHLETES'),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: repository.athletes.length,
          itemBuilder: (_, index) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: repository.athletes[index].data.length,
                itemBuilder: (_, i) {
                  return _athleteCard(repository.athletes[index].data[i]);
                });
          },
        ));
  }

  Widget _athleteCard(Datum data) {
    final isEmpty = data.attributes.profileImageUrl == null ||
        data.attributes.profileImageUrl.isEmpty;

    return Center(
      child: Card(
        key: Key(data.id),
        child: isEmpty
            ? Image.asset(
                'assets/images/tcf_logo_small.png',
              )
            : Image.network(
                data.attributes.profileImageUrl,
                fit: BoxFit.cover,
                width: 256,
                height: 256,
              ),
      ),
    );
  }
}
