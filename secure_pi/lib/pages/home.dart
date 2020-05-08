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
        child: StreamBuilder<HashMap<DateTime, List<Field>>>(
          stream: bloc.fieldsWithDatesController.stream,
          builder: (BuildContext context,
              AsyncSnapshot<HashMap<DateTime, List<Field>>> snapshot) {
            if (snapshot.hasData) {
              var map = snapshot.data;
              return Container();
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
