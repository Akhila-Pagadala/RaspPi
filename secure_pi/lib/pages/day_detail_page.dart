import 'package:securepi/services/thingspeak_service.dart';
import 'package:securepi/settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:securepi/logics/schema.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DayDetailPage extends StatelessWidget {
  final List<Field> fields;
  final DateTime date;

  DayDetailPage(this.fields, this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          getHeader(),
          getCountCircle(),
          getGraph(),
        ],
      ),
    );
  }

  Widget getGraph() {
    var start = Api.getFormatted(date);
    var end = Api.getFormatted(date.add(Duration(days: 1)));
    var url = "http://thingspeak.com/channels/${HomeSecurityChannelInfo.channelId}/charts/${HomeSecurityChannelInfo.fieldId}?dynamic=true&api_key=${HomeSecurityChannelInfo.readKey}&start=$start&end=$end";

    var series = [
      charts.Series(
        id: 'Detection',
        domainFn: (Field clickData, _) => clickData.createdAt,
        measureFn: (Field clickData, _) => clickData.field1,
        data: fields,
      ),
    ];

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          height: 175,
          child: charts.TimeSeriesChart(
            series,
            animate: true,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
          ),
        ),
        OutlineButton(
            child: Text("Source"),
            onPressed: () => launch(url),
            highlightColor: Colors.blue,
            highlightedBorderColor: Colors.blue,
            borderSide: BorderSide(color: Colors.blue),
            textColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ],
    );
  }

  Widget getCountCircle() {
    var radius = 75.0;
    return Center(
      child: Container(
        height: radius * 2,
        //width: radius * 2,
        margin: EdgeInsets.only(top: 20, bottom: 40),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 55, right: 55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                fields.where((field) => field.field1 == 1).toList().length.toString(),
                style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "count",
                style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeader() {
    var formatter = new DateFormat('MMM d');

    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 12),
      child: Text(
        formatter.format(this.date),
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
            fontSize: 28,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
