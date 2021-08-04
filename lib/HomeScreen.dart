import 'package:flutter/material.dart';
import 'package:flutterparallax/Data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Vincent\nvan Gogh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '30 March 1853-29 July 1890',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Vincent Willem van Gogh was a Dutch post-impressionist painter who posthumously became one of the most famous and influential figures in the history of Western art.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      'Highlight Paintings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ScrollableParallax(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollableParallax extends StatefulWidget {
  const ScrollableParallax({
    Key? key,
  }) : super(key: key);

  @override
  _ScrollableParallaxState createState() => _ScrollableParallaxState();
}

class _ScrollableParallaxState extends State<ScrollableParallax> {
  late PageController _pageController;

  double _pageOffset = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.7);

    _pageController.addListener(() {
      setState(() {
        _pageOffset = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: paintings.length,
      itemBuilder: (context, idx) => Transform.scale(
        scale: 1,
        child: Container(
          padding: const EdgeInsets.only(right: 20),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ImageAsset(
                  pageOffset: _pageOffset,
                  idx: idx,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Text(
                  paintings[idx]['name'],
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      controller: _pageController,
    );
  }
}

class ImageAsset extends StatelessWidget {
  const ImageAsset({
    Key? key,
    required double pageOffset,
    this.idx,
  })  : _pageOffset = pageOffset,
        super(key: key);

  final double _pageOffset;
  final idx;
  double get _offsetResutl => -_pageOffset.abs() + idx;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      paintings[idx]['image'],
      height: 370,
      fit: BoxFit.cover,
      alignment: Alignment(_offsetResutl, 0),
    );
  }
}
