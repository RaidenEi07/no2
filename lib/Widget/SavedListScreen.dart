import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:no2/Provider/Provider.dart';
import 'package:intl/intl.dart';

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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh các widget bên trái
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${savedItems[index]['symbol']} | ${savedItems[index]['exchange']}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // Thêm hai Text widget ở đây
                    Text(
                      '${(savedItems[index]['closePrice'] / 1000).toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8), // Khoảng cách giữa các Text
                    Text(
                      '+${(savedItems[index]['change'] / 1000).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: (savedItems[index]['change'] > 0)
                            ? Colors.green // Màu xanh lá nếu lớn hơn 0
                            : (savedItems[index]['change'] < 0)
                            ? Colors.red // Màu đỏ nếu nhỏ hơn 0
                            : Colors.orange, // Màu vàng cam nếu bằng 0
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        savedItems[index]['FullName'],
                        style: TextStyle(color: Colors.white30, fontSize: 12),
                      ),
                    ),
                    // Thêm hai Text widget ở đây
                    Text(
                      '${NumberFormat('#,##0').format(savedItems[index]['totalTrading'])} ',
                      style: TextStyle(color: Colors.white30, fontSize: 14),
                    ),
                    SizedBox(width: 8), // Khoảng cách giữa các Text
                    Text(
                      '+${(savedItems[index]['changePercent']).toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: (savedItems[index]['changePercent'] > 0)
                            ? Colors.green // Màu xanh lá nếu lớn hơn 0
                            : (savedItems[index]['changePercent'] < 0)
                            ? Colors.red // Màu đỏ nếu nhỏ hơn 0
                            : Colors.orange, // Màu vàng cam nếu bằng 0
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
