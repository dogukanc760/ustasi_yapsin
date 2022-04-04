import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect/multiselect.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:http/http.dart' as http;
import 'package:ustasi_yapsin/models/category.dart';
import 'package:ustasi_yapsin/models/sector.dart';

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

bool hizmetStatus = true;
bool tumHizmet = true;

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

List<Category> categoryListe = [];
List<Category> initialCategory = [];
List<String> categorySt = [];
List<String> sectorsSt = [];
List<Sector> sectors = [];
List<String> city = ["İzmir", "Adana", "İstanbul", "Ankara"];
List<String> distinct = [
  "Konak",
  "Karabağlar",
  "Kozanlı",
  "Cebeci",
  "Çankaya",
  "Ulus"
];
List<String> days = [
  "Pazartesi",
  "Salı",
  "Çarşamba",
  "Perşembe",
  "Cuma",
  "Cumartesi",
  "Pazar"
];
List<String> hours = [
  "01.00",
  "02.00",
  "03.00",
  "04.00",
  "05.00",
  "06.00",
  "07.00",
  "08.00",
  "09.00",
  "10.00",
  "11.00",
  "12.00",
  "13.00",
  "14.00",
  "15.00",
  "16.00",
  "17.00",
  "18.00",
  "19.00",
  "20.00",
  "21.00",
  "22.00",
  "23.00",
  "24.00"
];

class Profilim extends StatefulWidget {
  const Profilim({Key? key}) : super(key: key);

  @override
  _ProfilimState createState() => _ProfilimState();
}

