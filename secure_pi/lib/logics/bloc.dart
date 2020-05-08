

import 'dart:async';

import 'package:securepi/logics/schema.dart';
import 'package:securepi/services/fields.dart';

class Bloc {

  FieldsService service = MockFieldsService();

  StreamController fieldController = StreamController<Field>();


  void dispose(){
    fieldController.close();
  }

}

