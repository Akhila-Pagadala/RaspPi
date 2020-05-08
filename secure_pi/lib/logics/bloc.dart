import 'dart:async';
import 'dart:collection';

import 'package:securepi/logics/fields_manager.dart';
import 'package:securepi/logics/schema.dart';
import 'package:securepi/services/fields.dart';

class FieldsBloc {
  FieldsManager fieldsManager;

  FieldsService service = MockFieldsService();

  StreamController fieldController = StreamController<List<Field>>.broadcast();
  StreamController fieldsWithDatesController = StreamController<List<DatedFields>>();

  void initState() {
    fieldsManager = FieldsManager(bloc: this);
  }

  void dispose() {
    fieldController.close();
    fieldsWithDatesController.close();
  }
}
