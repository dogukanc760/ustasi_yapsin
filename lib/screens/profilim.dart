import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';
import 'package:http/http.dart' as http;

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

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
            children: [Profilim()],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class Profilim extends StatefulWidget {
  const Profilim({Key? key}) : super(key: key);

  @override
  _ProfilimState createState() => _ProfilimState();
}
String username = '';
  String name = '';
  String surname = '';
  String adress = '';
  String gsm = '';
  String userId = '';
  String responses = '';
  String mail = '';
class _ProfilimState extends State<Profilim> {
 

  
  var isLoader = false;
  void getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      gsm = prefs.getString('gsm').toString();
      userId = prefs.getString('id').toString();
      adress = prefs.getString('adress').toString();
      mail = prefs.getString('mail').toString();
    });

    print(userId + username + name);
  }
   final nameController = TextEditingController(text:name);
  final mailController = TextEditingController(text:username);
  final gsmController = TextEditingController(text:gsm);

  Future<String> login(String mail, String gsm, String name) async {
    setState(() {
      isLoader = true;
    });
  final response = await http.put(
    Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/user/'+userId),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'gsm': mail, 'mail': mail, 'name': name}),
  );

  if (response.statusCode == 201) {
    print(response.statusCode);
    setState(() {
        responses = '201';
    });
  
    isLoader = false;
    return '201';

  } else {
    isLoader = false;
    return '500';
    throw Exception();
  }
}

  @override
  void initState() {
    getSession();
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child:  isLoader
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                child: Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Güncelleme Yapılıyor...', style:TextStyle(fontSize:18, fontWeight: FontWeight.bold),),
                    ))
                  ],
                ),
              )
           :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
                child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 0, 0),
                                  child: Text(
                                    adress,
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
                                    image: new AssetImage(
                                        "assets/hesabim_kusak.png"),
                                    fit: BoxFit.fill)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 23,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profil()),
                          );
                        },
                        child: Text('Profilim',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                controller: nameController,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    focusColor: Colors.deepPurple,
                    hintText: 'Adınız ve Soyadınız',
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
                controller: mailController,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    focusColor: Colors.deepPurple,
                    hintText: 'Mail adresiniz',
                    hintStyle: TextStyle(fontSize: 12)),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mail Boş Geçilemez!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                controller: gsmController,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    focusColor: Colors.deepPurple,
                    hintText: 'Gsm Numaranız +90',
                    hintStyle: TextStyle(fontSize: 12)),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Gsm Boş Geçilemez!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                obscureText: _passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    focusColor: Colors.deepPurple,
                    hintText: 'Şifre oluşturun',
                    hintStyle: TextStyle(fontSize: 12)),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre Boş Geçilemez!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
              child: TextFormField(
                obscureText: _passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    focusColor: Colors.deepPurple,
                    hintText: 'Şifrenizi tekrar girin',
                    hintStyle: TextStyle(fontSize: 12)),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre Boş Geçilemez!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
                width: 180,
                child: FlatButton(
                  color: Colors.deepPurple,
                  onPressed: () {
                    login(mailController.text, gsmController.text, nameController.text);
                  },
                  child:
                      Text('Güncelle', style: TextStyle(color: Colors.white)),
                ))
          ],
        ));
  }
}
