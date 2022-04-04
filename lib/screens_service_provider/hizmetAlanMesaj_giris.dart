import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:ustasi_yapsin/external_widgets/BottomNavigationBar_TextFeildMessage.dart';
import 'package:http/http.dart' as http;
import 'package:ustasi_yapsin/models/messages.dart';
import 'hizmetAlanMesaj.dart';

List<Message> message = [];
int totalCount = 0;
var isLoading = false;
final messageController = new TextEditingController();

class mesajGiris extends StatefulWidget {
  String conversationId;
  String targetUser;
  mesajGiris({required this.conversationId, required this.targetUser})
      : super();

  @override
  State<mesajGiris> createState() => _mesajGirisState();
}

class _mesajGirisState extends State<mesajGiris> {
  getSession() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id').toString();
    print(userId + "conversation" + widget.conversationId);
    // getMessages(widget.conversationId);
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        //   backgroundColor: Colors.grey.shade300,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                ),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Sohbeti sil'),
                onTap: () {
                  // ...setstate
                },
              ),
              ListTile(
                title: const Text('Kişiyi engelle'),
                onTap: () {
                  // ...setstate
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text(widget.targetUser),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Mesajlasma(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back_ios_sharp),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: mesajGirisExtends(
                  targetUser: widget.targetUser,
                  conversationId: widget.conversationId)),
        ),
        bottomNavigationBar: NavigationBottomTextField(
            conversationId: widget.conversationId, userId: userId, targetId: widget.targetUser,),
      ),
    );
  }
}

class mesajGirisExtends extends StatefulWidget {
  String conversationId;
  String targetUser;
  mesajGirisExtends({required this.conversationId, required this.targetUser})
      : super();

  @override
  _mesajGirisExtendsState createState() => _mesajGirisExtendsState();
}

class _mesajGirisExtendsState extends State<mesajGirisExtends> {
  getSession() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id').toString();
    print(userId + "conversation" + widget.conversationId);
    // getMessages(widget.conversationId);
  }

  Future<void> getMessages(String userObject) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse(
          'https://ustasiyapsin-api.herokuapp.com/api/messages/' + userObject),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result);
      conversations.clear();
      setState(() {
        for (var i = 0; i < result.length; i++) {
          message.add(Message(
              text: result[i]['text'],
              sender: result[i]['sender'],
              convId: result[i]['conversationId']));
        }
        isLoading = false;
        totalCount = result.length;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Expanded(
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : totalCount < 1
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                      child: Column(
                        children: [
                          Center(),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Henüz Mesajınız Yok.',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          child: ListView.builder(
                            itemCount: message.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment: (message[index].sender == userId
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (message[index].sender == userId
                                          ? Colors.grey.shade200
                                          : Colors.blue[200]),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      message[index].text,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      color: Colors.green,
    );
  }
}

class NavigationBottomTextField extends StatefulWidget {
  String conversationId;
  String userId;
  String targetId;
  NavigationBottomTextField(
      {required this.conversationId, required this.userId, required this.targetId})
      : super();

  @override
  _NavigationBottomFieldState createState() => _NavigationBottomFieldState();
}

class _NavigationBottomFieldState extends State<NavigationBottomTextField> {
  Future<void> sendMessage(
      String mail, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    print(mail + password);
    final response = await http.post(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/messages/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': messageController.text,
        'sender': widget.userId,
        'conversationId': widget.conversationId
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => mesajGiris(
            conversationId: widget.conversationId,
            targetUser: widget.targetId,
          ),
        ),
      );
    } else {
      setState(() {
     
        isLoading = false;
      });
      showAboutDialog(context: context);
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 70,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Mesaj Yazın",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      sendMessage('mail', 'password', context);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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
    title: Text("Gönderim Başarısız!"),
    content: Text("Mesaj Gönderilemedi"),
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
