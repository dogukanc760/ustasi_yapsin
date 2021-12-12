import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ustasi_yapsin/screens/hizmetustasonuc.dart';

class HizmetFotograf extends StatefulWidget {
  const HizmetFotograf({Key? key}) : super(key: key);

  @override
  _HizmetFotografState createState() => _HizmetFotografState();
}

class _HizmetFotografState extends State<HizmetFotograf> {
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
            children: [FotografEkleme()],
          )),
        ),
      ),
    );
  }
}

class FotografEkleme extends StatefulWidget {
  const FotografEkleme({Key? key}) : super(key: key);

  @override
  _FotografEklemeState createState() => _FotografEklemeState();
}

class _FotografEklemeState extends State<FotografEkleme> {
  var imageFile;
  var imageFile2;
  var imageFile3;
  var imageFile4;
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  _getFromGallery2() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera2() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });
    }
  }
  _getFromGallery3() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile3 = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera3() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile3 = File(pickedFile.path);
      });
    }
  }
  _getFromGallery4() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile4 = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera4() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile4 = File(pickedFile.path);
      });
    }
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void _showPicker2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _getFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _getFromCamera2();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void _showPicker3(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _getFromGallery3();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _getFromCamera3();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void _showPicker4(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _getFromGallery4();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _getFromCamera4();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: Text(
                      'Hizmet verenlere fikir vermesi için en az 1 fotoğraf çekmelisiniz',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      '(Farklı açılardan max. 4 adet)',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:30),
              child: SizedBox(
                height:150,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(width: 2.3, color: Colors.grey)),
                      child: FlatButton(
                        onPressed: (){_showPicker(context);},
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: imageFile==null? Image.asset(
                            'assets/imageyok.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) :Image.file(
                            imageFile,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(width: 2.3, color: Colors.grey)),
                      child: FlatButton(
                        onPressed: (){_showPicker2(context);},
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: imageFile2==null? Image.asset(
                            'assets/imageyok.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) :Image.file(
                            imageFile2,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:30),
              child: SizedBox(
                height:150,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(width: 2.3, color: Colors.grey)),
                      child: FlatButton(
                        onPressed: (){_showPicker3(context);},
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: imageFile3==null? Image.asset(
                            'assets/imageyok.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) :Image.file(
                            imageFile3,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(width: 2.3, color: Colors.grey)),
                      child: FlatButton(
                        onPressed: (){_showPicker4(context);},
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: imageFile4==null? Image.asset(
                            'assets/imageyok.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) :Image.file(
                            imageFile4,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ) ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: FlatButton(
                      color: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UstaBulunamadi()));
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
