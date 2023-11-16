import 'package:flutter/material.dart';

class MList {
  final String title;
  final String? description;
  final Icon? icon;
  final Widget? widget;

  const MList({required this.title, this.description, this.icon, this.widget});
}
