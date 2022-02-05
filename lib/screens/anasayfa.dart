import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';
import 'package:ustasi_yapsin/models/category.dart';
import 'package:ustasi_yapsin/models/service.dart';

final List<String> categoryList = [
  '',
  'Temizlik',
  'Otomotiv',
  'İnşaat ve Tadilat',
  'Nakliye',
  'Özel Ders',
  'Beyaz Eşya',
  'Anahtarcı,' 'Organizasyon',
  'Teknoloji',
  'Tesisat'
];

final List<String> fastService = [
  'Buzdolabı Tamiri',
  'Klima Tamiri',
  'Anahtarcı',
  'Oto Lastikçi',
  'Kombi Tamiri',
  'Oto Elektrikçi',
  'Oto Çekici',
  'Kanal Açma',
  'Sıhhi Tesisatçı',
  'Elektrikçi',
  'Böcek İlaçlama'
];

String username = '';
String name = '';
String surname = '';
String adress = '';
String img = '';
String gsm = '';
String userId = '';
String responses = '';
List<Category> categoryListe = [];
List<Slider> sliderListe = [];
List<Service> serviceListe = [];
final List<String> imgList = [];
Future<Category> getCategory() async {
  final response = await http.get(
    Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/category'),
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    print(response.body.length);
    var result = jsonDecode(response.body);
    print(result['data'].length);
    // categoryListe = Category.fromJson(jsonDecode(response.body)) as List<Category>;
    // for(var i in categoryListe){
    //   print(categoryListe[0].name);
    // }
    return Category.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  late Future<Category> category;
  List<Category> categoryListesi = [];
  var isLoading = false;
  Future<List<Category>> veriAl() async {
   
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/category'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      //  print(result['data'][0]['_id'])
      setState(() {
        for (var i = 0; i < result.length; i++) {
          print(result['data'][i]);

          categoryListe.add(Category(
              name: result['data'][i]['name'],
              img: result['data'][i]['img'],
              isActive: result['data'][i]['isActive'],
              showHome: result['data'][i]['showHome'],
              id: result['data'][i]['_id']));
          print(categoryListe[i].name);
        }
        isLoading = false;
      });
      return categoryListe;
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    
    veriAl();
    super.initState();
  }

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
            children: [HomePages()],
          )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<Category> categoryListesi = [];
  var isLoading = false;
  Future<List<Category>> veriAl() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/category'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      //  print(result['data'][0]['_id'])
      setState(() {
        for (var i = 0; i < result.length; i++) {
          print(result['data'][i]);

          categoryListe.add(Category(
              name: result['data'][i]['name'],
              img: result['data'][i]['img'],
              isActive: result['data'][i]['isActive'],
              showHome: result['data'][i]['showHome'],
              id: result['data'][i]['_id']));
          print(categoryListe[i].name);
        }
       
      });
      return categoryListe;
    } else {
      throw Exception();
    }
  }

  Future<List<Category>> getSlider() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/slider'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      //  print(result['data'][0]['_id'])
      setState(() {
        for (var i = 0; i < result.length; i++) {
          print(result['data'][i]);
          imgList.add("https://showmarket-api.herokuapp.com/images/" +
              result['data'][i]['sliderUrl']);
        }
      });
      return categoryListe;
    } else {
      throw Exception();
    }
  }
