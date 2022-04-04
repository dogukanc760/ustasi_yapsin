import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:ustasi_yapsin/models/demand.dart';
import 'package:http/http.dart' as http;

import 'isin_yapildigini_onayla_hv.dart';



class HizmetVerenProfil extends StatefulWidget {
  final int state;
  final String id;
  HizmetVerenProfil({required this.state, required this.id}) : super();

  @override
  State<HizmetVerenProfil> createState() => _HizmetVerenProfilState();
}

class _HizmetVerenProfilState extends State<HizmetVerenProfil> {
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
            children: [ProfilIcerik(state: widget.state, context: context, demandId: widget.id,)],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}
int states = 0;
List<Demand> demandDetail = [];
class ProfilIcerik extends StatefulWidget {
  final int state;
  BuildContext context;
  final String demandId;

  ProfilIcerik(
      {required this.state, required this.context, required this.demandId})
      : super();
  @override
  _ProfilIcerikState createState() => _ProfilIcerikState();
}

class _ProfilIcerikState extends State<ProfilIcerik> {
  var isLoader = false;
  _makingPhoneCall() async {
    const url = 'tel:+90 123123123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> getDemands() async {
    setState(() {
      isLoader = true;
    });
    print(widget.demandId + " aydiii");
    demandDetail.clear();
    print("fonksiyon başladı");
    final response = await http.get(
      Uri.parse(
          'https://ustasiyapsin-api.herokuapp.com/api/demand/' + widget.demandId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      print('deneme');
      var result = jsonDecode(response.body);
      setState(() {
        demandDetail.add(Demand(
            id: result['data']['_id'],
            company: result['data']['company'],
            user: result['data']['user'],
            service: result['data']['service'],
            location: result['data']['location'],
            time: result['data']['time'],
            date: result['data']['date'],
            question: result['data']['question'],
            answer: result['data']['answer'],
            status: result['data']['status'],
            isActive: result['data']['isActive'],
            price: result['data']['price'],
            offerDescription: result['data']['offerDescription'],
            offerPrice: result['data']['offerPrice']));
        print(demandDetail[0].company);
        isLoader=false;
      });
    } else {
      throw Exception().toString();
    }
  }

 @override
  void initState() {
    print('dodo');
    print(widget.state);
    getDemands();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child:  isLoader
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
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text(
                'Taleplerim',
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
                                         demandDetail[0].service[0][2].toString(),
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
                                        demandDetail[0].service[0][0].toString(),
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
                                          '0 Yorum',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Padding(padding: const EdgeInsets.fromLTRB(35,0,0,0),
                                          child:
                                          demandDetail[0].status == 'moving'?
                                           Text(
                                            'Teklif bekleniyor',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12),
                                          ):Text(
                                            'Devam Ediyor',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12),
                                          )
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
                                        MediaQuery.of(context).size.width / 2,
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
                                      const EdgeInsets.fromLTRB(0,10, 0, 10),
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
                                        MediaQuery.of(context).size.width / 2,
                                    child: FlatButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           HizmetVerenProfil()),
                                          // );
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
                      Padding( padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Image.asset(
                          'assets/message_usta.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 0, 0),
                          child: Text(
                             demandDetail[0].location[0][1].toString()+'/'+demandDetail[0].location[0][0].toString(),
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
                      Padding( padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Image.asset(
                          'assets/cell_usta.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 0, 0),
                          child: Text(
                              'Hizmet Verenler Arayabilir',
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
                      Padding( padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Image.asset(
                          'assets/cell_usta.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 10, 0, 0),
                          child: Text(
                              'İşim acil (hemen)',
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
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      height:150,
                       width: MediaQuery.of(context).size.width - 50,
                      child: ListView.builder(
                        itemCount: demandDetail[0].question[0].length,
                        itemBuilder:(BuildContext context, int index){
                         return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text( demandDetail[0].question[0][index].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 10)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(demandDetail[0].answer[0][index].toString(),
                                      style: TextStyle( color: Colors.black,
                                        fontSize: 10,)),
                                )
                              ],
                            ),
                          ],
                        );
                      
                        } ),
                    ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 30),
              child: widget.state==2?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,15,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 175,
                            child: FlatButton(
                                onPressed: () {
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TalepBasarili()),
                                  );*/
                                },
                                color: Colors.grey[300],
                                child: Text(
                                  'İptal Et',
                                  style: TextStyle(color: Colors.grey,fontSize: 17,),
                                ))),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,15,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 175,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => IsinYapildiginiOnaylaHv()),
                                    );
                                  },
                                  color: Colors.deepPurple,
                                  child: Text(
                                    'Teklif Ver',
                                    style: TextStyle(color: Colors.white,fontSize: 17,),
                                  ))),

                        ],
                      ),
                    ),
                  )
                ],
              ):widget.state==3?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,15,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 175,
                            child: FlatButton(
                                onPressed: () {
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TalepBasarili()),
                                  );*/
                                },
                                color: Colors.grey[300],
                                child: Text(
                                  'İptal Et',
                                  style: TextStyle(color: Colors.grey,fontSize: 17,),
                                ))),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,15,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 175,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => IsinYapildiginiOnaylaHv()),
                                    );
                                  },
                                  color: Colors.deepPurple,
                                  child: Text(
                                    'Teklif Ver',
                                    style: TextStyle(color: Colors.white,fontSize: 14,),
                                  ))),

                        ],
                      ),
                    ),
                  )
                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,15,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 175,
                            child: FlatButton(
                                onPressed: () {
                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TalepBasarili()),
                                  );*/
                                },
                                color: Colors.grey[300],
                                child: Text(
                                  'İptal Et',
                                  style: TextStyle(color: Colors.grey,fontSize: 17,),
                                ))),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,15,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 175,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => IsinYapildiginiOnaylaHv()),
                                    );
                                  },
                                  color: Colors.deepPurple,
                                  child: Text(
                                    'Teklif İste',
                                    style: TextStyle(color: Colors.white,fontSize: 17,),
                                  ))),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
