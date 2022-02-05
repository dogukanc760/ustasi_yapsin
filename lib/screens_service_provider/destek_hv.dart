import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:flutter/services.dart';


class Destek extends StatelessWidget {
  const Destek({Key? key}) : super(key: key);

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
                children: [DesteklemeHv()],
              )),
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class DesteklemeHv extends StatefulWidget {
  const DesteklemeHv({Key? key}) : super(key: key);

  @override
  _DesteklemeState createState() => _DesteklemeState();
}

class _DesteklemeState extends State<DesteklemeHv> {

  openwhatsapp() async{
    var whatsapp ="+08505325310";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=Mesajiniz";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("Destek Mesajınız")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp Telefonda Yüklü Değil")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp Telefonda Yüklü Değil")));

      }


    }

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
                    Icons.contact_support,
                    color: Colors.grey,
                    size: 23,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Destek()),
                    );
                  }, child: Text('Destek', style:TextStyle(color:Colors.grey.shade500,  fontSize: 16))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: FlatButton(
              onPressed: (){
                openwhatsapp();
              },
              child: TextFormField(

                enabled: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(

                    focusColor: Colors.deepPurple,
                    hintText: 'Whatsapp Aç',
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: FlatButton(
              onPressed: (){
                Clipboard.setData(ClipboardData(text: "08505325310"));
                Scaffold.of(context).showSnackBar(
                    SnackBar(content:Text("Telefon Numarası Panoya Kopyalandı!")));

              },
              child: TextFormField(

                enabled: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(

                    focusColor: Colors.deepPurple,
                    hintText: 'Numarayı Kopyala',
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
          ),
        ],
      )
    );
  }
}

