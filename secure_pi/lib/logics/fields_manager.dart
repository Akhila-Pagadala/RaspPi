import 'dart:collection';

import 'package:securepi/logics/schema.dart';

class FieldsManager {
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
      value.sort((dt1, dt2)=>dt1.createdAt.difference(dt2.createdAt).inMilliseconds);
    });

    return map;
  }
}



