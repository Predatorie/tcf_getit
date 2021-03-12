import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/src/models/barbells_dto.dart';
import 'package:tcf_getit/src/providers/barbell_service.dart';
import 'package:tcf_getit/styles/styles.dart';

class BarbellsPage extends StatefulWidget {
  static const String routeName = '/barbells';
  @override
  _BarbellsPageState createState() => _BarbellsPageState();
}

class _BarbellsPageState extends State<BarbellsPage> {
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
    final service = context.watch<BarbellService>();

    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: InkWell(
                      child: Icon(FontAwesomeIcons.arrowLeft),
                      onTap: () => Navigator.pop(context)),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            _benchmarkCard(service.barbell),
          ],
        ),
      ),
    ));
  }

  Widget _benchmarkCard(List<Datum> data) {
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
                    )),
                    verticalMarginLarge(),
                    Text(
                      "Category: ${data[index].attributes.category}",
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
      if (Provider.of<BarbellService>(context, listen: false).hasNextPage) {
        await Provider.of<BarbellService>(context, listen: false)
            .getNextBarbellsAsync();
      }
    }
  }
}
