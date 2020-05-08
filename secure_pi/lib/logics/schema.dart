import 'package:flutter/cupertino.dart';

class Field {
  int field1;
  DateTime createdAt;
  int entryId;

  Field({this.field1, this.createdAt, this.entryId});

}

class DatedFields {
  DateTime date;
  List<Field> fields;

  DatedFields ({@required this.date, @required this.fields});
}

