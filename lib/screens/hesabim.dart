import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar1.dart';
import 'package:ustasi_yapsin/screens/adreslerim.dart';
import 'package:ustasi_yapsin/screens/destek.dart';
import 'package:ustasi_yapsin/screens/guvenlik.dart';
import 'package:ustasi_yapsin/screens/profilim.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'girissayfasi.dart';
import 'package:image_picker/image_picker.dart';


_displayDialog(BuildContext context) async {
    
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title:Column(
              children: [
                Text('Uygulamayı Paylaşabilirsiniz!', style:TextStyle(color: Color(0xFF9B00CF), fontWeight: FontWeight.bold)),
                  Container(
                    child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Container(
                                 transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/logo.png'),
                                  ),
                                ),
                              ),
                            ),
                  ),
              ],
            ),
            content: Text(''),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  new FlatButton(
                    color: Color(0xFF6E1B9D),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.telegram, color: Colors.white, size:20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text('Telegram', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),//new Text('Ara', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                     
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: new FlatButton(
                      color: Color(0xFF6E1B9D),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.whatsapp, color: Colors.white, size:20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text('WhatsApp', style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),//new Text('Ara', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }


String username = '';
String name = '';
String surname = '';
String adress = '';
String gsm = '';
String userId = '';
 Future<File>? file;
String status = '';
late String base64Image;
late File tmpFile;
String errMessage = 'Error Uploading Image';


class Hesabim extends StatefulWidget {
  const Hesabim({Key? key}) : super(key: key);

  @override
  State<Hesabim> createState() => _HesabimState();
}

class _HesabimState extends State<Hesabim> {
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

    print(userId + username + name);
  }


  void destroySession(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GirisSayfasi()),
    );
  }
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data!;
          base64Image = base64Encode(snapshot.data!.readAsBytesSync());
          return Flexible(
            child: SizedBox(
              height:150,
              width:150,
              child: Image.file(
                snapshot.data!,
                fit: BoxFit.fill,
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    //upload(fileName);
  }

  /*upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }*/
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
        resizeToAvoidBottomInset: true,
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
                                    child: showImage(),
                                    radius: 30.0,

                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Container(
                                  transform: Matrix4.translationValues(30.0, -30.0, 0.0),
                                  child:IconButton(
                                      onPressed: (){
                                        setState(() {
                                          chooseImage();
                                        });
                                      },
                                      icon: Icon(Icons.photo_camera, color: Colors.deepPurple,size:30))
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
                                            40, 20, 0, 0),
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
                              ,
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Row(
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
                  //         child: TextButton(
                  //             onPressed: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => Guvenlik()),
                  //               );
                  //             },
                  //             child: Text('Güvenlik',
                  //                 style: TextStyle(
                  //                     color: Colors.grey.shade500,
                  //                     fontSize: 16))),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
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
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Destek()),
                                );
                              },
                              child: Text('Whatsapp Destek',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16))),
                        )
                      ],
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
                            Icons.contact_support_outlined,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(
                              onPressed: () {},
                              child: Text('Sık Sorulan Sorular',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16))),
                        )
                      ],
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
                            Icons.share,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(
                              onPressed: () {
                                _displayDialog(context);
                              },
                              child: Text('Arkadaşına tavsiye et',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16))),
                        )
                      ],
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
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Adreslerim()),
                                );
                              },
                              child: Text('Adreslerim',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16))),
                        )
                      ],
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
                            Icons.logout,
                            color: Colors.grey,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: TextButton(
                              onPressed: () {
                                destroySession(context);
                              },
                              child: Text('Çıkış Yap',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16))),
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
