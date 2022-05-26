import 'package:flutter/material.dart';

import '../data/data.dart';

class FollowingUsers extends StatelessWidget {
  const FollowingUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          // ignore: unnecessary_const
          child: const Text(
            'Following',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 60,
                height: 60,
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
                    height: 60,
                    width: 60,
                    image: AssetImage(users[index].profileImageUrl as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
