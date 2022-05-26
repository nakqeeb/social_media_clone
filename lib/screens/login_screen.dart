import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Image(
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              image: const AssetImage('assets/images/login_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'FRENZY',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 34,
              letterSpacing: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
          ),
          // password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Button
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //side: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              child: const Text('Login'),
            ),
          ),

          const Spacer(),
          // no account?
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 8.5,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Do not have an account?',
                  style: TextStyle(color: Colors.white70)),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This variable define for better understanding you can direct specify value in quadraticBezierTo method
    /* var controlPoint = Offset(size.width / 2, size.height / 2);
    var endPoint = Offset(size.width, size.height); */
    var controlPoint1 = Offset(50, size.height - 100);
    var controlPoint2 = Offset(size.width - 50, size.height);
    var endPoint = Offset(size.width, size.height - 50);
    Path path = Path();
    //path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height - 50);
    /* path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy); */
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
