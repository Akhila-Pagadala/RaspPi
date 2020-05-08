import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';

class FieldsManager {
  FieldsBloc bloc;

  List<Field> allFields = List<Field>();
  HashMap<DateTime, List<Field>> fieldsWithDates;

  FieldsManager({@required this.bloc}) {

    bloc.fieldController.stream.listen((fields) {
      if (fields == null) {
        // Got all the fields. Now call sort with dates and send it to the fucking view.
        fieldsWithDates = this.binIntoSortedDates(allFields);
        bloc.fieldsWithDatesController.sink.add(fieldsWithDates);
      }
      else {
        allFields.addAll(fields);
        // Get the entry of the last
        // Add the fields to allFields
        // Call for more fields
        bloc.fieldController.sink.add(bloc.service.getFields(200, fields[fields.length - 1].entryId));
      }
    });
    
    // Call to get the first fields.
    bloc.fieldController.sink.add(bloc.service.getFields(200, 0));

  }

  HashMap<DateTime, List<Field>> binIntoSortedDates(List<Field> fields) {
    /*
    1. First, I want to bin the fields with dates.
      a. First, go through all the fields,
        i. Initialize the key if doesn't exist.
     */
    var map = HashMap<DateTime, List<Field>>();

    for (var field in fields) {
      var createdAt = field.createdAt;

      createdAt.day;

      var key = DateTime(createdAt.year, createdAt.month, createdAt.day);

      if (!map.containsKey(key)) map[key] = List<Field>();
      map[key].add(field);
    }

    map.forEach((key, value) {
      value.sort(
          (dt1, dt2) => dt1.createdAt.difference(dt2.createdAt).inMilliseconds);
    });

    return map;
  }
}
