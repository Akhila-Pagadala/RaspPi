import 'dart:convert';

import 'package:securepi/logics/schema.dart';
import 'package:securepi/services/fields_service.dart';
import 'package:http/http.dart' as http;
import 'package:securepi/settings.dart';
import 'package:intl/intl.dart';
import 'dart:developer';


class ThingSpeakService extends FieldsService {
  String channelId = HomeSecurityChannelInfo.channelId;
  String readKey = HomeSecurityChannelInfo.readKey;

  @override
  Future<List<Field>> getFields(DateTime date) async {
    http.Response response =
        await http.get(Api.getReadUrl(this.channelId, this.readKey, date));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var feeds = json.decode(response.body)['feeds'];

      var fields = List<Field>();

      if (feeds.length == 0) return fields;

      var formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

      for (var feed in feeds) {
        fields.add(Field(
          createdAt: formatter.parse(feed['created_at']),
          entryId: feed['entry_id'],
          field1: int.parse(feed['field1']),
        ));
      }

      return fields;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log("Error fetching data!");
      return List<Field>();
    }
  }
}

class Api {
  static final url = "https://api.thingspeak.com/channels/";

  static String getReadUrl(String channelId, String readKey, DateTime date) {
    var start = getFormatted(date);
    var end = getFormatted(date.add(Duration(days: 1)));
    return "https://api.thingspeak.com/channels/$channelId/feeds.json?api_key=$readKey&start=$start&end=$end";
  }

  static String getFormatted(DateTime dateTime) {
    // YYYY-MM-DD%20HH:NN:SS
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime) + '%2000:00:00';
  }
}
