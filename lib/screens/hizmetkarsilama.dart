import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/models/user_model.dart';
import 'package:ustasi_yapsin/screens/hizmetdetay.dart';

class HizmetKarsilama extends StatefulWidget {
  const HizmetKarsilama({Key? key}) : super(key: key);

  @override
  _HizmetKarsilamaState createState() => _HizmetKarsilamaState();
}

class _HizmetKarsilamaState extends State<HizmetKarsilama> {
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
            children: [OptionsChanges()],
          )),
        ),
      ),
    );
  }
}

class OptionsChanges extends StatefulWidget {
  const OptionsChanges({Key? key}) : super(key: key);

  @override
  _OptionsChangesState createState() => _OptionsChangesState();
}

class _OptionsChangesState extends State<OptionsChanges> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Text(
                      'İnşaat ve Tadilat',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: SizedBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/ikon10.png'),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Text(
                      'Almak İstediğiniz Hizmeti ve Konumu belirleyiniz',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: Text(
                      'İl Genelinde Arama Yapmak İçin İlçe Seçimi Yapmayınız.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownSearch<String>(
                      validator: (v) => v == null ? "required field" : null,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Seçilmesi Zorunlu Alan",
                        hintStyle: TextStyle(fontSize: 12),
                        labelText: "* Hizmet sektörü seçin.",
                        labelStyle: TextStyle(fontSize: 15),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF01689A)),
                        ),
                      ),
                      showAsSuffixIcons: true,
                      clearButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.clear,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      dropdownButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      showSelectedItems: true,
                      items: [
                        "Boya Badana",
                        "Tadilat",
                        "Sıva döşeme",
                        'Duvar Örme'
                      ],
                      showClearButton: true,
                      onChanged: print,
                      popupItemDisabled: (String? s) =>
                          s?.startsWith('I') ?? true,
                    ),
                  ),
                  /* Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Menu mode *",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01689A)),
                          ),
                        ),
                      ))*/
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownSearch<String>(
                      validator: (v) => v == null ? "required field" : null,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Seçilmesi Zorunlu Alan",
                        hintStyle: TextStyle(fontSize: 12),
                        labelText: "* Hizmet kategorisi seçin.",
                        labelStyle: TextStyle(fontSize: 15),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF01689A)),
                        ),
                      ),
                      showAsSuffixIcons: true,
                      clearButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.clear,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      dropdownButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      showSelectedItems: true,
                      items: [
                        "Boya Badana",
                        "Tadilat",
                        "Sıva döşeme",
                        'Duvar Örme'
                      ],
                      showClearButton: true,
                      onChanged: print,
                      popupItemDisabled: (String? s) =>
                          s?.startsWith('I') ?? true,
                    ),
                  ),
                  /* Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Menu mode *",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01689A)),
                          ),
                        ),
                      ))*/
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownSearch<String>(
                      validator: (v) => v == null ? "required field" : null,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Seçilmesi Zorunlu Alan",
                        hintStyle: TextStyle(fontSize: 12),
                        labelText: "* Hizmet verilecek ili seçin.",
                        labelStyle: TextStyle(fontSize: 15),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF01689A)),
                        ),
                      ),
                      showAsSuffixIcons: true,
                      clearButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.clear,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      dropdownButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      showSelectedItems: true,
                      items: [
                        "Boya Badana",
                        "Tadilat",
                        "Sıva döşeme",
                        'Duvar Örme'
                      ],
                      showClearButton: true,
                      onChanged: print,
                      popupItemDisabled: (String? s) =>
                          s?.startsWith('I') ?? true,
                    ),
                  ),
                  /* Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Menu mode *",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01689A)),
                          ),
                        ),
                      ))*/
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownSearch<String>(
                      validator: (v) => v == null ? "required field" : null,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "Seçilmesi Zorunlu Alan",
                        hintStyle: TextStyle(fontSize: 12),
                        labelText: "* Hizmet verilecek ilçeyi seçin.",
                        labelStyle: TextStyle(fontSize: 15),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF01689A)),
                        ),
                      ),
                      showAsSuffixIcons: true,
                      clearButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.clear,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      dropdownButtonBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      showSelectedItems: true,
                      items: [
                        "Boya Badana",
                        "Tadilat",
                        "Sıva döşeme",
                        'Duvar Örme'
                      ],
                      showClearButton: true,
                      onChanged: print,
                      popupItemDisabled: (String? s) =>
                          s?.startsWith('I') ?? true,
                    ),
                  ),
                  /* Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Menu mode *",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01689A)),
                          ),
                        ),
                      ))*/
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width:MediaQuery.of(context).size.width/1.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: FlatButton(
                    color: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HizmetDetay()));
                      },
                      child: Text(
                        'Devam Et',
                        style: TextStyle(color: Colors.white),
                      )),
                ))
          ],
        ));
  }
}
