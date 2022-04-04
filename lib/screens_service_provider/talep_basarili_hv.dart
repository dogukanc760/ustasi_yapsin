import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens_service_provider/anasayfa_hv.dart';
import 'package:ustasi_yapsin/screens_service_provider/tekliflerim.dart';

class TalepBasariliHv extends StatelessWidget {
  const TalepBasariliHv({Key? key}) : super(key: key);

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
            children: [IslemBasarili()],
          )),
        ),
      ),
    );
  }
}

class IslemBasarili extends StatelessWidget {
  const IslemBasarili({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: SizedBox(
            width: 350,
            height: 350,
            child: Image.asset(
              'assets/second_slider_screen_image.png',
              fit: BoxFit.fill,

            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Text('Tebrikler, Talebiniz Başarıyla Gönderildi!', style: TextStyle(color:Colors.grey.shade700,fontSize: 20),)
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: FlatButton(
            minWidth: 250,
            textColor: Colors.purple,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.purple,
                  style: BorderStyle.solid,
                )),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnasayfaHizmet()),
              );
            },
            child: const Text('Diğer Teklif bekleyen işleri gör'),
          ),
        ),
      ],
    ));
  }
}
