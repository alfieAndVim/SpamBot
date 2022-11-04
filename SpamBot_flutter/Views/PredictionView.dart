import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spambot_2/StateStores/StateStore.dart';

class PredictionView extends StatefulWidget {
  PredictionView({Key? key}) : super(key: key);

  @override
  _PredictionViewState createState() => _PredictionViewState();
}

class _PredictionViewState extends State<PredictionView> {
  @override
  Widget build(BuildContext context) {
    final prediction = Provider.of<Prediction>(context);

    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(7),
          color: Colors.white),
      width: 150,
      height: 150,
      child: Align(
          alignment: Alignment.center, child: Text(prediction.prediction, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
    );
  }
}
