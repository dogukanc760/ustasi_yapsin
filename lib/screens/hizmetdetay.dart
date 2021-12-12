import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens/hizmetfotograf.dart';

class HizmetDetay extends StatefulWidget {
  const HizmetDetay({Key? key}) : super(key: key);

  @override
  _HizmetDetayState createState() => _HizmetDetayState();
}

class _HizmetDetayState extends State<HizmetDetay> {
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
            children: [OptionDetails()],
          )),
        ),
      ),
    );
  }
}

class OptionDetails extends StatefulWidget {
  const OptionDetails({Key? key}) : super(key: key);

  @override
  _OptionDetailsState createState() => _OptionDetailsState();
}

class _OptionDetailsState extends State<OptionDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 50),
                    child: Text(
                      'Boya Badana',
                      style: TextStyle(fontSize: 17),
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
                        labelText: "* Kaç metre kare oda/ev boyanacak.",
                        labelStyle: TextStyle(fontSize: 13),
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
                        labelText: "* Boyanacak alan kaç oda.",
                        labelStyle: TextStyle(fontSize: 13),
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
                        labelText: "* Tavan Boyanacak mı",
                        labelStyle: TextStyle(fontSize: 13),
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
                        labelText: "* Fiyata malzeme dahil olsun mu",
                        labelStyle: TextStyle(fontSize: 13),
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
                        labelText: "* Ev/oda eşyalı mı boş mu",
                        labelStyle: TextStyle(fontSize: 13),
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
                        labelText: "* Boya ne zaman yapılacak",
                        labelStyle: TextStyle(fontSize: 13),
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
                height: 120,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(30),
                          border: OutlineInputBorder(),
                          hintText:
                              'Talebinizle ilgili detayları buradan paylaşabilirsiniz.',
                          hintStyle: TextStyle(
                            fontSize: 10,
                          )),
                    ))),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: FlatButton(
                      color: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HizmetFotograf()));
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
