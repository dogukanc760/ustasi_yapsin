import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../external_widgets/BottomNavigationBar_hv.dart';

String username = '';
String name = '';
String surname = '';
String adress = '';
String gsm = '';
String userId = '';
String responses = '';
String mail = '';
String sector = '';
String category = '';
String cities = '';
String distincts = '';
String worksDays = '';
String worksHours = '';

class Bakiyem extends StatefulWidget {
  const Bakiyem({Key? key}) : super(key: key);

  @override
  _BakiyemState createState() => _BakiyemState();
}

class _BakiyemState extends State<Bakiyem> {
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
            children: [BakiyemContent()],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class BakiyemContent extends StatefulWidget {
  const BakiyemContent({Key? key}) : super(key: key);

  @override
  _BakiyemContentState createState() => _BakiyemContentState();
}

class _BakiyemContentState extends State<BakiyemContent> {
  var isLoader = false;
  final walletTotal = TextEditingController(text: 'Hesap Bakiyem:0 ₺');
  final giftTotal = TextEditingController(text: 'Hediye Kredilerim:0 ₺');

  void getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoader = true;
      username = prefs.getString('username').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      gsm = prefs.getString('gsm').toString();
      userId = prefs.getString('id').toString();
      adress = prefs.getString('adress').toString();
      mail = prefs.getString('mail').toString();
      sector = prefs.getString('sector').toString();
      category = prefs.getString('category').toString();
      worksHours = prefs.getString('worksHours').toString();
      worksDays = prefs.getString('worksDays').toString();
      cities = prefs.getString('sectorCity').toString();
      distincts = prefs.getString('sectorDistinct').toString();
      cities = cities.replaceAll('"', '');
      cities = cities.replaceAll('[', '');
      cities = cities.replaceAll(']', '');
      sector = sector.replaceAll('"', '');
      sector = sector.replaceAll('[', '');
      sector = sector.replaceAll(']', '');
      worksHours = worksHours.replaceAll('"', '');
      worksHours = worksHours.replaceAll('[', '');
      worksHours = worksHours.replaceAll(']', '');
      worksDays = worksDays.replaceAll('"', '');
      worksDays = worksDays.replaceAll('[', '');
      worksDays = worksDays.replaceAll(']', '');
      distincts = distincts.replaceAll('"', '');
      distincts = distincts.replaceAll('[', '');
      distincts = distincts.replaceAll(']', '');
    });

    print(cities);
    setState(() {
      isLoader = false;
    });
  }
  @override
  void initState() {
    getSession();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        SingleChildScrollView(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.deepPurple,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight)),
                        child: CircleAvatar(
                          radius: 30.0,
                          /*backgroundImage:
                                      AssetImage('assets/ikon8.png'),*/
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Center(
                          child: Stack(children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                        ),
                        height: 140.0,
                        width: MediaQuery.of(context).size.width - 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            image: DecorationImage(
                                image:
                                    new AssetImage("assets/hesabim_kusak.png"),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.grey,
                              size: 23,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Profil()),
                                  // );
                                },
                                child: Text('Cüzdanım',
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                              child: Text('(Hv id)',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextFormField(
                        controller: walletTotal,
                        enableSuggestions: false,
                        autocorrect: false,
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            hintText: 'Hesap Bakiyem',
                            hintStyle: TextStyle(fontSize: 12)),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ad-Soyad Boş Geçilemez!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextFormField(
                        controller: giftTotal,
                        enableSuggestions: false,
                        autocorrect: false,
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            hintText: 'Hediye Kredilerim',
                            hintStyle: TextStyle(fontSize: 12)),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mail Boş Geçilemez!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Text('İBAN NO: TR 0001 1000 0100 0010',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(60, 10, 70, 0),
                        child: Text(
                            'hesap numaramıza havale veya eft yaparak kred yüklemes yapablrsnz hv d açıklama kısmında mutlaka belrtnz',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade500)),
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        )),
      ]),
    );
  }
}
