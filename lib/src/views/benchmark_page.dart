import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../styles/styles.dart';
import '../models/benchmarks_dto.dart';
import '../providers/benchmark_notifier.dart';

class BenchmarkPage extends StatefulWidget {
  static const String routeName = '/benchmark';

  const BenchmarkPage({required Key key}) : super(key: key);
  @override
  _BenchmarkPageState createState() => _BenchmarkPageState();
}

class _BenchmarkPageState extends State<BenchmarkPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = context.watch<BenchmarkNotifier>();

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
                      child: const Icon(FontAwesomeIcons.arrowLeft),
                      onTap: () => Navigator.pop(context)),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            _benchmarkCard(service.benchmarks),
          ],
        ),
      ),
    ));
  }

  Widget _benchmarkCard(List<BenchmarksDatum> data) {
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
                    verticalMarginSmall(),
                    Text(
                      data[index].attributes.description,
                      style: fontStyleCardNormal,
                    ),
                    verticalMarginLarge(),
                    Text(
                      'Score:  ${data[index].attributes.scoreType}',
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
      if (Provider.of<BenchmarkNotifier>(context, listen: false).hasNextPage) {
        await Provider.of<BenchmarkNotifier>(context, listen: false)
            .getNextBenchmarkByCategoryAsync();
      }
    }
  }
}
