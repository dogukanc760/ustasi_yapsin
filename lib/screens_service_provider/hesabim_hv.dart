import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:ustasi_yapsin/screens/girissayfasi.dart';
import  'adreslerim_hv.dart';
import 'destek_hv.dart';
import 'guvenlik_hv.dart';
import 'profilim_hv.dart';

class HesabimHizmet extends StatefulWidget {
  const HesabimHizmet({Key? key}) : super(key: key);

  @override
  State<HesabimHizmet> createState() => _HesabimHizmetState();
}
String username ='';
String name ='';
String surname='';
String adress = '';
String gsm ='';
String userId = '';
class _HesabimHizmetState extends State<HesabimHizmet> {

   void getSession() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
      name = prefs.getString('name').toString();
      surname = prefs.getString('surname').toString();
      gsm = prefs.getString('gsm').toString();
      userId = prefs.getString('id').toString();
      adress = prefs.getString('adress').toString();
    });

    print(userId+username+name);

  }
  
  void destroySession(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GirisSayfasi()),
    );
  }

   @override
  void initState() {
    getSession();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
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
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                            Icons.person,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                  //Yorum satırlı 
                  // SizedBox(
                  //   width:MediaQuery.of(context).size.width,
                  //   child:Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  //         child: Icon(
                  //           Icons.message,
                  //           color: Colors.grey,
                  //           size: 23,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //         child: TextButton(onPressed: (){
                  //           /*Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => Hakkımda()),//bu kısım yapıılı deil
                  //           )*/;
                  //         }, child: Text('Hakkımda', style:TextStyle(color:Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 16))),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width:MediaQuery.of(context).size.width,
                  //   child:Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  //         child: Icon(
                  //           Icons.comment,
                  //           color: Colors.grey,
                  //           size: 23,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //         child: TextButton(onPressed: (){
                  //           /*Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => Sertifikalarım()),//bu kısım yapıılı deil
                  //           )*/;
                  //         }, child: Text('Sertifikalarım', style:TextStyle(color:Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 16))),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width:MediaQuery.of(context).size.width,
                  //   child:Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  //         child: Icon(
                  //           Icons.lock,
                  //           color: Colors.grey,
                  //           size: 23,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //         child: TextButton(onPressed: (){
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => Guvenlik()),
                  //           );
                  //         }, child: Text('Güvenlik', style:TextStyle(color:Colors.grey.shade500, fontSize: 16))),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Icon(
                            Icons.message,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Destek()),
                            );
                          }, child: Text('Whatsapp Destek', style:TextStyle(color:Colors.grey.shade500, fontSize: 16))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Icon(
                            Icons.contact_support_outlined,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(onPressed: (){}, child: Text('Sık Sorulan Sorular',
                              style:TextStyle(color:Colors.grey.shade500, fontSize: 16))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Icon(
                            Icons.share,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(onPressed: (){}, child: Text('Arkadaşına tavsiye et',
                              style:TextStyle(color:Colors.grey.shade500, fontSize: 16))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Adreslerim()),
                            );
                          }, child: Text('Adreslerim',
                              style:TextStyle(color:Colors.grey.shade500, fontSize: 16))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Icon(
                            Icons.logout,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(onPressed: (){destroySession(context);}, child: Text('Çıkış Yap',
                              style:TextStyle(color:Colors.grey.shade500, fontSize: 16))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}
