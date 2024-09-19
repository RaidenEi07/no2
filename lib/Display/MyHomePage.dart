import 'package:flutter/material.dart';
import 'package:no2/Widget/CustomAppBar.dart';
import 'package:no2/Widget/SelectionRow.dart';
import 'package:no2/Widget/BarStock.dart';
import 'package:no2/Widget/SortButtonRow.dart';
import 'package:no2/Widget/SavedListScreen.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SelectionRow(),
            SizedBox(height: 20),
            CustomBarStock(),
            SizedBox(height: 10),
            SelectableButtonsRow(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedListScreen()),
                );
              },
              child: Text('Xem danh sách đã lưu'),
            ),
          ],
        ),
      ),
    );
  }
}