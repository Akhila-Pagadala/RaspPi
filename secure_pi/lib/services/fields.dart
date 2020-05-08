import 'dart:math';

import 'package:securepi/logics/schema.dart';

abstract class FieldsService {
  Future<List<Field>> getFields(int count, int startId);
}

class MockFieldsService extends FieldsService {
  int dateCount = 0;
  int maxFields = 1234;
  int fieldsPerDay = 175;

  @override
  Future<List<Field>> getFields(int count, int startId) async {
    return await Future.delayed(Duration(seconds: 2), () {
      if (dateCount * count > maxFields) return null;

      var fieldList = List<Field>(count);

      var date = DateTime.now();
      date = date.subtract(Duration(days: dateCount));
      var random = Random();

      for (var i = startId; i < count; i++) {
        if (i % fieldsPerDay == 0) {
          dateCount++;
          date = date.subtract(Duration(days: dateCount));
        }

        fieldList[i] = Field(field1: random.nextInt(2), createdAt: date, entryId: i);

      }
      return fieldList;
    });
  }
}
