import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nhl_tournament/models/match.dart';
import 'package:nhl_tournament/ui/match_tile.dart';
import 'package:nhl_tournament/viewmodels/matches_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    final _homeViewModel =
        Provider.of<MatchesViewModel>(context, listen: false);
    _homeViewModel.fetchAllMatches();
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _appBar(),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    tabs: [
                      Tab(icon: Icon(Icons.games), text: 'Matches'),
                      Tab(icon: Icon(Icons.info), text: 'News'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            _buildMatchList(),
            _buildNews(),
          ]),
        ),
      ),
    );
  }

  _appBar() {
    return SliverAppBar(
      expandedHeight: 170.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("NHL 2019 Playoffs",
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Color(0XFF6E85B2),
              // fontSize: 16.0,
            )),
        background: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Image.asset(
            'images/nhl.png',
            fit: BoxFit.contain,
            // height: 40,
          ),
        ),
      ),
    );
  }

  _buildMatchList() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  _buildTeamTitle(isEastern: true),
                  _easternMatchList(),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  _buildTeamTitle(isEastern: false),
                  _westernMatchList(),
                ],
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  _buildTeamTitle({required bool isEastern}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              isEastern ? 'images/nhl-eastern.png' : 'images/nhl-western.png',
              fit: BoxFit.contain,
              // height: 40,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEastern ? 'Eastern Conference' : 'Western Conference',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Round one matches',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _easternMatchList() {
    return Consumer<MatchesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.errorMessage.isNotEmpty) {
          return Text(viewModel.errorMessage);
        } else if (viewModel.easternMatches.isEmpty) {
          return CircularProgressIndicator();
        }

        return _matchList(viewModel.easternMatches);
      },
    );
  }

  _westernMatchList() {
    return Consumer<MatchesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.errorMessage.isNotEmpty) {
          return Text(viewModel.errorMessage);
        } else if (viewModel.westernMatches.isEmpty) {
          return CircularProgressIndicator();
        }
        return _matchList(viewModel.westernMatches);
      },
    );
  }

  _matchList(List<Game> matches) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return MatchTile(game: matches[index]);
      },
    );
  }

  _buildNews() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'The 2019 Stanley Cup playoffs was the playoff tournament of the National Hockey League (NHL). The playoffs began on April 10, 2019, after the 2018–19 regular season, and concluded on June 12, 2019, with the St. Louis Blues winning their first Stanley Cup in franchise history defeating the Boston Bruins four games to three in the Stanley Cup Finals.The Tampa Bay Lightning made the playoffs as the President Trophy winners with the most points (i.e. best record) during the regular season. The Pittsburgh Penguins increased their post-season appearance streak to thirteen seasons, the current longest streak. The Carolina Hurricanes made the playoffs for the first time since 2009, ending a nine-year playoff drought. For the second season in a row, the Boston Bruins and Toronto Maple Leafs were the only Original Six teams to make the playoffs, marking the fifth time in league history (after 2000, 2001, 2007 and 2018) that only two Original Six teams clinched a playoff berth. For the first time since 2004, both Southern California teams, the Anaheim Ducks and Los Angeles Kings, missed the playoffs. For the second time in League history (and the second season in a row), both the Detroit Red Wings and Montreal Canadiens missed the playoffs.',
          style: TextStyle(
            color: Colors.white60,
            height: 1.5,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
