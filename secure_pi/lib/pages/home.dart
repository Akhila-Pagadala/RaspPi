import 'dart:collection';

import 'package:flutter/material.dart';
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
    return Column(
      children: <Widget>[
        Container(
          child: Text(widget.date.toString()),
        ),
        StreamBuilder<List<Field>>(
          stream: bloc.fieldController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return Text(snapshot.data.length.toString());
            } else {
              return Text("Loading...");
            }
          },
        )
      ],
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
