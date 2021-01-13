import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../utils/intro_item.dart';
import 'login_page.dart';

SwiperController _controller = SwiperController();
int _currentIndex = 0;
final List<String> titles = [
  "Welcome",
  "Paralegal Society of Kenya",
  "Paralegal Society of Kenya",
];
final List<String> subtitles = [
  "Welcome to this awesome Paralegal Society of Kenya mobile app.",
  "This is a coalition of Civil Society Organizations undertaking paralegal initiatives as a means of enhancing access to justice in Kenya. ",
  "A Kenya where there is access to justice for all, observation of the rule of law and adherence to democratic principles and tenets."
];
final List<Color> colors = [
  Colors.green.shade300,
  Colors.blue.shade300,
  Colors.indigo.shade300,
];
class IntroScreens extends StatefulWidget {
  @override
  _IntroScreensState createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            loop: false,
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _controller,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red,
                activeSize: 20.0,
              ),
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return IntroItem(
                title: titles[index],
                subtitle: subtitles[index],
                bg: colors[index],
                imageUrl: "assets/images/${index + 1}.png",
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FlatButton(
              child: Text("Skip"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon:
              Icon(_currentIndex == 2 ? Icons.check : Icons.arrow_forward),
              onPressed: () {
                if (_currentIndex != 2) { _controller.next();}
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                LoginPage();
              },
            ),
          )
        ],
      ),
    );
  }
}
