import 'package:flutter/material.dart';
import 'package:social_media/data/data.dart';
import 'package:social_media/widgets/custom_drawer.dart';
import 'package:social_media/widgets/posts_carousel.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // used to open drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController? _postsPageController;
  PageController? _favoritesPageController;

  @override
  void initState() {
    super.initState();
    _postsPageController =
        PageController(initialPage: 0, viewportFraction: 0.8); // 0.8 = 80%

    _favoritesPageController =
        PageController(initialPage: 0, viewportFraction: 0.8); // 0.8 = 80%
  }

  @override
  void dispose() {
    super.dispose();
    _postsPageController!.dispose();
    _favoritesPageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Background image
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: double.infinity,
                    image: AssetImage(currentUser.backgroundImageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
                // Menu
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: MediaQuery.of(context).size.width * 0.03,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ),
                // user image
                Positioned(
                    bottom: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            )
                          ]),
                      child: ClipOval(
                        child: Image(
                          height: 120,
                          width: 120,
                          image: AssetImage(currentUser.profileImageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
              ],
            ),
            // user name
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                currentUser.name!,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            // Following & Followers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      currentUser.following.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Followers',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      currentUser.followers.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ],
            ),

            // Your posts
            PostsCarousel(
              title: 'Your Posts',
              pageController: _postsPageController,
              posts: currentUser.posts!,
            ),
            const SizedBox(
              height: 10,
            ),

            // Your favorites
            PostsCarousel(
              title: 'Favorites',
              pageController: _favoritesPageController,
              posts: currentUser.favorites!,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8); // height = 80%
    Offset curvePoint = Offset(size.width / 2, size.height);
    Offset endPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(
        curvePoint.dx, curvePoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
