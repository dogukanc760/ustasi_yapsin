import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:ustasi_yapsin/models/demand.dart';
import 'package:ustasi_yapsin/screens_service_provider/hizmet_veren_profili.dart';
import 'package:http/http.dart' as http;
import '../screens_service_provider/hizmet_veren_profili.dart';

class isler extends StatefulWidget {
  const isler({Key? key}) : super(key: key);

  @override
  State<isler> createState() => _islerState();
}

class _islerState extends State<isler> {
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

final List<Demand> finished = [];
final List<Demand> moving = [];
String userId = "";
int totalCount = 0;
int resultCount = 0;
var isLoader = false;

class _HizmetVerenListeState extends State<HizmetVerenListe> {
  Future<void> getDemands() async {
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id').toString();
    print(userId + "denme");
    print(userId);
    moving.clear();
    finished.clear();
    print('https://ustasiyapsin-api.herokuapp.com/api/demand/get-by-company/' +
        userId);
    final response = await http.get(
      Uri.parse(
          'https://ustasiyapsin-api.herokuapp.com/api/demand/get-by-company/' +
              userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      //  print(result['data'][0]['_id']);

      for (var i = 0; i < result['data'].length; i++) {
        setState(() {
          if (result['data'][i]['status'] == 'finished' ||
              result['data'][i]['status'] == 'canceled') {
            finished.add(Demand(
                id: result['data'][i]['_id'],
                company: result['data'][i]['company'],
                user: result['data'][i]['user'],
                service: result['data'][i]['service'],
                location: result['data'][i]['location'],
                time: result['data'][i]['time'],
                date: result['data'][i]['date'],
                question: result['data'][i]['question'],
                answer: result['data'][i]['answer'],
                status: result['data'][i]['status'],
                isActive: result['data'][i]['isActive'],
                price: result['data'][i]['price'],
                offerDescription: result['data'][i]['offerDescription'],
                offerPrice: result['data'][i]['offerPrice']));
          } else if (result['data'][i]['status'] == 'moving') {
            moving.add(Demand(
                company: result['data'][i]['company'],
                id: result['data'][i]['_id'],
                user: result['data'][i]['user'],
                service: result['data'][i]['service'],
                location: result['data'][i]['location'],
                time: result['data'][i]['time'],
                date: result['data'][i]['date'],
                question: result['data'][i]['question'],
                answer: result['data'][i]['answer'],
                status: result['data'][i]['status'],
                isActive: result['data'][i]['isActive'],
                price: result['data'][i]['price'],
                offerDescription: result['data'][i]['offerDescription'],
                offerPrice: result['data'][i]['offerPrice']));
          }
        });
      }
     
      setState(() {
        isLoader = false;
        resultCount = result['data'].length;
      });
    } else {
      setState(() {
         isLoader = false;
        resultCount = 0;
      });
      throw Exception().toString();
    }
  }

  @override
  void initState() {
    super.initState();
    print("burasi init");
    //WidgetsBinding.instance.addPostFrameCallback((_) {getDemands();});
    getDemands();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: isLoader
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                child: Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              )
            : resultCount < 1
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                    child: Column(
                      children: [
                        Center(),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hali Hazırda Bekleyen İşiniz Yok.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                  )
                : Column(
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
                                'Yapılmayı Beklenen işler',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
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
                                        itemCount: moving.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Card(
                                          elevation: 0,
                                          child: Center(
                                              child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
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
                                                                          .circular(
                                                                              90.0),
                                                                  side: BorderSide(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .purpleAccent)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5,
                                                                        5,
                                                                        5,
                                                                        5),
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
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          moving[index].service[0][2].toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                           moving[index].service[0][0].toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 10),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                5,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              '3.5',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.black, fontSize: 13),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                              child: Container(
                                                                                  width: 120,
                                                                                  child: RatingBar.builder(
                                                                                    initialRating: 3.5,
                                                                                    minRating: 1,
                                                                                    direction: Axis.horizontal,
                                                                                    allowHalfRating: true,
                                                                                    itemCount: 5,
                                                                                    itemSize: 17,
                                                                                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                                                    itemBuilder: (context, _) => Icon(
                                                                                      Icons.star,
                                                                                      size: 2,
                                                                                      color: Colors.amber,
                                                                                    ),
                                                                                    onRatingUpdate: (rating) {
                                                                                      print(rating);
                                                                                    },
                                                                                  ))),
                                                                          Text(
                                                                            '0 Yorum',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 12),
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
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => HizmetVerenProfil(
                                                                              id: moving[index].id,
                                                                              state: 3,
                                                                            )),
                                                                          );
                                                                        },
                                                                        child: Column(
                                                                          children: [
                                                                            Icon(Icons.more_horiz,
                                                                                size: 40,
                                                                                color: Colors.grey.shade500),
                                                                            Text('Profiline bak',
                                                                                style: TextStyle(color: Colors.grey.shade500, fontSize: 12))
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
