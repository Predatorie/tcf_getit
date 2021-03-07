import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  child: Text('Get Next Athletes'),
                  onPressed: () async {
                    if (repository.hasNextPage) {
                      await context
                          .read<AthletesRepository>()
                          .getNextAthletesAsync();

                      if (repository.errorMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(repository.errorMessage)));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('EOL: ${repository.athletes.length * 22}')));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
