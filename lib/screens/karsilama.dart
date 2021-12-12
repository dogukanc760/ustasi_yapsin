import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens/anasayfa.dart';

class Karsilama extends StatelessWidget {
  const Karsilama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:150.0),
                child: SizedBox(
                    height:350,
                    width:450,
                    child: Image(image: AssetImage('assets/succed_signed.png'))),
              ),
              Padding(
                padding: const EdgeInsets.only(top:70),
                child: FlatButton(
                  minWidth: 250,
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Anasayfa()),
                    );
                  },
                  child: const Text('Devam Et'),
                ),
              ),
            ],
          )),
    );
  }
}
