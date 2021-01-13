import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OurPartners extends StatefulWidget {
  @override
  _OurPartnersState createState() => _OurPartnersState();
}

class _OurPartnersState extends State<OurPartners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Our Partners"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400.0,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Material(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3).withOpacity(0.2),
                            child: _nameDetailsContainer(),
                          ),
                          back: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: _socialContainer(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400.0,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Material(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3).withOpacity(0.2),
                            child: _nameDetailsContainer1(),
                          ),
                          back: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: _socialContainer1(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400.0,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Material(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3).withOpacity(0.2),
                            child: _nameDetailsContainer2(),
                          ),
                          back: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: _socialContainer2(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 6.0,
                    shadowColor: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 400.0,
                          child: FlipCard(
                            direction: FlipDirection.HORIZONTAL, // default
                            front: Material(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(24.0),
                              shadowColor: Color(0x802196F3).withOpacity(0.2),
                              child: _nameDetailsContainer3(),
                            ),
                            back: Material(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(24.0),
                              shadowColor: Color(0x802196F3),
                              child: _socialContainer3(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _nameDetailsContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: 90.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      leading: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "assets/images/lrf.png",
                                ),
                              ))),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('Legal Resources Foundation',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          Container(
            child: _detailsContainer(),
          ),
        ],
      ),
    );
  }

  Widget _detailsContainer() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
          child: Text(
            'The Legal Resources Foundation Trust (LRF) is an independent, '
            'human rights organization that promotes access to justice through human rights education, '
            'research and policy advocacy initiatives which was founded in 1993. '
            'LRF’s mission is to harness the collaborative benefits of strategic partnerships '
            'with the justice system for holistic participatory interventions towards justice, '
            'equity and resilience in communities. LRF partners with state and non-state actors at '
            'national and regional levels to promote legal literacy, action research and policy advocacy. ',
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _socialContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 90.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListTile(
                    leading: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage("assets/images/lrf.png",),
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Social Links',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          Container(
            child: _socialdetailsContainer(),
          ),
        ],
      ),
    );
  }

  Widget _socialdetailsContainer() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@lrf',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.linkedin,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@lrf',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@lrf',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget _nameDetailsContainer1() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 9.0,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: 90.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      leading: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "assets/images/icj.png",
                                ),
                              ))),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('International Commission of Jurists',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          Container(
            child: _detailsContainer1(),
          ),
        ],
      ),
    );
  }

  Widget _detailsContainer1() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
          child: Text(
            "The Kenyan Section of the International Commission of Jurists (ICJ Kenya) was established in 1959.It is an autonomous national section of the International Commission of Jurists, based in Geneva, Switzerland. ICJ Kenya is a not for profit, non-partisan, membership organization. ICJ Kenya's vision is a just, free and equitable society and its mission is to protect human rights, and promote the rule of law, justice and democracy in Kenya and across Africa through the application of legal expertise and international best practices.The organization uses advocacy, research, litigation, capacity building, awareness creation,partnerships and coalition building to achieve its objectives.",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _socialContainer1() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 90.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListTile(
                    leading: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    new AssetImage("assets/images/icj.png")))),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Social Links',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          Container(
            child: _socialdetailsContainer1(),
          ),
        ],
      ),
    );
  }

  Widget _socialdetailsContainer1() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@icj',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.linkedin,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@icj',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@icj',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget _nameDetailsContainer2() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 9.0,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: 90.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      leading: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "assets/images/kcs.png",
                                ),
                              ))),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('Kituo Cha Sheria',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          Container(
            child: _detailsContainer2(),
          ),
        ],
      ),
    );
  }

  Widget _detailsContainer2() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
          child: Text(
            'KITUO CHA SHERIA is a human rights non-governmental organisation committed to helping the disadvantaged, poor and marginalized people in Kenya who cannot afford the cost of legal services. Kituo was the first legal aid center established in Kenya in 1973.  Its mission is to empower the poor and marginalized people to effectively access justice and realize human and peoples rights through Advocacy, networking, lobbing, legal representation and legal air, legal education and research. ',
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _socialContainer2() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 90.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListTile(
                    leading: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    new AssetImage("assets/images/kcs.png")))),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Social Links',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          Container(
            child: _socialdetailsContainer2(),
          ),
        ],
      ),
    );
  }

  Widget _socialdetailsContainer2() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@kcs',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.linkedin,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@kcs',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@kcs',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget _nameDetailsContainer3() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 9.0,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: 90.0,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      leading: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "assets/images/ecjp.png",
                                ),
                              ))),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text('Ecumenical Centre for Peace and Justice',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          Container(
            child: _detailsContainer3(),
          ),
        ],
      ),
    );
  }

  Widget _socialContainer3() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 90.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListTile(
                    leading: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    new AssetImage("assets/images/ecjp.png")))),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Social Links',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          Container(
            child: _socialdetailsContainer3(),
          ),
        ],
      ),
    );
  }

  Widget _detailsContainer3() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
          child: Text(
            'Ecumenical Centre for Peace and Justice is (ECJP) was established to contribute to good governance and the democratization process, promotion and protection of human rights, peace building and sustainable socio-economic justice in Kenya through advocacy, civic education, oversight and accountability.  The Centre’s main goal envisages an informed citizenry playing active role in the governance process, exercising her/his oversight role and responsibilities and making positive contribution to national development.',
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _socialdetailsContainer3() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@ecjp',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.linkedin,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@ecjp',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
              child: Row(
            children: <Widget>[
              Container(
                  child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.green,
                size: 30.0,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  child: Text(
                    '@ecjp',
                    style: TextStyle(
                      color: Color(0xffff0d41),
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
