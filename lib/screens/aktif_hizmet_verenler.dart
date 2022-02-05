import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';
import 'package:ustasi_yapsin/screens/talep_basarili.dart';

import '../screens_service_provider/hizmet_veren_profili.dart';

class AktifHizmetVerenler extends StatelessWidget {
  const AktifHizmetVerenler({Key? key}) : super(key: key);

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
            children: [HizmetVerenListe()],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class HizmetVerenListe extends StatefulWidget {
  const HizmetVerenListe({Key? key}) : super(key: key);

  @override
  _HizmetVerenListeState createState() => _HizmetVerenListeState();
}

class _HizmetVerenListeState extends State<HizmetVerenListe> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text(
                      'Şu an aktif olan hizmet verenler',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Tüm hizmet verenlerden yada istediğin hizmet verenlerden teklif alabilirsin',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: FlatButton(
                textColor: Colors.purple,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                  color: Colors.purple,
                  style: BorderStyle.solid,
                )),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TalepBasarili()),
                );
                },
                child: const Text('Tüm hizmet verenlerden teklif al'),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 550,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 8,
                              itemBuilder: (BuildContext context, int index) =>
                                  Card(
                                elevation: 0,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Card(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(90.0),
                                                        side: BorderSide(
                                                            width: 1,
                                                            color: Colors
                                                                .purpleAccent)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 5, 5, 5),
                                                      child: SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Image(
                                                              image: AssetImage(
                                                                  'assets/logo.png'))),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                'Ahmet Usta',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      5,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                'Boya Badana    7/24',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '3.5',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Container(
                                                                        width: 120,
                                                                        child: RatingBar.builder(
                                                                          initialRating:
                                                                              3.5,
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              true,
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              17,
                                                                          itemPadding:
                                                                              EdgeInsets.symmetric(horizontal: 2.0),
                                                                          itemBuilder: (context, _) =>
                                                                              Icon(
                                                                            Icons.star,
                                                                            size:
                                                                                2,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            print(rating);
                                                                          },
                                                                        ))),
                                                                Text(
                                                                  '14 Yorum',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => HizmetVerenProfil(
                                                                    id: "1",
                                                                    state: 1,
                                                                  )),
                                                                );
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .more_horiz,
                                                                    size:40,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500
                                                                  ),
                                                                  Text(
                                                                      'Profiline bak',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500, fontSize: 12))
                                                                ],
                                                              )))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
