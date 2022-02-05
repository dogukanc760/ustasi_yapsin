import 'dart:convert';

class DemandSet{
  String company;
  String user;
  List<dynamic> service;
  List<dynamic> location;
  String time;
  String date;
  List<dynamic> question;
  List<dynamic> answer;
  String status;

  String price;
  String offerPrice;
  String offerDescription;


  DemandSet({required this.company, required this.user, required this.service, required this.location,
    required this.time, required this.date, required this.question, required this.answer, required this.status,
    required this.price, required this.offerDescription, required this.offerPrice});

  factory DemandSet.fromJson(Map<String, dynamic> json){
    return DemandSet(status: json['status'],
      answer: json['answer'],
      company: json['company'],
      date: json['date'],

      location: json['location'],
      offerDescription: json['offerDescription'],
      offerPrice: json['offerPrice'],
      price: json['price'],
      question: json['question'],
      service: json['service'],
      time: json['time'],
      user: json['user'],

    );}
  Map<String, String> toJson() =>
      {
        'status':status,
        'answer':answer.toString(),
        'company':company,
        'date':date,
        'location':location.toString(),
        'offerDescription':offerDescription,
        'offerPrice':offerPrice,
        'price':price,
        'question':question.toString(),
        'service':service.toString(),
        'time':time,
        'user':user
      };
}