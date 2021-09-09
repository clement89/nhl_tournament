import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nhl_tournament/models/match.dart';
import 'package:nhl_tournament/viewmodels/matches_viewmodel.dart';
import 'package:provider/provider.dart';

import 'match_tile.dart';

class DetailsPage extends StatefulWidget {
  final Game game;
  const DetailsPage({
    Key? key,
    required this.game,
  }) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MatchesViewModel _viewModel =
        Provider.of<MatchesViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/nhl.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'NHL 2019 Playoffs',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    // Text(
                    //   'Stanly Cup Final',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.normal,
                    //     color: Colors.white60,
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    _viewModel.getRound(widget.game),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Center(
                    child: Text(
                      _viewModel.getMatchInfo(widget.game),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
              ),
              _viewModel.isFinal(widget.game) ? Container() : _nextMatch(),
            ],
          ),
        ));
  }

  _nextMatch() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Next Match',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        MatchTile(
            game: context.read<MatchesViewModel>().getNextMatch(widget.game)),
      ],
    );
  }
}
