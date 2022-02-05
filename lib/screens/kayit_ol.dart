import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';


import 'girissayfasi.dart';
import 'kayit_ol.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _offer = false;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: TextFormField(
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
                  // The validator receives the text that the user has entered.
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      hintText: 'Gsm No: +90',
                      suffixIcon: IconButton(
                        onPressed: () {


                        },
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
                obscureText: _passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
              child:
                Padding(
                  padding: const EdgeInsets.only(left:25.0),
                  child: Column(
                    children: [
                      SizedBox(

                        child: CheckboxListTile(

                          title: Text("Üyelik Sözleşmesini ve KVKK Aydınlatma metnini okudum, kabul ediyorum.",
                            style: TextStyle(fontSize: 12), textAlign: TextAlign.left,), //    <-- label
                          value: _offer,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (newValue) {
                            print("1");

                            setState(() {
                            _offer = !_offer;
                          }); },
                        ),
                      )
                    ],
                  ),
                )
            ),

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
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
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
                          MaterialPageRoute(builder: (context) => GirisSayfasi()),
                        );
                      },
                      child: Icon(Icons.home),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/girislatkusak.png'),
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
