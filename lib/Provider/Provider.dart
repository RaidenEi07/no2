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
          item['bidPrice3'] = updatedItem['bidPrice3'];
          item['bidVol3'] = updatedItem['bidVol3'];
        }
      }
    }
    notifyListeners();
  }

  void loadAvailableItems() async {
    try {
      final response = await Dio().get('http://192.168.1.7:3000/stocks');
      print('Response data: ${response.data}');
      availableItems = List<Map<String, dynamic>>.from(response.data.map((stock) => {
        'FullName': stock['FullName'],
        'bidPrice3': stock['bidPrice3'],
        'bidVol3': stock['bidVol3'],
      }));
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
      savedItems = List<Map<String, dynamic>>.from(decodedList);
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
}
