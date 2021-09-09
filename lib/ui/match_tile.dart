import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nhl_tournament/models/match.dart';

import '../constants.dart';
import 'details_page.dart';

class MatchTile extends StatelessWidget {
  final Game game;
  const MatchTile({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      game: game,
                    )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: game.team == kTeamEastern
                ? Colors.pink.withOpacity(0.4)
                : Colors.blueAccent[700]?.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'See results',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white38,
                  size: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
