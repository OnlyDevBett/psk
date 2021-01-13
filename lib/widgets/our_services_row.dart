import 'package:flutter/material.dart';
import 'package:paralegal_society_of_kenya/models/services.dart';

// ignore: must_be_immutable
class OurServicesRow extends StatelessWidget {
  PageController pageController = new PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 630.0,
      width: double.infinity,
      child: new PageView(
          controller: pageController,
          children: services.map((Services service) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                        offset: new Offset(0.0, 2.0)),
                  ],
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    new Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 5.0, top: 10.0),
                      child: new Text(service.title,
                          style: const TextStyle(fontSize: 23.0),
                          textAlign: TextAlign.center),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                      child: new Text(service.content, textAlign: TextAlign.justify,),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
