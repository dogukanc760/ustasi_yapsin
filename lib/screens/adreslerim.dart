import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';

String username = '';
  String name = '';
  String surname = '';
  String adress = '';
  String gsm = '';
  String userId = '';
  String responses = '';
  String mail = '';
  String city = ''; 
  String distinct = '';

class Adreslerim extends StatelessWidget {
  const Adreslerim({Key? key}) : super(key: key);

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
                children: [AdresIcerik()],
              )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class AdresIcerik extends StatefulWidget {
  const AdresIcerik({Key? key}) : super(key: key);

  @override
  _AdresIcerikState createState() => _AdresIcerikState();
}

class _AdresIcerikState extends State<AdresIcerik> {
   void getSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      gsm = prefs.getString('gsm').toString();
      userId = prefs.getString('id').toString();
      adress = prefs.getString('adress').toString();
      if (adress.length<4) {
        adress='';
      }
      mail = prefs.getString('mail').toString();
      
    });
    print(adress);
    print(userId + username + name);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child:Column(
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
                                        end: Alignment.topRight
                                    )
                                ),
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
                                      padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            color:Colors.grey.shade500,
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
              width:MediaQuery.of(context).size.width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 23,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Adreslerim()),
                      );
                    }, child: Text('Adresim', style:TextStyle(color:Colors.grey.shade500,  fontSize: 16))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: FlatButton(
                onPressed: (){},
                child: TextFormField(


                  // The validator receives the text that the user has entered.
                  decoration: InputDecoration(

                      focusColor: Colors.deepPurple,
                      hintText: '1. Adres',
                      hintStyle: TextStyle(fontSize: 12)
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Adres Boş Geçilemez!';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: FlatButton(
                onPressed: (){},
                child: TextFormField(


                  // The validator receives the text that the user has entered.
                  decoration: InputDecoration(

                      focusColor: Colors.deepPurple,
                      hintText: '2. Adres',
                      hintStyle: TextStyle(fontSize: 12)
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Adres Boş Geçilemez!';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                  width: 180,
                  child:FlatButton(color:Colors.deepPurple, onPressed: (){}, child: Text('Güncelle', style:TextStyle(color:Colors.white)),)
              ),
            )
          ],
        )
    );
  }
}

