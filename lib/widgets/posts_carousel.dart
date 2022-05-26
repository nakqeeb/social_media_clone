import 'package:flutter/material.dart';
import 'package:social_media/models/post_model.dart';

class PostsCarousel extends StatefulWidget {
  final PageController? pageController;
  final String title;
  final List<Post> posts;
  PostsCarousel({
    super.key,
    required this.title,
    required this.pageController,
    required this.posts,
  });

  @override
  State<PostsCarousel> createState() => _PostsCarouselState();
}

class _PostsCarouselState extends State<PostsCarousel> {
  var _currPageValue = 0.0;

  var _scaleFactor = 0.8;

  var _height = 220;

  @override
  void initState() {
    super.initState();
    widget.pageController?.addListener(() {
      setState(() {
        _currPageValue = widget.pageController!.page!;
        //print('Curent page is ' + _currPageValue.toString());
      });
    });
  }

  // pageController already desposed in HomeScreen/ProfileScreen
  // dispose to avoid memory leaks
  /* @override
  void dispose() {
    super.dispose();
    widget.pageController!.dispose();
  } */

  Widget _buildPost(BuildContext context, int index) {
    // This is one way
    /* Post post = posts[index];
    return AnimatedBuilder(
      animation: pageController!,
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (pageController!.position.haveDimensions) {
          value = pageController!.page! - index;
          value = (1 - (value.abs() * 0.25)).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 400,
            child: child,
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: 400,
                width: double.infinity,
                image: AssetImage(post.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      post.location!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              post.likes.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              post.comments.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ); */

    // This is another way
    Post post = widget.posts[index];
    Matrix4 matrix = Matrix4.identity();
    // .floor() to get a round number
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      // right
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      // left
      //var currScale = _scaleFactor + (_currPageValue - index - 1) * (1 + _scaleFactor);
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      // 1:53:00
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: 400,
                width: double.infinity,
                image: AssetImage(post.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      post.location!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              post.likes.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              post.comments.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          // ignore: unnecessary_const
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 400,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.posts.length,
            itemBuilder: (ctx, index) {
              return _buildPost(ctx, index);
            },
          ),
        )
      ],
    );
  }
}
