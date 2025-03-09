import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../branding/branding.dart';
import '../models/athletes_dto.dart';
import '../providers/athletes_notifier.dart';

class AthletesPage extends StatefulWidget {
  static const String routeName = '/athletes';

  const AthletesPage({Key? key}) : super(key: key);

  @override
  _AthletesPageState createState() => _AthletesPageState();
}

class _AthletesPageState extends State<AthletesPage> {
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

  /// handles the end of list scroll notification
  /// for pagination
  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll && !_scrollController.position.outOfRange) {
      if (Provider.of<AthletesNotifier>(context, listen: false).hasNextPage) {
        await Provider.of<AthletesNotifier>(
          context,
          listen: false,
        ).getNextAthletesAsync();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = context.watch<AthletesNotifier>();

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
            Expanded(
              child: GridView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                children: [
                  ...service.athletes
                      .map((athlete) => _athleteCard(athlete))
                      .toList(),
                  service.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _athleteCard(AthleteAttributes data) {
    final isEmpty = data.profileImageUrl.isEmpty;

    return Center(
      child: Card(
        key: Key(data.email),
        borderOnForeground: false,
        shadowColor: tollandCrossFitBlue,
        margin: const EdgeInsets.only(top: 20),
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
                  placeholder:
                      (context, url) =>
                          Image.asset('assets/images/tcf_logo_small.png'),
                  errorWidget:
                      (context, url, error) =>
                          Image.asset('assets/images/tcf_logo_small.png'),
                ),
            const SizedBox(height: 20),
            Text(
              data.firstName.toUpperCase(),
              style: const TextStyle(
                color: tollandCrossFitBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
