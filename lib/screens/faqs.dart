
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/ui_helpers.dart';
import '../widgets/sexy_tile.dart';
import 'home.dart';

class FaQs extends StatefulWidget {
  @override
  _FaQsState createState() => _FaQsState();
}

class _FaQsState extends State<FaQs> {
  List<String> itemContent = [
    'Who Can Join Pasune',
    'Any organization implementing access to justice programs through \npara-legalism and any grouping of trained paralegals, who either have registered themselves as a legal entity i.e.CBO or CSO or have undertaken steps towards meeting the requirement of registering a legal entity.',
  ]; //

  List<String> itemContent1 = [
    'What are the requirements of Joining PASUNE',
    '1. A brief of the organization.\n2. Legal status of the organization and years in operation.\n'
        '3. Must have governance structure and share names and profile of \n    the board and management.'
        '\n4. Must be a local, national or international organization providing \n    legal aid through Para-legalism.'
        '\n5. Willingness and ability to contribute to the work of PASUNE and \n    abide by its rules.'
        '\n6. At-least three years of proven record of accomplishment of \n    operation in legal work.',
  ]; // the text in the tile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("FAQs"),
      centerTitle: true,),
      backgroundColor: Colors.green,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'tile2',
              child: SexyTile(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        itemContent[0],
                        style: TextStyle(color: Colors.green, fontSize: 24.0),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        itemContent[1],
                        style: isThemeCurrentlyDark(context)
                            ? BodyStylesDefault.white
                            : BodyStylesDefault.black,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                splashColor: MyColors.accent,
              ),
            ),
            SexyTile(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      itemContent1[0],
                      style: TextStyle(color: Colors.green, fontSize: 24.0),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      itemContent1[1],
                      style: isThemeCurrentlyDark(context)
                          ? BodyStylesDefault.white
                          : BodyStylesDefault.black,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              splashColor: MyColors.accent,
            ),
           ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(
          EvaIcons.checkmark,
          size: 30.0,
        ),
        tooltip: 'Accept',
        foregroundColor: invertInvertColorsStrong(context),
        backgroundColor: invertInvertColorsTheme(context),
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        },
      ),
    );
  }
}