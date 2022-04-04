


import 'package:flutter/material.dart';

import 'package:ustasi_yapsin/screens_service_provider/anasayfa_hv.dart';
import 'package:ustasi_yapsin/screens_service_provider//hesabim_hv.dart';
import 'package:ustasi_yapsin/screens_service_provider/hizmetAlanMesaj.dart';
import 'package:ustasi_yapsin/screens_service_provider/kategoriler_hv.dart';

import 'package:ustasi_yapsin/screens_service_provider/yapılmayı_bekleyen_işler_hv.dart';



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
        MaterialPageRoute(builder: (context) => AnasayfaHizmet()),
      );
    } else if (seciliSayfa == 1) {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Kategoriler()),
      );
    } else if (seciliSayfa == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => isler()),
      );
    } else if (seciliSayfa == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mesajlasma()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HesabimHizmet()),
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
                size: 30,
              ),
              label: ''
            ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_kategori.png'),
                size: 30,
              ),
              label: ''
            ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_sepet.png'),
                size: 30,
              ),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/destek.png'),
                size: 30,
              ),
              label: ''
            ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/hizmet_alan_account.png'),
                size: 30,
              ),
              label: ''
            ),
        ],
      )
    );
  }
}
