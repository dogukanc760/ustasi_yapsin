import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';
import 'package:ustasi_yapsin/models/demand.dart';
import 'package:ustasi_yapsin/screens/hizmet_alan_teklif_kabul.dart';
import 'package:ustasi_yapsin/screens/is_neden_iptal_edildi.dart';
import 'package:ustasi_yapsin/screens/isin_yapildigini_onayla.dart';

final List<Demand> finished = [];
final List<Demand> moving = [];
String userId = "";
int totalCount = 0;

class TalepDurumu extends StatelessWidget {
  final int state;
  final String id;
  const TalepDurumu({required this.state, required this.id}) : super();

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
            children: [TalepIcerik(state: this.state)],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class TalepIcerik extends StatefulWidget {
  final int state;

  const TalepIcerik({required this.state}) : super();

  @override
  _TalepIcerikState createState() => _TalepIcerikState();
}

class _TalepIcerikState extends State<TalepIcerik> {
  int resultCount = 0;
  var isLoader = false;
  void getSession() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id').toString();
    print(userId + "denme");
  }

  Future<void> getDemands() async {
    moving.clear();
    finished.clear();
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id').toString();
    print(userId + "denme");
    print(userId);
    moving.clear();
    finished.clear();
    print('https://ustasiyapsin-api.herokuapp.com/api/demand/get-by-user/' +
        userId);
    final response = await http.get(
      Uri.parse(
          'https://ustasiyapsin-api.herokuapp.com/api/demand/get-by-user/' +
              userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      print(result['data']);

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
            resultCount = finished.length;
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
            resultCount = moving.length;
          }
        });
      }
      setState(() {
        isLoader = false;
      });
    } else {
      resultCount = 0;
      isLoader = false;
      throw Exception().toString();
    }
  }

  @override
  dynamic x;
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
                    ),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                  child: Row(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                          side:
                              BorderSide(width: 1, color: Colors.purpleAccent),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image(
                              image: AssetImage('assets/logo.png'),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: moving.length,
                            itemBuilder: (BuildContext context, int index) =>
                                moving.length > 0
                                    ? SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                moving[index]
                                                    .service[0][2]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text(
                                                moving[index]
                                                    .service[0][0]
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Container(
                                                    width: 120,
                                                    child: RatingBar.builder(
                                                      initialRating: 3.5,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 17,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        size: 2,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '14 Yorum',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 2, 0, 0),
                                                  child: widget.state == 4
                                                      ? Column(
                                                          children: [
                                                            Text(
                                                              '1500 ₺',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child: Text(
                                                                'Teklif',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .blueAccent),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : widget.state == 1
                                                          ? Text(
                                                              'Teklif Bekliyor',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10),
                                                            )
                                                          : Text(
                                                              'Kabul Edildi',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .deepPurple,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10),
                                                            ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(''),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Text('Merkezefendi / Denizli',
                          style: TextStyle(color: Colors.black87, fontSize: 12))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Text('Hizmet verenler arayabilir',
                          style: TextStyle(color: Colors.black87, fontSize: 12))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.more_time_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Text('İşim acil (hemen)',
                          style: TextStyle(color: Colors.black87, fontSize: 12))
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Neresi Boyanacak?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text('90 metre kare ev boyanacak',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Boyanacak alan kaç oda?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text('Boyanacak alan 3 oda',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Tavan boyanacak mı?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text('Tavan Boyanacak',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Fiyata Malzeme Dahil?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text('Fiyata Malzeme Dahil',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Fiyata Malzeme Dahil?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text('Fiyata Malzeme Dahil',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Fiyata Malzeme Dahil?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text('Fiyata Malzeme Dahil',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Text('Fiyata Malzeme Dahil?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                              'Fiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme DahilFiyata Malzeme Dahil',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        widget.state == 1
                            ? FlatButton(
                                minWidth: 250,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IsIptalEdildi()));
                                },
                                child: Text('İptal Et',
                                    style:
                                        TextStyle(color: Colors.grey.shade600)),
                                color: Colors.grey.shade400,
                              )
                            : widget.state == 2
                                ? Column(
                                    children: [
                                      FlatButton(
                                        minWidth: 250,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      IsinYapildiginiOnayla()));
                                        },
                                        child: Text('İşin Yapıldığını Onayla',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.deepPurple,
                                      ),
                                      FlatButton(
                                        minWidth: 250,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      IsIptalEdildi()));
                                        },
                                        child: Text('İptal Et',
                                            style: TextStyle(
                                                color: Colors.grey.shade600)),
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                  )
                                : widget.state == 2
                                    ? Column(
                                        children: [
                                          FlatButton(
                                            minWidth: 250,
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          IsinYapildiginiOnayla()));
                                            },
                                            child: Text(
                                                'İşin Yapıldığını Onayla',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            color: Colors.deepPurple,
                                          ),
                                          FlatButton(
                                            minWidth: 250,
                                            onPressed: () {},
                                            child: Text('İptal Et',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade600)),
                                            color: Colors.grey.shade400,
                                          ),
                                        ],
                                      )
                                    : widget.state == 4
                                        ? Row(
                                            children: [
                                              FlatButton(
                                                minWidth: 100,
                                                onPressed: () {},
                                                child: Text('İptal Et',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600)),
                                                color: Colors.grey.shade400,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                child: FlatButton(
                                                  minWidth: 100,
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TalepKabul()));
                                                  },
                                                  child: Text('Kabul Et',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  color: Colors.deepPurple,
                                                ),
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
