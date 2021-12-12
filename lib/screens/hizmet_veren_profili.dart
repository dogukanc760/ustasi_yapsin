import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustasi_yapsin/screens/talep_basarili.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class HizmetVerenProfil extends StatelessWidget {
  const HizmetVerenProfil({Key? key}) : super(key: key);

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
                'Hizmet veren profili',
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
                                        'Boya Badana    Merkezefendi / Denizli',
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
                                  height: 60,
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
                                                    HizmetVerenProfil()),
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
                                  height: 60,
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
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HizmetVerenProfil()),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
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
                              'Lorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor set',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          color: Colors.white,
                          child: TextButton(
                              onPressed: () {},
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Tüm yorumlara bak ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    WidgetSpan(
                                      child: Icon(Icons.arrow_forward_rounded,
                                          size: 15),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                  Container(
                    height: 0,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
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
                              'Lorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor setLorem ipsum dolor set',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          color: Colors.white,
                          child: TextButton(
                              onPressed: () {},
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Tüm yorumlara bak ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    WidgetSpan(
                                      child: Icon(Icons.arrow_forward_rounded,
                                          size: 15),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                  Container(
                    height: 0,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Referanslar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                          child: Text('Tamamlanan iş : 26',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                            child: Image(
                                image: NetworkImage(
                              'https://cdn.webtekno.com/media/cache/content_detail_v2/article/77463/bmw-m8-competition-0-dan-100-km-s-hiza-2-8-saniyede-cikmayi-basardi-video-1570632961.jpg',
                            ))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                            child: Image(
                                image: NetworkImage(
                              'https://cdn.webtekno.com/media/cache/content_detail_v2/article/77463/bmw-m8-competition-0-dan-100-km-s-hiza-2-8-saniyede-cikmayi-basardi-video-1570632961.jpg',
                            ))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                            child: Image(
                                image: NetworkImage(
                              'https://cdn.webtekno.com/media/cache/content_detail_v2/article/77463/bmw-m8-competition-0-dan-100-km-s-hiza-2-8-saniyede-cikmayi-basardi-video-1570632961.jpg',
                            ))),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                            child: Image(
                                image: NetworkImage(
                              'https://cdn.webtekno.com/media/cache/content_detail_v2/article/77463/bmw-m8-competition-0-dan-100-km-s-hiza-2-8-saniyede-cikmayi-basardi-video-1570632961.jpg',
                            ))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                            child: Image(
                                image: NetworkImage(
                              'https://cdn.webtekno.com/media/cache/content_detail_v2/article/77463/bmw-m8-competition-0-dan-100-km-s-hiza-2-8-saniyede-cikmayi-basardi-video-1570632961.jpg',
                            ))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 7, 0, 0),
                            child: Image(
                                image: NetworkImage(
                              'https://cdn.webtekno.com/media/cache/content_detail_v2/article/77463/bmw-m8-competition-0-dan-100-km-s-hiza-2-8-saniyede-cikmayi-basardi-video-1570632961.jpg',
                            ))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,15,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TalepBasarili()),
                                  );
                                },
                                color: Colors.deepPurple,
                                child: Text(
                                  'Teklif İste',
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
