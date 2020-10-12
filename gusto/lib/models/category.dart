import 'package:flutter/material.dart';

int _idState = 0;

class Category {
  int id;
  final String title;
  final Color color;

  Category({this.title, this.color}) {
    this.id = _idState++;
  }
}
