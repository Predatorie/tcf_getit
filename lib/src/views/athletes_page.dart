import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcf_getit/branding/branding.dart';
import 'package:tcf_getit/src/models/athletes_dto.dart';
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
    _scrollController ??= ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController?.dispose();

    super.dispose();
  }

  /// handles the end of list scroll notification
  /// for pagination
  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll && !_scrollController.position.outOfRange) {
      if (Provider.of<AthletesRepository>(context, listen: false).hasNextPage) {
        await Provider.of<AthletesRepository>(context, listen: false)
            .getNextAthletesAsync();
      }
    }
  }

/*  @override
  Widget build(BuildContext context) {
    final repository = context.watch<AthletesRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('ATHLETES'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: repository.athletes.length,
          itemBuilder: (_, i) {
            return _athleteCard(repository.athletes[i]);
          }),
    );
  }*/

/*  @override
  Widget build(BuildContext context) {
    final repository = context.watch<AthletesRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('ATHLETES'),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          ...repository.athletes
              .map(
                (athlete) => _athleteCard(athlete),
              )
              .toList(),
          repository.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 1,
                )
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<AthletesRepository>();

    return Scaffold(
        appBar: AppBar(
          title: Text('ATHLETES'),
        ),
        body: GridView(
          padding: EdgeInsets.only(left: 10, right: 10),
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .9,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),
          children: [
            ...repository.athletes
                .map(
                  (athlete) => _athleteCard(athlete),
                )
                .toList(),
            repository.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 1,
                  )
          ],
        ));
  }

  Widget _athleteCard(AthleteAttributes data) {
    final isEmpty =
        data.profileImageUrl == null || data.profileImageUrl.isEmpty;

    return Center(
      child: Card(
          key: Key(data.email),
          borderOnForeground: false,
          shadowColor: tollandCrossFitBlue,
          margin: EdgeInsets.only(top: 20),
          semanticContainer: false,
          elevation: 4,
          child: Column(
            children: [
              isEmpty
                  ? Image.asset(
                      'assets/images/tcf_logo_small.png',
                      fit: BoxFit.fitHeight,
                      width: 128,
                      height: 128,
                    )
                  : CachedNetworkImage(
                      key: Key(data.email),
                      imageUrl: data.profileImageUrl,
                      width: 128,
                      height: 128,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/tcf_logo_small.png',
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/tcf_logo_small.png',
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Text(
                data.firstName.toUpperCase(),
                style: TextStyle(
                    color: tollandCrossFitBlue, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
