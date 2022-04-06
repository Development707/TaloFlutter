import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../../../models/last_message.dart';

class VoteMessage extends StatelessWidget {
  const VoteMessage({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final LastMessage message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    int numOp = message.options.length;
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: numOp * 60,
          child: ClipRRect(
            child: charts.BarChart(
              convertVote(context, message.options),
              behaviors: [charts.ChartTitle(message.question)],
              animate: true,
              vertical: false,
              domainAxis: const charts.OrdinalAxisSpec(
                  renderSpec: charts.NoneRenderSpec()),
              barRendererDecorator: charts.BarLabelDecorator(
                insideLabelStyleSpec: charts.TextStyleSpec(),
                outsideLabelStyleSpec: charts.TextStyleSpec(),
              ),
            ),
          ),
        ),
        Text(message.content,
            style: TextStyle(
              color: isSender
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1?.color,
            )),
      ],
    );
  }

  List<charts.Series<VoteData, String>> convertVote(
      BuildContext context, List<Option> options) {
    List<VoteData> data = [];
    for (var option in options) {
      data.add(VoteData(option.name, option.userIds.length));
    }

    return [
      charts.Series<VoteData, String>(
        id: 'VoteResult',
        // colorFn: (_, pos) {
        //   if (pos! % 2 == 0) {
        //     return MaterialPalette.green.shadeDefault;
        //   }
        //   return MaterialPalette.blue.shadeDefault;
        // },
        domainFn: (VoteData vote, _) => vote.option,
        measureFn: (VoteData vote, _) => vote.total,
        data: data,
      )
    ];
  }
}

class VoteData {
  final String option;
  final int total;

  VoteData(this.option, this.total);
}
