import 'package:flutter/cupertino.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';

class FieldsManager {
  FieldsBloc bloc;

  List<Field> allFields;

  FieldsManager({@required this.bloc});

  void init() async {
    var fields = await bloc.service.getFields(bloc.date);

    this.allFields = fields;

    bloc.fieldController.sink.add(fields);
  }


}
