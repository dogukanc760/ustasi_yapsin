import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens/hizmetfotograf.dart';

import 'aktif_hizmet_verenler.dart';

class UstaBulunamadi extends StatelessWidget {
  const UstaBulunamadi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: SingleChildScrollView(
              child: Stack(
                children: [UstaBulamadik()],
              )),
        ),
      ),
    );
  }
}


class UstaBulamadik extends StatelessWidget {
  const UstaBulamadik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:70),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child:  Image.asset(
                'assets/first_slider_screen_image.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Text(
                    'ÜZGÜNÜZ',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    'Belirtilen konumda hizmet veren bulunmuyor',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    '(Denizli genelinde arama yapmak ister misiniz?)',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: FlatButton(

                    color: Colors.deepPurple,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AktifHizmetVerenler()));
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Denizli Genelinde Ara',
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20),
                          child: Icon(Icons.search, color: Colors.white,),
                        )
                      ],
                    )),
              ))
        ],
      )
    );
  }
}
