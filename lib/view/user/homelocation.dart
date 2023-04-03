import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Locationsearch extends StatefulWidget {
  const Locationsearch({super.key, required this.title});

  final String title;

  @override
  State<Locationsearch> createState() => _LocationsearchState();
}

class _LocationsearchState extends State<Locationsearch> {


  @override
  Widget build(BuildContext context) {
    String? _value = 'one';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: ListView(
        children: [
          Text('Doctors list view.fetching from doctor_register'),
        ],
      ),
    );
  }
}