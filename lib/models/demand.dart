import 'dart:convert';

class Demand{
  List<dynamic> company;
  String user;
  List<dynamic> service;
  List<dynamic> location;
  String time;
  String date;
  List<dynamic> question;
  List<dynamic> answer;
  String status;
  bool isActive;
  String price;
  String offerPrice;
  String offerDescription;
  String id;

  Demand({required this.id ,required this.company, required this.user, required this.service, required this.location,
  required this.time, required this.date, required this.question, required this.answer, required this.status,
  required this.isActive, required this.price, required this.offerDescription, required this.offerPrice});

  factory Demand.fromJson(Map<String, dynamic> json){
    return Demand(status: json['status'],
        answer: json['answer'],
        company: json['company'],
        date: json['date'],
        isActive: json['isActive'],
        location: json['location'],
        offerDescription: json['offerDescription'],
        offerPrice: json['offerPrice'],
        price: json['price'],
        question: json['question'],
        service: json['service'],
        time: json['time'],
        user: json['user'],
        id: json['_id'],
    );}
}