import 'package:cryptovisor/core/entity/crypto_data/relative_strength_index_model.dart';
import 'package:cryptovisor/screens/helper/crypto_visor_colors.dart';
import 'package:cryptovisor/screens/widgets/charts/base_chart.dart';
import 'package:cryptovisor/screens/widgets/charts/rsi/rsi_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RSIChartPainter extends CustomPainter {
  final List<RelativeStrengthIndexModel> averages;

  RSIChartPainter({required this.averages});

  List<double> linesDashed = [0.0, 20.0, 50.0, 80.0, 100.0];
  double paddingNumberForChart = 35;

  @override
  void paint(Canvas canvas, Size size) {
    Size sizeChart = Size(size.width - paddingNumberForChart, size.height - BaseChart.marginVertical);
    Size sizeNumbers = Size(size.width, size.height - BaseChart.marginVertical);

    _createBackground(canvas, sizeChart);
    _createBandDashedLine(canvas, sizeChart);
    _createRSILine(canvas, sizeChart);
    _createLineAround(canvas, sizeChart);
    BaseChart.createWords(
        canvas: canvas,
        size: sizeNumbers,
        proporsion: 100,
        numbers: linesDashed,
        fontColor: CryptoVisorColors.whiteLabel.withOpacity(0.5));
    BaseChart.createWords(
        canvas: canvas, size: sizeNumbers, proporsion: 100, numbers: [averages.last.value], fontColor: Colors.white);
  }

  void _createBackground(Canvas canvas, Size size) {
    double startHeightRSIBackgroundFill = 20;
    double heightRSIBackgroundFill = 60;

    final rectBackground = Rect.fromLTWH(0, 0, size.width, ((size.height)) + BaseChart.marginVertical);
    canvas.drawRect(rectBackground, RSIHelper.paintBackground);
    final rect = Rect.fromLTWH(0, ((size.height / 100) * startHeightRSIBackgroundFill) + BaseChart.marginVertical / 2,
        size.width, (size.height / 100) * heightRSIBackgroundFill);
    canvas.drawRect(rect, RSIHelper.paintRangeInternal);
  }

  void _createRSILine(Canvas canvas, Size size) {
    for (int countLineRSi = 0; countLineRSi < averages.length - 1; countLineRSi++) {
      Offset lineStart = Offset((countLineRSi * size.width / averages.length),
          ((size.height / 100) * (100 - averages[countLineRSi].value)) + BaseChart.marginVertical / 2);
      Offset lineEnd = Offset(((countLineRSi + 1) * size.width / averages.length),
          ((size.height / 100) * (100 - averages[countLineRSi + 1].value)) + BaseChart.marginVertical / 2);
      canvas.drawLine(lineStart, lineEnd, RSIHelper.lineRSI);
    }

    // for (int countLineRSi = averages.length-1; countLineRSi >=0; countLineRSi--) {
    //   double width = size.width / averages.length;
    //   Offset lineStart = Offset((countLineRSi * width),
    //       ((size.height / 100) * (100 - averages[countLineRSi].value)) + BaseChart.marginVertical / 2);
    //   Offset lineEnd = Offset(((countLineRSi - 1) * width),
    //       ((size.height / 100) * (100 - averages[countLineRSi - 1].value)) + BaseChart.marginVertical / 2);
    //   canvas.drawLine(lineStart, lineEnd, Paint()..color=Colors.redAccent..strokeWidth =1);
    // }
  }

  void _createBandDashedLine(Canvas canvas, Size size) {
    int dashedLineQuantity = (size.width / 10).round();
    for (double line in linesDashed) {
      double heightLine = (size.height / 100) * line;
      for (int i = 0; i < dashedLineQuantity; i++) {
        if (i.isEven) {
          Offset lineStart =
              Offset((i * (size.width / dashedLineQuantity)), heightLine + (BaseChart.marginVertical / 2));
          Offset lineEnd =
              Offset(((i + 1) * (size.width / dashedLineQuantity)), heightLine + (BaseChart.marginVertical / 2));

          canvas.drawLine(lineStart, lineEnd, RSIHelper.lineDashed);
        }
      }
    }
  }

  void _createLineAround(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height + BaseChart.marginVertical), RSIHelper.contourLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
