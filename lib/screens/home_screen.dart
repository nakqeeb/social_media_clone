import 'package:flutter/material.dart';
import 'package:social_media/data/data.dart';
import 'package:social_media/widgets/custom_drawer.dart';
import '../widgets/following_users.dart';
import '../widgets/posts_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // print(_tabController!.index);
    _pageController =
        PageController(initialPage: 0, viewportFraction: 0.8); // 0.8 = 80%
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        title: Text(
          'FRENZY',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 18,
          ),
          onTap: (index) {
            print(index);
          },
          tabs: const [
            Tab(
              text: 'Trending',
            ),
            Tab(
              text: 'Latest',
            )
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FollowingUsers(),
            PostsCarousel(
              pageController: _pageController,
              title: 'Posts',
              posts: posts,
            )
          ],
        ),
      ),
    );
  }
}
