


import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens/anasayfa.dart';
import 'package:ustasi_yapsin/screens/hesabim.dart';
import 'package:ustasi_yapsin/screens/kategoriler.dart';
import 'package:ustasi_yapsin/screens/taleplerim.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {

  int seciliSayfa = 0;
  void sayfaDegistir(int index) {
    setState(() {
      seciliSayfa = index;
      print(seciliSayfa);
    });
    sayfaGoster(seciliSayfa);
  }

   sayfaGoster(int seciliSayfa) {
    if (seciliSayfa == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Anasayfa()),
      );
    } else if (seciliSayfa == 1) {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Kategoriler()),
      );
    } else if (seciliSayfa == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Taleplerim()),
      );
    } else if (seciliSayfa == 3) {
      return Anasayfa();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Hesabim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:BottomNavigationBar(
        currentIndex: seciliSayfa,
        onTap: sayfaDegistir,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Colors.purple,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_main.png'),
                size: 22,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:7),
                child: Text('Anasayfa', style: TextStyle(fontSize:10),),
              )),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_kategori.png'),
                size: 22,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:7),
                child: Text('Kategori', style: TextStyle(fontSize:10),),
              )),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_sepet.png'),
                size: 22,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:7),
                child: Text('Sepet', style: TextStyle(fontSize:10),),
              )),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_favorite.png'),
                size: 22,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:7),
                child: Text('Favori', style: TextStyle(fontSize:10),),
              )),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_account.png'),
                size: 22,
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:7),
                child: Text('Hesabım', style: TextStyle(fontSize:10),),
              )),
        ],
      )
    );
  }
}
