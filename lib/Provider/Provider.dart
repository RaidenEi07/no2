import 'package:flutter/material.dart';
import 'package:no2/Services/Socket.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Thêm import này

class ListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> availableItems = [];
  String? savedListName;
  List<Map<String, dynamic>> savedItems = [];
  final SocketService _socketService = SocketService();

  ListProvider() {
    _socketService.connect((data) {
      updateItemPrices(data);
    });
    loadAvailableItems();
    loadSavedList();
  }

  void updateItemPrices(dynamic data) {
    // Assuming data is a list of items with updated prices
    for (var updatedItem in data) {
      for (var item in availableItems) {
        if (item['FullName'] == updatedItem['FullName']) {
          item['symbol'] = updatedItem['symbol']; // Đổi bidPrice3 thành symbol
          item['exchange'] = updatedItem['exchange'];
          item['closePrice'] = updatedItem['closePrice'];
          item['change'] = updatedItem['change'];
          item['totalTrading'] = updatedItem['totalTrading'];
          item['changePercent'] = updatedItem['changePercent'];
        }
      }
    }
    notifyListeners();
  }

  void loadAvailableItems() async {
    try {
      final response = await Dio().get('https://priceapi.bsc.com.vn/datafeed/instruments?symbols=');
      print('Response data: ${response.data}');

      // Assuming the response structure is as provided
      if (response.data['s'] == 'ok') {
        availableItems = List<Map<String, dynamic>>.from(response.data['d'].map((stock) => {
          'FullName': stock['FullName'],
          'symbol': stock['symbol'],
          'exchange': stock['exchange'],
          'closePrice': stock['closePrice'] ?? 0, // Gán giá trị mặc định nếu null
          'change': stock['change'] ?? 0, // Gán giá trị mặc định nếu null
          'totalTrading': stock['totalTrading'] ?? 0, // Gán giá trị mặc định nếu null
          'changePercent': stock['changePercent'] ?? 0, // Gán giá trị mặc định nếu null
        }));
      } else {
        print('Error: ${response.data['em']}');
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  void loadSavedList() async {
    final prefs = await SharedPreferences.getInstance();
    savedListName = prefs.getString('savedListName');

    // Lấy danh sách đã lưu và chuyển đổi từ JSON
    String? savedItemsJson = prefs.getString('savedItems');
    if (savedItemsJson != null) {
      List<dynamic> decodedList = jsonDecode(savedItemsJson);
      savedItems = List<Map<String, dynamic>>.from(decodedList.map((item) => {
        'FullName': item['FullName'],
        'symbol': item['symbol'],
        'exchange': item['exchange'],
        'closePrice': item['closePrice'] ?? 0,
        'change': item['change'] ?? 0,
        'totalTrading': item['totalTrading'] ?? 0,
        'changePercent': item['changePercent'] ?? 0,
      }));
    } else {
      savedItems = [];
    }

    notifyListeners();
  }

  void saveList(String name, List<Map<String, dynamic>> items) async {
    savedListName = name;
    savedItems = items;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedListName', name);

    // Lưu danh sách đã lưu dưới dạng JSON
    String encodedItems = jsonEncode(items);
    await prefs.setString('savedItems', encodedItems);
  }

  void deleteList() async {
    savedListName = null;
    savedItems = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedListName');
    await prefs.remove('savedItems');
  }

  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }

  void sortSavedItems() {
    savedItems.sort((a, b) => a['symbol'].compareTo(b['symbol']));
    notifyListeners();
  }
}
