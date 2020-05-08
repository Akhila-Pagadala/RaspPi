import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';

class MyHomePage extends StatelessWidget {
  FieldsBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = FieldsBloc();
    bloc.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Security"),
      ),
      body: Center(
        child: StreamBuilder<List<DatedFields>>(
          stream: bloc.fieldsWithDatesController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) => DatedFieldsCard(list[index]),
                itemCount: list.length,
              );
            } else {
              return Container(
                child: Text("Loading...."),
              );
            }
          },
        ),
      ),
    );
  }
}

class DatedFieldsCard extends StatelessWidget {
  final DatedFields datedFields;

  DatedFieldsCard(this.datedFields);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(datedFields.date.toString() + " " + datedFields.fields.length.toString()),
    );
  }
}
