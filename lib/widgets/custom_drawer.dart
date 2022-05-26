import 'package:flutter/material.dart';
import 'package:social_media/data/data.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/screens/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  _buildDrawerOption(
      {required Icon icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Stack(
            children: [
              Image(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                image: AssetImage(currentUser.backgroundImageUrl!),
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          // borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      child: ClipOval(
                        child: Image(
                          height: 100,
                          width: 100,
                          image:
                              AssetImage(currentUser.profileImageUrl as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      currentUser.name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 1.5,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          _buildDrawerOption(
            icon: const Icon(Icons.dashboard),
            title: 'Home',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            },
          ),
          _buildDrawerOption(
            icon: const Icon(Icons.chat),
            title: 'Chat',
            onTap: () {},
          ),
          _buildDrawerOption(
            icon: const Icon(Icons.map),
            title: 'Map',
            onTap: () {},
          ),
          _buildDrawerOption(
            icon: const Icon(Icons.account_circle),
            title: 'Your Profile',
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
          _buildDrawerOption(
            icon: const Icon(Icons.settings),
            title: 'Settings',
            onTap: () {},
          ),
          const Spacer(),
          _buildDrawerOption(
            icon: const Icon(Icons.logout),
            title: 'Logout',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
