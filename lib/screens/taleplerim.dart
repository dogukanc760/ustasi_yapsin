import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';
import 'package:ustasi_yapsin/models/demand.dart';
import 'package:ustasi_yapsin/screens/talep_durumu.dart';

final List<Demand> finished = [];
final List<Demand> moving = [];
String userId = "";
int totalCount = 0;

class Taleplerim extends StatelessWidget {
  const Taleplerim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          /*title: Center(child: Text('Taleplerim', style:TextStyle(color:Colors.deepPurple, fontSize: 12))),*/
          elevation: 0,
          toolbarHeight: 1,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.deepPurple,
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text(
                'Açık İşlerim',
                style: TextStyle(color: Colors.deepPurple),
              ),
              Text(
                'Bitmiş İşlerim',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[TalepDurumlarim(), TalepBitenlerim()],
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

int resultCount = 0;
var isLoader = false;
void getSession() async {
  final prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('id').toString();
  print(userId + "denme");
}

class TalepDurumlarim extends StatefulWidget {
  const TalepDurumlarim({Key? key}) : super(key: key);

  @override
  _TalepDurumlarimState createState() => _TalepDurumlarimState();
}

class _TalepDurumlarimState extends State<TalepDurumlarim> {
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
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.bottom -
                          170,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: moving.length,
                        itemBuilder: (BuildContext context, int index) => moving
                                    .length >
                                0
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(90.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: Colors.purpleAccent)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Image(
                                            image:
                                                AssetImage('assets/logo.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 0),
                                                    child: Text(
                                                      '3.5',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
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
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    2.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          size: 2,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
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
                                                  SizedBox(
                                                    width: 80,
                                                    height: 35,
                                                    child: index == 1
                                                        ? TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TalepDurumu(
                                                                          state:
                                                                              4,
                                                                          id: finished[index]
                                                                              .id),
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              moving[index]
                                                                  .price
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : index % 2 == 0
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              TalepDurumu(
                                                                        state:
                                                                            1,
                                                                        id: finished[index]
                                                                            .id,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  'Teklif Bekliyor',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .deepPurple),
                                                                ),
                                                              )
                                                            : TextButton(
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => TalepDurumu(
                                                                          state:
                                                                              2,
                                                                          id: finished[index]
                                                                              .id),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  moving[index]
                                                                      .price
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
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
                              )
                            : Text(''),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class TalepBitenlerim extends StatefulWidget {
  const TalepBitenlerim({Key? key}) : super(key: key);

  @override
  _TalepBitenlerimState createState() => _TalepBitenlerimState();
}

class _TalepBitenlerimState extends State<TalepBitenlerim> {
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.bottom -
                          170,
                      child: finished.length > 1
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: finished.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(90.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: Colors.purpleAccent)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Text(
                                                  finished[index]
                                                      .service[0][2]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                child: Text(
                                                  finished[index]
                                                      .service[0][0]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 0),
                                                    child: Text(
                                                      '3.5',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
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
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    2.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          size: 2,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
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
                                                  SizedBox(
                                                    width: 80,
                                                    child: FlatButton(
                                                      onPressed: () {},
                                                      child: Column(
                                                        children: [
                                                          finished[index]
                                                                      .status ==
                                                                  'finished'
                                                              ? TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => TalepDurumu(
                                                                            state:
                                                                                2,
                                                                            id: finished[index].id),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      "Tamamlandı",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Color(
                                                                            0xFFEB3A18),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : finished[index]
                                                                          .status ==
                                                                      'cancelled'
                                                                  ? TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                TalepDurumu(state: 13, id: finished[index].id),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'İptal Edildi',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Color(0xFFEB3A18),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                TalepDurumu(state: 2, id: finished[index].id),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'İptal Edildi',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Color(0xFFEB3A18),
                                                                        ),
                                                                      ),
                                                                    ),
                                                          Icon(
                                                            Icons
                                                                .restore_from_trash,
                                                            color: Colors
                                                                .grey.shade400,
                                                          ),
                                                          Text(
                                                            'İptal Edildi',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10),
                                                          )
                                                        ],
                                                      ),
                                                    ),
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
                              ),
                            )
                          : Text(''),
                    ),
                  ],
                ),
    );
  }
}
