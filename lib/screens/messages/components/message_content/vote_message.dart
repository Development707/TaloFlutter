import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

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
        Text(message.content),
        Text(message.question),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: numOp * 50,
          child: ClipRRect(
            child: BarChart(
              convertVote(context, message.options),
              animate: true,
              vertical: false,
              domainAxis: const OrdinalAxisSpec(renderSpec: NoneRenderSpec()),
              barRendererDecorator: BarLabelDecorator<String>(
                insideLabelStyleSpec:
                    TextStyleSpec(color: Color.fromOther(color: Color.black)),
                outsideLabelStyleSpec: TextStyleSpec(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Series<VoteData, String>> convertVote(
      BuildContext context, List<Option> options) {
    List<VoteData> data = [];
    for (var option in options) {
      data.add(VoteData(option.name, option.userIds.length));
    }

    return [
      Series<VoteData, String>(
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
