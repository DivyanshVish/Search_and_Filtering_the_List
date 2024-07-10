import 'package:flutter/material.dart';
import 'package:search_bar/contact.dart';

class Contactpage extends StatelessWidget {
  const Contactpage({super.key, required this.contact});
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Hero(
        tag: contact.urlImage,
        child: Image.network(contact.urlImage),
      ),
    );
  }
}
