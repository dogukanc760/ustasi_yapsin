import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustasi_yapsin/models/user_model.dart';
import 'package:ustasi_yapsin/screens_service_provider/giris_yap_hizmet.dart';
import 'package:http/http.dart' as http;
import 'package:ustasi_yapsin/screens_service_provider/kayit_basarili.dart';
import 'package:ustasi_yapsin/screens_service_provider/kayit_tercih.dart';
import 'anasayfa.dart';
import 'karsilama.dart';
import 'kayit_ol.dart';

class GirisSayfasi extends StatelessWidget {
  const GirisSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: const MyCustomForm(),
      ),
    );
  }
}

final gsm = TextEditingController();
final password = TextEditingController();

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

void foo(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  username = prefs.getString('username').toString();

  if (!username.isEmpty) {
    print(prefs.getString('username').toString());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DevamEt()),
    );
  } else {
    print("boş");
  }
}

void foos(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  username = prefs.getString('username').toString();

  if (!username.isEmpty) {
    print(prefs.getString('username').toString());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Anasayfa()),
    );
  } else {
    print("boş");
  }
}

String username = '';

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  var isLoading = false;
  int statusCode = 0;

  @override
  Widget build(BuildContext context) {
    Future<User> login(
        String mail, String password, BuildContext context) async {
      setState(() {
        isLoading = true;
      });
      print(mail + password);
      final response = await http.post(
        Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'gsm': gsm.text,
          'mail': gsm.text,
          'password': password
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        statusCode = 200;
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
        if (result['data']['img'] != null) {
          prefs.setString('img', result['data']['img']);
        }
        if (result['data']['img'] == null) {
          prefs.setString('img', '');
        }

        // if (rememberMe) {
        //   print('beni hatırla');
        //   addSession(usernames.text.toString(), passwords.text.toString(),
        //       result['data']['_id']);
        //   print('hatırladım');
        // } else {
        //   print('beni hatırlama');
        // }
        print(result['data']['isCompany']);
        if (result['data']['isCompany'] == true) {
          print('hizmet veren');
          prefs.setString('company', result['data']['company']);
          prefs.setString('taxnum', result['data']['taxnum']);
          prefs.setString('sector', result['data']['sector']);
          prefs.setString('category', result['data']['category']);
          prefs.setString(
              'sectorCity', jsonEncode(result['data']['sectorCity']));
          prefs.setString(
              'sectorDistinct', jsonEncode(result['data']['sectorDistinct']));
          prefs.setString('worksDays', jsonEncode(result['data']['worksDays']));
          prefs.setString(
              'worksHours', jsonEncode(result['data']['worksHours']));
          foos(context);
        }
        if (result['data']['isCompany'] == false) {
          print('hizmet alan');
          foo(context);
        }

        return User.fromJson(jsonDecode(response.body));
      } else {
        setState(() {
          isLoading = false;
        });
        showAlertDialogFailed(context);

        throw Exception();
      }
    }

    // Full screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var padding = MediaQuery.of(context).padding;
    double height1 = height - padding.top - padding.bottom;

// Height (without status bar)
    double height2 = height - padding.top;

// Height (without status and toolbar)
    double height3 = height - padding.top - kToolbarHeight;

    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: isLoading
          ? Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                child: Column(
                  children: [
                    Center(
                        child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                      backgroundColor: Colors.transparent,
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Giriş Yapılıyor...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        transform: Matrix4.translationValues(30.0, 50.0, 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text('Hoş Geldiniz.',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text('Lütfen hesabınıza giriş yapın.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 70, 30, 0),
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
                        transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
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
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: TextFormField(
                            // inputFormatters: <TextInputFormatter>[
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            controller: gsm,
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                hintText: 'Gsm No',
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.check),
                                )),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Gsm no veya Email Alanı Boş Geçilemez!';
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

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 30),
                          //   child: TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => KayitOl()),
                          //         );
                          //       },
                          //       child: Text(
                          //         'Kayıt Ol',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.normal,
                          //             color: Colors.purple,
                          //             fontSize: 20),
                          //       )),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Şifremi Unuttum',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.purple,
                                      fontSize: 15),
                                )),
                          )
                        ],
                      ),
                      //Text Button gelecek kayıt ol ve şifremi unuttum

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: FlatButton(
                            minWidth: 250,
                            textColor: Colors.white,
                            color: Colors.purple,
                            onPressed: () {
                              // showAlertDialogSuccess(context);
                              login(gsm.text, password.text, context);
                              // Validate returns true if the form is valid, or false otherwise.
                              /* if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }*/
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Karsilama()),
                              // );
                            },
                            child: const Text('Giriş Yap'),
                          ),
                        ),
                      ),
                      // Center(
                      //   child: FlatButton(
                      //     minWidth: 250,
                      //     textColor: Colors.purple,
                      //     color: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //         side: BorderSide(
                      //       color: Colors.purple,
                      //       style: BorderStyle.solid,
                      //     )),
                      //     onPressed: () {
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => GirisHizmet()),
                      //       );
                      //     },
                      //     child: const Text('Hizmet Veren Girişi'),
                      //   ),
                      // ),

                      /* SizedBox(
                  width:MediaQuery.of(context).size.width,
                  height: height3,
                  child: Column(
                    children: [Container(
                      child: Image(
                        image: AssetImage('assets/girislatkusak.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ]),
                ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hesabınız yok mu?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KayitOl()),
                              );
                            },
                            child: const Text('Kayıt Ol(Hizmet Alan)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.deepPurpleAccent)),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KayitTercih()),
                              );
                            },
                            child: const Text('Kayıt Ol(Hizmet Veren)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.deepPurpleAccent)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Anasayfa()),
                    );
                  },
                  child: const Text('Atla ve Devam Et',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurpleAccent)),
                ),
              ],
            ),
    );
  }
}

showAlertDialogSuccess(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Giriş Yapılıyor..."),
    content: CircularProgressIndicator(),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(height: 150, width: 150, child: alert);
    },
  );
}

showAlertDialogFailed(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("İşlem Başarısız!"),
    content: Text("Bilgilerinizi Kontrol Edin."),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
