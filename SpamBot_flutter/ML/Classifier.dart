import 'package:flutter/services.dart';

// Import tflite_flutter
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  // name of the model file
  final _modelFile2 = 'SpamBotModelAvg.tflite';
  final _vocabFile = 'text_classification_vocab.txt';

  // Maximum length of sentence
  final int _sentenceLen = 128;

  final String start = '<START>';
  final String pad = '<PAD>';
  final String unk = '<UNKNOWN>';

  late Map<String, int> _dict;

  // TensorFlow Lite Interpreter object
  late Interpreter _interpreter;

  Classifier() {
    // Load model when the classifier is initialized.
    _loadModel();
    _loadDictionary();
  }

  void _loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    //final gpuDelegateV2 = GpuDelegateV2(
    //    options: GpuDelegateOptionsV2(
    //      inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
    //      inferencePriority1: TfLiteGpuInferencePriority.minLatency,
    //      inferencePriority2: TfLiteGpuInferencePriority.auto,
    //      inferencePriority3: TfLiteGpuInferencePriority.auto)
    //    
    //);

    //var interpreterOptions = InterpreterOptions()..addDelegate(gpuDelegateV2);
    _interpreter =
        await Interpreter.fromAsset(_modelFile2);
    print('Interpreter loaded successfully');
  }

  void _loadDictionary() async {
    final vocab = await rootBundle.loadString('assets/$_vocabFile');
    var dict = <String, int>{};
    final vocabList = vocab.split('\n');
    for (var i = 0; i < vocabList.length; i++) {
      var entry = vocabList[i].trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }
    _dict = dict;
    print('Dictionary loaded successfully');
  }

  List<double> classify(String rawText) {
    // tokenizeInputText returns List<List<double>>
    // of shape [1, 256].
    List<List<double>> input = tokenizeInputText(rawText);

    // output of shape [1,2].
    var output = List<double>.filled(2, 0).reshape([1, 2]);

    var input_list = [];
    var inside_list = [];
    var words = input[0];
    for (var word in words) {
      var new_word = word.toInt();
      inside_list.add(new_word);
    }
    input_list.add(inside_list);

    // The run method will run inference and
    // store the resulting values in output.
    _interpreter.run(input_list, output);

    return [output[0][0], output[0][1]];
  }

  List<List<double>> tokenizeInputText(String text) {
    // Whitespace tokenization
    final toks = text.split(' ');

    // Create a list of length==_sentenceLen filled with the value <pad>
    var vec = List<double>.filled(_sentenceLen, _dict[pad]!.toDouble());

    var index = 0;
    if (_dict.containsKey(start)) {
      vec[index++] = _dict[start]!.toDouble();
    }

    // For each word in sentence find corresponding index in dict
    for (var tok in toks) {
      if (index > _sentenceLen) {
        break;
      }
      vec[index++] = _dict.containsKey(tok)
          ? _dict[tok]!.toDouble()
          : _dict[unk]!.toDouble();
    }

    // returning List<List<double>> as our interpreter input tensor expects the shape, [1,256]
    return [vec];
  }
}
