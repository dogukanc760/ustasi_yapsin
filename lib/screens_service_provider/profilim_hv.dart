import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';


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

class _ProfilimState extends State<Profilim> {

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

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
                                    'Ahmet Boyacı',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                                    child: Text(
                                      'Denizli',
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
                    Icons.person,
                    color: Colors.grey,
                    size: 23,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profil()),
                    );
                  }, child: Text('Profilim', style:TextStyle(color:Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 16))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: TextFormField(

              enableSuggestions: false,
              autocorrect: false,
              // The validator receives the text that the user has entered.
              decoration: InputDecoration(

                  focusColor: Colors.deepPurple,
                  hintText: 'Adınız ve Soyadınız',
                  hintStyle: TextStyle(fontSize: 12)
              ),

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

              enableSuggestions: false,
              autocorrect: false,
              // The validator receives the text that the user has entered.
              decoration: InputDecoration(

                focusColor: Colors.deepPurple,
                hintText: 'Mail adresiniz',
                hintStyle: TextStyle(fontSize: 12)
              ),

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

              enableSuggestions: false,
              autocorrect: false,
              // The validator receives the text that the user has entered.
              decoration: InputDecoration(

                  focusColor: Colors.deepPurple,
                  hintText: 'Gsm Numaranız +90',
                  hintStyle: TextStyle(fontSize: 12)
              ),

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
                  hintStyle: TextStyle(fontSize: 12)
              ),

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
                  hintStyle: TextStyle(fontSize: 12)
              ),

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
            child:FlatButton(color:Colors.deepPurple, onPressed: (){}, child: Text('Güncelle', style:TextStyle(color:Colors.white)),)
          )
        ],
      )
    );
  }
}
