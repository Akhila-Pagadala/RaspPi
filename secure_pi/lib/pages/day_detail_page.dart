import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:securepi/logics/schema.dart';

class DayDetailPage extends StatelessWidget {
  final List<Field> fields;
  final DateTime date;

  DayDetailPage(this.fields, this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          getHeader(),
          getCountCircle(),
        ],
      ),
    );
  }

  Widget getCountCircle() {
    var radius = 75.0;
    return Center(
      child: Container(
        height: radius * 2,
        //width: radius * 2,
        margin: EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 55, right: 55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                fields.length.toString(),
                style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "count",
                style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeader() {
    var formatter = new DateFormat('MMM d');

    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 12),
      child: Text(
        formatter.format(this.date),
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
            fontSize: 28,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
