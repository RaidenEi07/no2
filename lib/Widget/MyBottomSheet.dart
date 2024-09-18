import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NewListScreen.dart';
import 'package:no2/Provider/Provider.dart';


class MyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF55595C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)), // Bo tròn góc trên
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Khoảng cách bên trong
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Them danh sach moi', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewListScreen()));
              },
            ),
            if (Provider.of<ListProvider>(context).savedItems.isNotEmpty)
              ListTile(
                title: Text('Xoa danh sach hien tai', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Provider.of<ListProvider>(context, listen: false).deleteList();
                },
              ),
            // Thêm nút đóng Bottom Sheet
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Khoảng cách hai bên
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng Bottom Sheet
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.0), // Khoảng cách dọc cho nút
                  backgroundColor: Colors.transparent, // Màu nền trong suốt
                ),
                child: Text('Đóng', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}