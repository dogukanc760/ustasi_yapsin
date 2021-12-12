import 'package:custom_switch/custom_switch.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens_service_provider/kayit_basarili.dart';

class ProfilTamamla extends StatelessWidget {
  const ProfilTamamla({Key? key}) : super(key: key);

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
            children: [KayitIcerik()],
          )),
        ),
      ),
    );
  }
}

class KayitIcerik extends StatefulWidget {
  const KayitIcerik({Key? key}) : super(key: key);

  @override
  _KayitIcerikState createState() => _KayitIcerikState();
}

class _KayitIcerikState extends State<KayitIcerik> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Text(
                'Müşterilerinizin size ulaşabilmesi için profil bilgilerinizi tamamlayın, daha fazlası'
                ' için profil sayfanızı ziyaret edebilirsiniz.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Seçilmesi Zorunlu Alan",
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: "* Hizmet Verdiğim Sektör",
                          labelStyle: TextStyle(fontSize: 13),
                          focusColor: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Seçilmesi Zorunlu Alan",
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: "* Hizmet Kategorisi",
                          labelStyle: TextStyle(fontSize: 13),
                          focusColor: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Seçilmesi Zorunlu Alan",
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: "* Hizmet Verdiğim İller",
                          labelStyle: TextStyle(fontSize: 13),
                          focusColor: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Seçilmesi Zorunlu Alan",
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: "* Hizmet Verdiğim İlçeler",
                          labelStyle: TextStyle(fontSize: 13),
                          focusColor: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        popupBackgroundColor: Colors.white,
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Seçilmesi Zorunlu Alan",
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: "* Çalışma Günlerim",
                          labelStyle: TextStyle(fontSize: 13),
                          focusColor: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Seçilmesi Zorunlu Alan",
                          hintStyle: TextStyle(fontSize: 12),
                          labelText: "* Çalışma Saatlerim",
                          labelStyle: TextStyle(fontSize: 13),
                          focusColor: Colors.white,
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
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                  child: Text('* Şuan Hizmet Veriyorum',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 20, 0, 0),
                  child: CustomSwitch(
                    activeColor: Colors.pinkAccent,
                    value: status,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black,
                endIndent: 45,
                indent: 46,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                  child: Text('* 7/24 Hizmet Veriyorum',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 20, 0, 0),
                  child: CustomSwitch(
                    activeColor: Colors.pinkAccent,
                    value: status,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black,
                endIndent: 45,
                indent: 46,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DevamEt()),
                );
              },
              minWidth: 250,
              color: Colors.deepPurple,
              child: Text(
                'Devam Et',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
