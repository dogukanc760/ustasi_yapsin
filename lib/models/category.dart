import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  String name;
  String img;
  bool isActive;
  bool showHome;
  String id;

  Category(
      {required this.name,
      required this.img,
      required,
      required this.isActive,
      required this.showHome,
      required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name'],
        img: json['img'],
        isActive: json['isActive'],
        showHome: json['showHome'],
        id: json['_id']);
  }
}

