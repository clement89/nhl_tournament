import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nhl_tournament/details_page.dart';

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
    // final _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    // _homeViewModel.initialize();
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
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("NHL 2019",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        // fontSize: 16.0,
                      )),
                  background: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset(
                      'images/nhl.png',
                      fit: BoxFit.contain,
                      // height: 40,
                    ),
                  ),
                ),
              ),
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

  _buildMatchList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                );
              },
              child: Container(
                color: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tampa Bay Vs Columbus',
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
        },
      ),
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
