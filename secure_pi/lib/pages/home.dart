import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:securepi/logics/bloc.dart';
import 'package:securepi/logics/schema.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:securepi/settings.dart';
import 'day_detail_page.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();

    return Scaffold(
      body: Container(
        color: Colors.white10,
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) return getHeader();
            index -= 1;

            return DatedFieldsCard(today.subtract(Duration(days: index)));
          },
          itemCount: 7,
        ),
      ),
    );
  }

  Widget getHeader() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 12, left: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Home Security",
            style: GoogleFonts.robotoCondensed(
                textStyle: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Channel ID: ${HomeSecurityChannelInfo.channelId}"),
          ),
        ],
      ),
    );
  }
}

class DatedFieldsCard extends StatefulWidget {
  final DateTime date;

  DatedFieldsCard(this.date);

  @override
  _DatedFieldsCardState createState() => _DatedFieldsCardState();
}

class _DatedFieldsCardState extends State<DatedFieldsCard> {
  final FieldsBloc bloc = FieldsBloc();

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('MMM d');

    return StreamBuilder<List<Field>>(
        stream: bloc.fieldController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0) return SizedBox();
          List<Field> fields = snapshot.data;

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return DayDetailPage(fields, widget.date);
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(20.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 30,
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          formatter.format(widget.date),
                          style: GoogleFonts.robotoCondensed(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        getCounterWidget(fields),
                      ],
                    ),
                  ),
                  getGraph(fields),
                ],
              ),
            ),
          );
        });
  }

  Widget getGraph(fields) {
    var series = [
      charts.Series(
        id: 'Detection',
        domainFn: (Field clickData, _) => clickData.createdAt,
        measureFn: (Field clickData, _) => clickData.field1,
        data: fields,
      ),
    ];

    return Container(
      height: 100,
      child: charts.TimeSeriesChart(
        series,
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        primaryMeasureAxis:
            charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
        domainAxis: new charts.DateTimeAxisSpec(
          //showAxisLine: true,
          renderSpec: new charts.NoneRenderSpec(),
        ),
      ),
    );
  }

  Widget getCounterWidget(List<Field> fields) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: Text(
          fields.length.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.initState(widget.date);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
