import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens_service_provider/kayit_tercih.dart';

class KurumsalKayit extends StatelessWidget {
  const KurumsalKayit({Key? key}) : super(key: key);

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


  @override
  Widget build(BuildContext context) {

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
    return Column(
      children: [
        Form(
          key: _formKey,
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
                        hintText: 'Gsm no veya Email',
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
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 250),
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
                      // Validate returns true if the form is valid, or false otherwise.
                      /* if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }*/
                      /*  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Karsilama()),
                      );*/
                    },
                    child: const Text('Giriş Yap'),
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  minWidth: 250,
                  textColor: Colors.purple,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.purple,
                        style: BorderStyle.solid,
                      )),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => KayitTercih()),
                    );
                  },
                  child: const Text('Kayıt Ol'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 450,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/girislatkusak.png'),
                  ),
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
}
