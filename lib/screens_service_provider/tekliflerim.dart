import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_hv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ustasi_yapsin/screens_service_provider/talep_durumu_hv.dart';

class TekliflerimHv extends StatelessWidget {
  const TekliflerimHv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          /*title: Center(child: Text('Taleplerim', style:TextStyle(color:Colors.deepPurple, fontSize: 12))),*/
          elevation: 0,
          toolbarHeight: 1,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.deepPurple,
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text(
                'Açık İşlerim',
                style: TextStyle(color: Colors.deepPurple),
              ),
              Text(
                'Bitmiş İşlerim',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[TalepDurumlarim(), TalepBitenlerim()],
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class TalepDurumlarim extends StatefulWidget {
  const TalepDurumlarim({Key? key}) : super(key: key);

  @override
  _TalepDurumlarimState createState() => _TalepDurumlarimState();
}

class _TalepDurumlarimState extends State<TalepDurumlarim> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height-MediaQuery.of(context).padding.bottom-170,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) =>
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Row(
                children: [
                  Card(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                'Ahmet Usta',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                'Boya Badana',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    '3.5',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
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
                                  style:
                                      TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 35,
                                  child:
                                  index==1 ? TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TalepDurumuHv(state: 4)),
                                        );
                                      },
                                      child:Text('1500 ₺',
                                          style: TextStyle(fontSize: 12 ,color: Colors.grey.shade500))):
                                  index%2==0 ? TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TalepDurumuHv(state: 1)),
                                        );
                                      },
                                      child: Text('Teklif Bekliyor',
                                          style: TextStyle(fontSize: 10 ,color: Colors.deepPurple))):
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TalepDurumuHv(state: 2)),
                                        );
                                      },
                                      child: Text('1500 ₺',
                                          style: TextStyle(fontSize: 12 ,color: Colors.grey.shade500))),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    ));
  }
}

class TalepBitenlerim extends StatefulWidget {
  const TalepBitenlerim({Key? key}) : super(key: key);

  @override
  _TalepBitenlerimState createState() => _TalepBitenlerimState();
}

class _TalepBitenlerimState extends State<TalepBitenlerim> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height-MediaQuery.of(context).padding.bottom-170,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Row(
                        children: [
                          Card(
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        'Ahmet Usta',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        'Boya Badana',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Text(
                                            '3.5',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 13),
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
                                          style:
                                          TextStyle(color: Colors.black, fontSize: 12),
                                        ),
                                        SizedBox(
                                            width: 80,
                                            child: FlatButton(
                                                onPressed: () {

                                                },
                                                child: Column(
                                                  children: [
                                                  Icon(Icons.restore_from_trash, color: Colors.grey.shade400,),
                                                    Text('İptal Edildi',
                                                        style: TextStyle(
                                                            color: Colors.blueAccent,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 10))

                                                  ],
                                                ))),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              ),
            ),

          ],
        )
    );
  }
}