Future<List<Category>> getService() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/service'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      //  print(result['data'][0]['_id'])
      setState(() {
        for (var i = 0; i < result.length; i++) {
          serviceListe.add(Service(user: result['data'][i]['user'], name: result['data'][i]['name'],
           companyName: result['data'][i]['companyName'], sector: result['data'][i]['sector'].cast<String>(), 
          category: result['data'][i]['category'].cast<String>(), city: result['data'][i]['city'].cast<String>(),
           distinct: result['data'][i]['distinct'].cast<String>(), questions: result['data'][i]['questions'].cast<String>(),
            answer: result['data'][i]['answer'].cast<String>(), 
          title: result['data'][i]['title'], description: result['data'][i]['description'],
           price: result['data'][i]['price'], priceTwo: result['data'][i]['priceTwo'], personCount: result['data'][i]['personCount'],
           img: result['data'][i]['img'], descImg: result['data'][i]['descImg'].cast<String>(),
            descVideos: result['data'][i]['descVideos'].cast<String>(),
            rating: result['data'][i]['rating'], ratingCount: result['data'][i]['ratingCount'],
            about: result['data'][i]['about'], comments: result['data'][i]['comments'].cast<String>()));
        }
        print(serviceListe[0].name);
         isLoading = false;
      });
      return categoryListe;
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    categoryListe.clear();
    serviceListe.clear();
    getSession();
     veriAl();
    
    // TODO: implement initState
    getSlider();
   getService();
    super.initState();
  }

  void getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      img = prefs.getString('img').toString();
      username = prefs.getString('username').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      gsm = prefs.getString('gsm').toString();
      userId = prefs.getString('id').toString();
      adress = prefs.getString('adress').toString();
      
    });

    print(userId + username + name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Center(
                      child: Container(
                          child: TextButton(
                              onPressed: () {},
                              child: Text('UzmanıBaksın.com',
                                  style: TextStyle(color: Colors.purple))))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade300,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 0.0),
                          ),
                          contentPadding: new EdgeInsets.symmetric(vertical: 0),
                          hintText: 'Aradığınız hizmeti belirtiniz.',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 14),
                          filled: true,
                          prefixIcon: IconButton(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                            alignment: Alignment.centerLeft,
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                            ),
                          )),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Boş Bir Sorgu Aranamaz!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Color(0xFF9B00CF),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/anasayfaikon2.jpeg'),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Text(
                                  'Hoşgeldin ' + name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 220,
                                height: 30,
                                padding: EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                        children: [
                                          WidgetSpan(
                                              child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 1, 0, 0),
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          )),
                                          TextSpan(
                                              text: adress[0])
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(2, 4, 0, 0),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text('Değiştir',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.underline)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          color: Colors.grey.shade200,
                          width: MediaQuery.of(context).size.width,
                          height: 190,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ImageSliderDemo()),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color: Colors.grey.shade200,
                    child: TextButton(
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Daha fazlasını Keşfet ",
                              style: TextStyle(
                                color: Colors.blueAccent,
                              )),
                          WidgetSpan(
                            child: Icon(Icons.arrow_forward_rounded, size: 14),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryListe.length,
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
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(90.0),
                                            side: BorderSide(
                                                width: 3, color: Colors.blue)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.network(
                                            'https://ustasiyapsin-api.herokuapp.com/images/' +
                                                categoryListe[index].img,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          categoryListe[index].name,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  //yorum
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                              child: Text(
                                'Acil Hizmetler',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryListe.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            90.0),
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Colors.blue)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Image.network(
                                                    'https://ustasiyapsin-api.herokuapp.com/images/' +
                                                        categoryListe[index]
                                                            .img,
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                child: Text(
                                                  categoryListe[index].name,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 10, 0, 10),
                              child: Text(
                                'Trend Hizmetler',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Image(
                                image: AssetImage('assets/anasayfaslider2.jpg'),
                                width: MediaQuery.of(context).size.width,
                              ),
                            )
                          ],
                        )),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 35),
                          child: Text(
                            'Benzer Hizmetler',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Eğitim',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: 320,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: serviceListe.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
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
                                                      Container(
                                                        width: 150,
                                                        height: 240,
                                                        color: Colors.white,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          20,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    serviceListe[index].name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: SizedBox(
                                                                      width:
                                                                          180,
                                                                      height:
                                                                          150,
                                                                      child: Image(
                                                                          image:
                                                                              NetworkImage(
                                                                                'https://ustasiyapsin-api.herokuapp.com/images/'
                                                                                +serviceListe[index].img))),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          30,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    'Uzman Eğitmenlerden',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child: FlatButton(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  7.0),
                                                                              side: BorderSide(
                                                                                  color: Colors
                                                                                      .deepPurple)),
                                                                          height:
                                                                              30,
                                                                          minWidth:
                                                                              50,
                                                                          color: Colors
                                                                              .deepPurple,
                                                                          onPressed:
                                                                              () {},
                                                                          child: Text(
                                                                              'Hemen Teklif İste',
                                                                              style: TextStyle(color: Colors.white, fontSize: 12))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      child: RatingBar.builder(
                                                        initialRating: 3.5,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 25,
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
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                serviceListe[index].category[0],
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            )
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
                   Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Teknoloji',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: 320,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: serviceListe.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
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
                                                      Container(
                                                        width: 150,
                                                        height: 240,
                                                        color: Colors.white,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          20,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    serviceListe[index].name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: SizedBox(
                                                                      width:
                                                                          180,
                                                                      height:
                                                                          150,
                                                                      child: Image(
                                                                          image:
                                                                              NetworkImage(
                                                                                'https://ustasiyapsin-api.herokuapp.com/images/'
                                                                                +serviceListe[index].img))),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          30,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    'Uzman Eğitmenlerden',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child: FlatButton(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  7.0),
                                                                              side: BorderSide(
                                                                                  color: Colors
                                                                                      .deepPurple)),
                                                                          height:
                                                                              30,
                                                                          minWidth:
                                                                              50,
                                                                          color: Colors
                                                                              .deepPurple,
                                                                          onPressed:
                                                                              () {},
                                                                          child: Text(
                                                                              'Hemen Teklif İste',
                                                                              style: TextStyle(color: Colors.white, fontSize: 12))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      child: RatingBar.builder(
                                                        initialRating: 3.5,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 25,
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
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                serviceListe[index].category[0],
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            )
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
                 
                 ],
              ));
  }
}

class ImageSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                      child: Image.network(item, fit: BoxFit.fill, width: 1000)),
                ))
            .toList(),
      )),
    );
  }
}

class ImageSliderDemo_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
        ),
        items: imgList
            .map((item) => Container(
                  child: Center(
                      child: Image.network(item, fit: BoxFit.fill, width: 1000)),
                ))
            .toList(),
      )),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(''),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
