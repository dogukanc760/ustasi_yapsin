import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';

import 'package:ustasi_yapsin/models/conversations.dart';
import 'package:ustasi_yapsin/models/demand.dart';
import 'package:ustasi_yapsin/screens/hizmetAlanMesaj_giris.dart';
import 'package:http/http.dart' as http;

List<Conversations> conversations = [];
String userId = "";
int totalCount = 0;
var isLoading = false;

class Mesajlasma extends StatelessWidget {
  const Mesajlasma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF7D08D2),
            bottom: TabBar(
              indicatorWeight: 10,
              indicatorColor: Colors.purple.shade200,
              unselectedLabelColor: Colors.white,
              tabs: <Widget>[
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mesajlarım',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Tekliflerim',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
              ],
            ),
            title: Text('Mesaj Kutusu'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white, //Color(0xFFE1B9FF),
          body: TabBarView(
            children: [MesajlasmaExtends(), tekliflerimExtends()],
          ),
          bottomNavigationBar: NavigationBottom(),
        ),
      ),
    );
  }
}

class MesajlasmaExtends extends StatefulWidget {
  const MesajlasmaExtends({Key? key}) : super(key: key);

  @override
  _MesajlasmaExtendsState createState() => _MesajlasmaExtendsState();
}

class _MesajlasmaExtendsState extends State<MesajlasmaExtends> {
  getSession() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id').toString();
    print(userId);
    getConversations(userId);
  }

  Future<void> getConversations(String userObject) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/conversations/' +
          userObject),
    );
    print('https://ustasiyapsin-api.herokuapp.com/api/conversations/' +
        userObject);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result);
      conversations.clear();
      setState(() {
        for (var i = 0; i < result.length; i++) {
          conversations.add(Conversations(
              targetName: result[i]['targetName'],
              members: result[i]['members'].cast<String>(),
              convId: result[i]['_id']));
        }
        isLoading = false;
        totalCount = result.length;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Center(child: CircularProgressIndicator()),
            )
          : totalCount < 1
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                  child: Column(
                    children: [
                      Center(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hali Hazırda Bekleyen Mesajınız Yok.',
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
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.bottom -
                            240,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: conversations.length,
                          itemBuilder: (BuildContext context, int index) => 5 >
                                  0
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: InkWell(
                                    //Inkwell'in aşağıda onTap'i var oraya ekleme yapabilirsin.
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 5,
                                            blurRadius: 8,
                                            offset: Offset(0,
                                                10), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: 300,
                                      height: 80,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90.0),
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Colors.lightBlue)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                        image: AssetImage(
                                                            'assets/logo.png'))),
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
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 15, 0, 0),
                                                      child: Text(
                                                        conversations[index]
                                                            .targetName,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 12.0),
                                                          child: Icon(
                                                            Icons
                                                                .adjust_outlined,
                                                            color: Colors.green,
                                                            size: 15,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 10, 0, 0),
                                                          child: Container(
                                                            child: Text(
                                                              ' - Son gönderileen mesaj...',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                              ),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 75.0),
                                            child: Text('08.50 PM'),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => mesajGiris(
                                            conversationId:
                                                conversations[index].convId,
                                            targetUser:
                                                conversations[index].targetName,
                                          ),
                                        ),
                                      );
                                    }, //TIKLAYINCA MESAJ İÇERİĞİ AÇILACAK
                                  ),
                                )
                              : Text(''),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

class tekliflerimExtends extends StatefulWidget {
  const tekliflerimExtends({Key? key}) : super(key: key);

  @override
  _tekliflerimExtendsState createState() => _tekliflerimExtendsState();
}

class _tekliflerimExtendsState extends State<tekliflerimExtends> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.bottom -
                  240,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 0,
                itemBuilder: (BuildContext context, int index) => 5 > 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: InkWell(
                          //Inkwell'in aşağıda onTap'i var oraya ekleme yapabilirsin.
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 300,
                            height: 80,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                        side: BorderSide(
                                            width: 1, color: Colors.lightBlue)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image(
                                          image: AssetImage('assets/logo.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Text(
                                              'Ad - Soyad',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0),
                                                child: Icon(
                                                  Icons.adjust_outlined,
                                                  color: Colors.green,
                                                  size: 15,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Container(
                                                  child: Text(
                                                    ' - Son gönderilen mesaj...',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                    ),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 75.0),
                                  child: Text('08.50 PM'),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => mesajGiris(),
                            //   ),
                            // );
                          }, //TIKLAYINCA MESAJ İÇERİĞİ AÇILACAK
                        ),
                      )
                    : Text(''),
              ),
            ),
          )
        ],
      ),
    );
  }
}
