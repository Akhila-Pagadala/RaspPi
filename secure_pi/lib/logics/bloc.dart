import 'dart:async';

import 'package:securepi/logics/fields_manager.dart';
import 'package:securepi/logics/schema.dart';
import 'package:securepi/services/fields_service.dart';
import 'package:securepi/services/thingspeak_service.dart';

class FieldsBloc {
  DateTime date;

  FieldsManager fieldsManager;

  FieldsService service = MockFieldsService();

  StreamController fieldController = StreamController<List<Field>>.broadcast();

  void initState( DateTime date) {
    this.date = date;
    fieldsManager = FieldsManager(bloc: this);
    fieldsManager.init();
  }

  void dispose() {
    fieldController.close();
  }

}