class _ProfilimState extends State<Profilim> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final gsmController = TextEditingController();
  var isLoader = false;
  void getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      username = prefs.getString('username').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      gsm = prefs.getString('gsm').toString();
      userId = prefs.getString('id').toString();
      nameController.text = name;
      print(userId);
      gsmController.text = gsm;
      adress = prefs.getString('adress').toString();
      mail = prefs.getString('username').toString();
      mailController.text = mail;
      sector = prefs.getString('sector').toString();
      category = prefs.getString('category').toString();
      worksHours = prefs.getString('worksHours').toString();
      worksDays = prefs.getString('worksDays').toString();
      cities = prefs.getString('sectorCity').toString();

      print(initialCategory[0].name + "inişal");
      distincts = prefs.getString('sectorDistinct').toString();
      category = category.replaceAll('"', '');
      category = category.replaceAll('[', '');
      category = category.replaceAll(']', '');
      initialCategory.clear();
      initialCategory.add(Category(
          name: category, img: '', isActive: true, showHome: true, id: 'id'));
      print(initialCategory[0].name+"kategori");
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
    print(category);
    print(cities);

    print(worksHours);
    print(worksDays);
    print(sector);
    setState(() {

    });
  }

  Future<List<Category>> veriAl() async {
    categoryListe.clear();

    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/category'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      //  print(result['data'][0]['_id'])
      setState(() {
        for (var i = 0; i < result['data'].length; i++) {
          categoryListe.add(Category(
              name: result['data'][i]['name'],
              img: result['data'][i]['img'],
              isActive: result['data'][i]['isActive'],
              showHome: result['data'][i]['showHome'],
              id: result['data'][i]['_id']));
        }
      });

      return categoryListe;
    } else {
      throw Exception();
    }
  }

  List<String> selected = [];

  Future<String> login(String mail, String gsm, String name) async {
    setState(() {
      isLoader = true;
    });
    print('userId' + userId);
    final response = await http.put(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/user/' + userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'gsm': mail,
        'mail': mail,
        'name': name,
        // 'sector': sector,
        // 'category': category,
        // 'sectorCity': cities,
        // 'sectorDistinct': distincts,
        // 'worksDays': worksDays,
        // 'worksHours': worksHours
      }),
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
      setState(() {
        responses = '201';
        isLoader = false;
      });

      return '201';
    } else {
      setState(() {
        isLoader = false;
      });
      return '500';
      throw Exception();
    }
  }

  Future<void> getSector(String categoryName) async {
    sectors.clear();
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/sector/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      var result = jsonDecode(response.body);

      //  print(result['data'][0]['_id']);
      if (result['data'].length > 0) {
        setState(() {
          for (var i = 0; i < result['data'].length; i++) {
            sectors.add(Sector(
                category: result['data'][i]['category'].cast<String>(),
                name: result['data'][i]['name'],
                id: result['data'][i]['_id']));
            sectorsSt.add(result['data'][i]['name']);
          }
        });
      }
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    veriAl();
    getSession();

    print(distincts);
    print(category);
    getSector('categoryName');
    // TODO: implement initState
    super.initState();
  }

  final _items = categoryListe
      .map((category) =>
          MultiSelectItem<Category>(category, category.name.trim()))
      .toList();
  final _itemsS =
      initialCategory.map((s) => MultiSelectItem<Category>(s, s.name)).toList();
  final _itemsT =
      sectors.map((a) => MultiSelectItem<Sector>(a, a.name)).toList();
  final _cities = city.map((c) => MultiSelectItem<String>(c, c)).toList();

  final _distincts =
      distinct.map((v) => MultiSelectItem<String>(v, v)).toList();
  final _days = days.map((q) => MultiSelectItem<String>(q, q)).toList();
  final _hours = hours.map((f) => MultiSelectItem<String>(f, f)).toList();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        'Güncelleme Yapılıyor...',
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 0, 0, 0),
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
                                  width:
                                      MediaQuery.of(context).size.width - 100.0,
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
                                  MaterialPageRoute(
                                      builder: (context) => Profil()),
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
                  //çoklu
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
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
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
                  /*Padding(
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
                  ),*/
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MultiSelectDialogField(
                      initialValue: _itemsS,
                      items: _items,
                      title: Text("Seçili Sektörler"),
                      selectedColor: Colors.deepPurple,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.category,
                        color: Colors.white,
                      ),
                      buttonText: Text(
                        "Sektörler",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          category = results.toString();
                        });
                        //_selectedAnimals = results;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MultiSelectDialogField(
                      initialValue: [sector],
                      items: _itemsT,
                      title: Text("Seçili Kategoriler"),
                      selectedColor: Colors.deepPurple,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.local_fire_department_outlined,
                        color: Colors.white,
                      ),
                      buttonText: Text(
                        "Kategoriler",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        //_selectedAnimals = results;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MultiSelectDialogField(
                      initialValue: [cities],
                      items: _cities,
                      title: Text("Hizmet Verdiğim İller"),
                      selectedColor: Colors.deepPurple,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.location_city_outlined,
                        color: Colors.white,
                      ),
                      buttonText: Text(
                        "Hizmet Verdiğim İller",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        //_selectedAnimals = results;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MultiSelectDialogField(
                      initialValue: [distincts],
                      items: _distincts,
                      title: Text("Hizmet Verdiğim İlçeler"),
                      selectedColor: Colors.deepPurple,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.reduce_capacity_outlined,
                        color: Colors.white,
                      ),
                      buttonText: Text(
                        "Hizmet Verdiğim İlçeler",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        //_selectedAnimals = results;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MultiSelectDialogField(
                      initialValue: [worksHours],
                      items: _hours,
                      title: Text("Çalışma Saatlerim"),
                      selectedColor: Colors.deepPurpleAccent,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.hourglass_bottom,
                        color: Colors.white,
                      ),
                      buttonText: Text(
                        "Çalışma Saatlerim",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        //_selectedAnimals = results;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MultiSelectDialogField(
                      initialValue: [worksDays],
                      items: _days,
                      title: Text("Çalışma Günlerim"),
                      selectedColor: Colors.deepPurple,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.today,
                        color: Colors.white,
                      ),
                      buttonText: Text(
                        "Çalışma Günlerim",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        //_selectedAnimals = results;
                      },
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                        child: Text('* Şuan Hizmet Veriyorum',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70, 20, 0, 0),
                        child: CustomSwitch(
                          activeColor: Colors.pinkAccent,
                          value: hizmetStatus,
                          onChanged: (value) {
                            print("VALUE : $value");
                            setState(() {
                              hizmetStatus = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                      endIndent: 45,
                      indent: 46,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                        child: Text('* 7/24 Hizmet Veriyorum',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70, 20, 0, 0),
                        child: CustomSwitch(
                          activeColor: Colors.pinkAccent,
                          value: tumHizmet,
                          onChanged: (value) {
                            print("VALUE : $value");
                            setState(() {
                              tumHizmet = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                        width: 250,
                        child: FlatButton(
                          color: Colors.deepPurple,
                          onPressed: () {
                            login(mailController.text, gsmController.text,
                                nameController.text);
                          },
                          child: Text('Güncelle',
                              style: TextStyle(color: Colors.white)),
                        )),
                  )
                ],
              ));
  }
}
