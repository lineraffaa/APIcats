import 'package:apicats/view/home_page_cats.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: home_page_cats(),
    theme: ThemeData(
      hintColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
  ));
}
