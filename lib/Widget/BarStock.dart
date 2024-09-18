import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarStock {
  final String title;
  final String boldText;
  final String redText;
  final String normalText;

  BarStock({
    required this.title,
    required this.boldText,
    required this.redText,
    required this.normalText,
  });
}

class BarStockProvider with ChangeNotifier {
  List<BarStock> _barStocks = [
    BarStock(title: 'VN INDEX', boldText: '1,259.03', redText: '+5.76 (+0.46%)', normalText: '3,359.7 (Tỷ VND)'),
    BarStock(title: 'VN INDEX', boldText: '1,259.03', redText: '+5.76 (+0.46%)', normalText: '3,359.7 (Tỷ VND)'),
  ];

  List<BarStock> get barStocks => _barStocks;

  void updateBarStock(int index, BarStock newBarStock) {
    _barStocks[index] = newBarStock;
    notifyListeners();
  }
}

class CustomBarStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final barStockProvider = Provider.of<BarStockProvider>(context);
    final barStocks = barStockProvider.barStocks;

    return Container(
      height: 100,
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: barStocks.map((barStock) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: barStockElements(barStock.title, barStock.boldText, barStock.redText, barStock.normalText),
          );
        }).toList(),
      ),
    );
  }
}

Widget barStockElements(String title, String boldText, String redText, String normalText) {
  return Container(
    height: 90,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Row(
          children: [
            Text(boldText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            SizedBox(width: 5),
            Text(redText, style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 5),
        Text(normalText, style: TextStyle(color: Colors.white70)),
      ],
    ),
  );
}