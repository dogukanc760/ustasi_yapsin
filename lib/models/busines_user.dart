import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String password;
  final String gsm;
  final String mail;
  final List<String> comments;
  final String about;
  final String name;

  User(
      {required this.username,
      required this.password,
      required this.gsm,
      required this.mail,
      required this.name,
      required this.comments,
      required this.about});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        username: json['mail'],
        password: json['password'],
        gsm: json['gsm'],
        mail: json['mail'],
        about: json['about'],
        comments: json['comments']);
  }

  Future<User> login(String mail, String password) async {
    final response = await http.post(
      Uri.parse('https://showmarket-api.herokuapp.com/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'gsm': mail, 'mail': mail, 'password': password}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception();
    }
  }
}
