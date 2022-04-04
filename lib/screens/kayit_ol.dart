import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'girissayfasi.dart';
import 'kayit_ol.dart';

String username = '';
final gsm = TextEditingController();
final password = TextEditingController();
final mail = TextEditingController();
final fullName = TextEditingController();

class KayitOl extends StatelessWidget {
  const KayitOl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  @override
  void initState() {
    // TODO: implement initState
    readFilesFromAssets();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _offer = false;
  var isLoading = false;
  readFilesFromAssets() async {
    String assetContent = await rootBundle.loadString('assets/uyelıksoz.docx');
    print("assetContent : $assetContent");
  }

  Future<void> register(String mail, String password, String fullname,
      String gsm, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'gsm': gsm,
        'mail': mail,
        'name': fullname,
        'surname': fullname,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
      final prefs = await SharedPreferences.getInstance();
      var result = jsonDecode(response.body);
      print(result['data']);
      prefs.setString('username', result['data']['mail']);
      prefs.setString('name', result['data']['name']);
      prefs.setString('surname', result['data']['surname']);
      prefs.setString('gsm', result['data']['gsm']);
      prefs.setString('id', result['data']['_id']);
      prefs.setString('adress', jsonEncode(result['data']['adress']));
      prefs.setString('img', '');

      print(prefs.getString('adress'));
      setState(() {
        isLoading = false;
      });
      foo(context);

      //  return User.fromJson(jsonDecode(response.body));
    } else {
      setState(() {
        isLoading = false;
      });
      showAlertDialogFailed(context);
      throw Exception();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Üyelik Sözleşmesi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  width: 450,
                  height: 450,
                  child: WebView(
                    initialUrl:
                        'https://docs.google.com/document/d/e/2PACX-1vTLmRCHSu55ddwH6V7Jprn5k1_R7SKm3dDltoY_CqFIedeBdf7ELP6sD5hYDVF5alBX-KvtqP8YBmaJ/pub',
                  ),
                  //child:Html(data:'<iframe src="https://docs.google.com/document/d/e/2PACX-1vTLmRCHSu55ddwH6V7Jprn5k1_R7SKm3dDltoY_CqFIedeBdf7ELP6sD5hYDVF5alBX-KvtqP8YBmaJ/pub?embedded=true"></iframe>'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Onayla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SafeArea(
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                child: Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Kayıt Yapılıyor...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 40, 0),
                          child: Center(
                              child: Text('Bireysel Kayıt',
                                  style: TextStyle(
                                      color: Color(0xFF9B00CF),
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //  transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                                height: 100,
                                width: 100,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
                          child: Center(
                              child: Text('Uzmanabak',
                                  style: TextStyle(
                                      color: Color(0xFF9B00CF),
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: TextFormField(
                        controller: fullName,
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            hintText: 'Adınız ve Soyadınız',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.check),
                            )),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Adınız ve Soyadınız Boş Geçilemez!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextFormField(
                        controller: mail,
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            hintText: 'Mail adresiniz',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.check),
                            )),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mail Adresiniz Boş Geçilemez!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextFormField(
                        controller: gsm,
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            hintText: 'Gsm No: +90',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.check),
                            )),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gsm No Boş Geçilemez!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                    child: TextFormField(
                      controller: password,
                      obscureText: _passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      // The validator receives the text that the user has entered.
                      decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                          hintText: 'Şifre',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });

                                print(_passwordVisible);
                              },
                              icon: Icon(_passwordVisible
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined))),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şifre Boş Geçilemez!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      children: [
                        SizedBox(
                          child: CheckboxListTile(
                            title: Text(
                              "Üyelik Sözleşmesini ve KVKK Aydınlatma metnini okudum, kabul ediyorum.",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.left,
                            ), //    <-- label
                            value: _offer,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (newValue) {
                              print("1");

                              setState(() {
                                _offer = !_offer;
                              });
                              if (_offer) {
                                _showMyDialog();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                          child: FlatButton(
                            minWidth: 250,
                            textColor: Colors.white,
                            color: Colors.purple,
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              // if (_formKey.currentState!.validate()) {
                              //   // If the form is valid, display a snackbar. In the real world,
                              //   // you'd often call a server or save the information in a database.
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Processing Data')),
                              //   );
                              // }
                              register(mail.text, password.text, fullName.text,
                                  gsm.text, context);
                            },
                            child: const Text('Kayıt Ol'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                          child: FlatButton(
                            minWidth: 50,
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
                                MaterialPageRoute(
                                    builder: (context) => GirisSayfasi()),
                              );
                            },
                            child: Icon(Icons.home),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
