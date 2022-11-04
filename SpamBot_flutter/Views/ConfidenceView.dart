import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:spambot_2/StateStores/StateStore.dart';
import 'package:activity_ring/activity_ring.dart';

class ConfidenceView extends StatefulWidget {
  ConfidenceView({Key? key}) : super(key: key);

  @override
  _ConfidenceViewState createState() => _ConfidenceViewState();
}

class _ConfidenceViewState extends State<ConfidenceView> {
  @override
  Widget build(BuildContext context) {
    final confidence = Provider.of<Prediction>(context);

    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(7),
          color: Colors.white),
      width: 150,
      height: 150,
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text((confidence.confidence * 100).toStringAsFixed(1) + '%', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 10.0,
              percent: confidence.confidence,
              progressColor: Colors.blue,
              backgroundColor: Colors.white,
              animation: true,
              animationDuration: 200,
              circularStrokeCap: CircularStrokeCap.round,
            )
          ],
        ),
      ),
    );
  }
}
