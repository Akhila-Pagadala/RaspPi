import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:securepi/logics/schema.dart';


class DayDetailPage extends StatelessWidget {
  final List<Field> fields;
  final DateTime date;

  DayDetailPage(this.fields, this.date);

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('MMM d');

    return Scaffold(
      appBar: AppBar(
        title: Text(formatter.format(date)),
      ),
      body: Container(),
    );
  }
}
