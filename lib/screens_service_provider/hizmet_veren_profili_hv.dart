import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'isin_yapildigini_onayla_hv.dart';



class HizmetVerenProfilHv extends StatelessWidget {
  const HizmetVerenProfilHv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: SingleChildScrollView(
              child: Stack(
            children: [ProfilIcerik()],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class ProfilIcerik extends StatefulWidget {
  const ProfilIcerik({Key? key}) : super(key: key);

  @override
  _ProfilIcerikState createState() => _ProfilIcerikState();
}

class _ProfilIcerikState extends State<ProfilIcerik> {
  _makingPhoneCall() async {
    const url = 'tel:+90 5059948910';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text(
                'Hizmet veren profil',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ),
            Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0),
                                side: BorderSide(
                                    width: 1, color: Colors.purpleAccent)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image(
                                      image: AssetImage('assets/logo.png'))),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        'Ahmet Usta',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        'Boya Badana',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            '3.5',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Container(
                                                width: 120,
                                                child: RatingBar.builder(
                                                  initialRating: 3.5,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 17,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 2.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    size: 2,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ))),
                                        Text(
                                          '14 Yorum',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: FlatButton(
                                        onPressed: () {
                                          _makingPhoneCall();
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/cell_usta.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                            Text('Ara',
                                              style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 12))

                                          ],
                                        ))),
                                Container(
                                  height:60,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 0,
                                    width: 1,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HizmetVerenProfilHv()),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/message_usta.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                            Text('Mesaj gönder',
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontSize: 12)),
                                          ],
                                        ))),
                                Container(
                                  height:60,
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 0,
                                    width: 1,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HizmetVerenProfilHv()),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/favorite_add.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                            Text('Favorilere Ekle',
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontSize: 12)),
                                          ],
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 0,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Müşteri Yorumları',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                               fontSize: 12,)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                              'boya badana abababbababsdasdasdddddddddddddddddddddddddddddddddddsdsdsdsdsdsdsds',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                              'Tüm Yorumlara Bak ->',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0,
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Hakkında',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: 12,)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                              'boya badana abababbababsdasdasdddddddddddddddddddddddddddddddddddsdsdsdsdsdsdsds',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 10,
                      endIndent: 0,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                              'Referanslar',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                              'Tamamlanan iş : 26',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: Text(
                              ' ',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ));
  }
}
