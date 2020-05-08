import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';

class FieldsManager {
  FieldsBloc bloc;

  List<Field> allFields = List<Field>();
  List<DatedFields> fieldsWithDates;

  FieldsManager({@required this.bloc}) {

    bloc.fieldController.stream.listen((fields) {

      if (fields == null) {
        // Got all the fields. Now call sort with dates and send it to the fucking view.
        fieldsWithDates = this.binIntoSortedDates(allFields);
        bloc.fieldsWithDatesController.sink.add(fieldsWithDates);
      }
      else {
        // Add the fields to allFields
        allFields.addAll(fields);

        fieldsWithDates = this.binIntoSortedDates(allFields);
        bloc.fieldsWithDatesController.sink.add(fieldsWithDates);

        // Get the entry of the last
        // Call for more fields
        this.addNewFields(200, fields[fields.length - 1].entryId);

      }

    });
    
    // Call to get the first fields.
    this.addNewFields(200, 0);


  }

  List<DatedFields> binIntoSortedDates(List<Field> fields) {
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

    List<DateTime> dates = map.keys.toList();
    dates.sort((date1, date2)=>date2.difference(date1).inMilliseconds);

    List<DatedFields> sortedDatedFields = dates.map((key) {
      return DatedFields(date: key, fields: map[key]);
    }).toList();

    return sortedDatedFields;
  }

  void addNewFields(count, startId) async {
    bloc.fieldController.sink.add(await bloc.service.getFields(200, 0));
  }

}
