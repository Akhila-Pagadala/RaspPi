import 'package:flutter/cupertino.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';

class FieldsManager {
  FieldsBloc bloc;

  List<Field> allFields = List<Field>();
  List<DatedFields> fieldsWithDates;

  FieldsManager({@required this.bloc});

  void init() async {
    bloc.fieldController.sink.add(await bloc.service.getFields(bloc.date));
  }


}
