import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../styles/styles.dart';
import '../models/barbells_dto.dart';
import '../providers/barbell_notifier.dart';

class BarbellsPage extends StatefulWidget {
  static const String routeName = '/barbells';

  const BarbellsPage({required Key key}) : super(key: key);
  @override
  _BarbellsPageState createState() => _BarbellsPageState();
}

class _BarbellsPageState extends State<BarbellsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = context.watch<BarbellNotifier>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: InkWell(
                  child: const Icon(FontAwesomeIcons.arrowLeft),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            _benchmarkCard(service.barbell),
          ],
        ),
      ),
    );
  }

  Widget _benchmarkCard(List<BarbellsDatum> data) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Text(
                        data[index].attributes.name,
                        style: fontStyleCardTitle,
                      ),
                    ),
                    verticalMarginLarge(),
                    Text(
                      'Category: ${data[index].attributes.category}',
                      style: fontStyleCardNormal,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// handles the end of list scroll notification
  /// for pagination
  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll && !_scrollController.position.outOfRange) {
      if (Provider.of<BarbellNotifier>(context, listen: false).hasNextPage) {
        await Provider.of<BarbellNotifier>(
          context,
          listen: false,
        ).getNextBarbellsAsync();
      }
    }
  }
}
