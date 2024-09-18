import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:no2/Provider/Provider.dart';

class SavedListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedItems = Provider.of<ListProvider>(context).savedItems;

    return Scaffold(
      appBar: AppBar(title: Text('Danh sách đã lưu')),
      backgroundColor: Colors.white,
      body: savedItems.isEmpty
          ? Center(child: Text('Chưa có danh sách nào được lưu'))
          : ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(savedItems[index]),
          );
        },
      ),
    );
  }
}