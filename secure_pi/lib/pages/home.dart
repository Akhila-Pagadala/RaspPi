import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Security"),
      ),
      body: Container(
        color: Color(243),
        child: ListView.builder(
          itemBuilder: (context, index) =>
              DatedFieldsCard(today.subtract(Duration(days: index))),
          itemCount: 90,
        ),
      ),
    );
  }
}

class DatedFieldsCard extends StatefulWidget {
  final DateTime date;

  DatedFieldsCard(this.date);

  @override
  _DatedFieldsCardState createState() => _DatedFieldsCardState();
}

class _DatedFieldsCardState extends State<DatedFieldsCard> {
  final FieldsBloc bloc = FieldsBloc();

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('MMM d');
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      padding: EdgeInsets.all(15),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(const Radius.circular(20.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(formatter.format(widget.date)),
          ),
          StreamBuilder<List<Field>>(
            stream: bloc.fieldController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                return Text(snapshot.data.length.toString());
              } else {
                return Text("...");
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.initState(widget.date);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
