import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/src/models/benchmarks_dto.dart';
import 'package:tcf_getit/src/providers/girls_service.dart';
import 'package:tcf_getit/styles/styles.dart';

class GirlsPage extends StatefulWidget {
  static const String routeName = '/girls';
  @override
  _GirlsPageState createState() => _GirlsPageState();
}

class _GirlsPageState extends State<GirlsPage> {
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
    final service = context.watch<GirlsService>();

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
            _heroesCard(service.girls),
          ],
        ),
      ),
    ));
  }

  Widget _heroesCard(List<Datum> benchmarks) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: benchmarks.length,
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
                      benchmarks[index].attributes.name,
                      style: fontStyleCardTitle,
                    )),
                    verticalMarginSmall(),
                    Text(
                      benchmarks[index].attributes.description,
                      style: fontStyleCardNormal,
                    ),
                    verticalMarginLarge(),
                    Text(
                      "Score:  ${benchmarks[index].attributes.scoreType}",
                      style: fontStyleCardMicro,
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
      if (Provider.of<GirlsService>(context, listen: false).hasNextPage) {
        await Provider.of<GirlsService>(context, listen: false)
            .getNextGirlsAsync();
      }
    }
  }
}
