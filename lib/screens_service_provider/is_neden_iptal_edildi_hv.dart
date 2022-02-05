import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ustasi_yapsin/screens_service_provider/anasayfa_hv.dart';
import 'package:ustasi_yapsin/screens_service_provider/anasayfa_hv.dart.dart';

class IsIptalEdildiHv extends StatelessWidget {
  const IsIptalEdildiHv({Key? key}) : super(key: key);

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
                children: [Detaylar()],
              )),
        ),
      ),
    );
  }
}

class Detaylar extends StatefulWidget {
  const Detaylar({Key? key}) : super(key: key);

  @override
  _DetaylarState createState() => _DetaylarState();
}

class _DetaylarState extends State<Detaylar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    side: BorderSide(width: 1, color: Colors.purpleAccent)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image(image: AssetImage('assets/logo.png'))),
                ),
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      'Ahmet Usta',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                    child: Text(
                      'Boya Badana',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          '3.5',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                              width: 120,
                              child: RatingBar.builder(
                                initialRating: 3.5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 17,
                                itemPadding:
                                EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  size: 2,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ))),
                      Text(
                        '14 Yorum',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: SizedBox(
                  child: Text('İptal sebebinizi belirtin.',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey.shade500, fontSize:10, fontWeight:FontWeight.bold))),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: SizedBox(
                width: 270,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextField(
                      minLines: 1,
                      maxLines: 25,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:   EdgeInsets.symmetric(vertical: 100.0, horizontal: 5.0),
                          border: OutlineInputBorder(),
                          hintText:
                          '',

                          hintStyle: TextStyle(
                            fontSize: 10,
                          )),
                    )),
              ),
            ),
            FlatButton(
              minWidth: 250,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AnasayfaHizmet()));
              },
              child: Text('Tamamla',
                  style:
                  TextStyle(color: Colors.white)),
              color: Colors.deepPurple,
            ),
          ],
        ));
  }
}
