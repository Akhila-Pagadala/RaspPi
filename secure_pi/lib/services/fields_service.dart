import 'dart:math';

import 'package:securepi/logics/schema.dart';

abstract class FieldsService {
  Future<List<Field>> getFields(DateTime date);
}

class MockFieldsService extends FieldsService {
  int count = 10;

  @override
  Future<List<Field>> getFields(DateTime date) async {
    return await Future.delayed(Duration(seconds: 2), () {
      var fieldList = List<Field>(count);
      var random = Random();
      for (var i = 0; i < count; i++)
        fieldList[i] = Field(field1: random.nextInt(2), createdAt: date.add(Duration(minutes: random.nextInt(144))), entryId: i);
      fieldList.sort((f1, f2)=>f1.createdAt.difference(f2.createdAt).inMilliseconds);
      return fieldList;
    });
  }
}
