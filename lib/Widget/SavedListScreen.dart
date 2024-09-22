import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:no2/Provider/Provider.dart';

class SavedListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedItems = Provider.of<ListProvider>(context).savedItems;

    return Scaffold(
      backgroundColor: Color(0xFF23272A),
      body: savedItems.isEmpty
          ? Center(child: Text('Chưa có danh sách nào được lưu'))
          : ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${savedItems[index]['symbol']} | ${savedItems[index]['exchange']}', style: TextStyle(color: Colors.white),),
            subtitle: Text(savedItems[index]['FullName'], style: TextStyle(color: Colors.white30)),// Hiển thị bidPrice3 và bidVol3
          );
        },
      ),
    );
  }
}
