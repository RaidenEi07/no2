import 'package:flutter/material.dart';
import 'package:no2/Services/Socket.dart';
import 'package:dio/dio.dart';

class ListProvider extends ChangeNotifier {
  List<String> availableItems = [];
  String? savedListName;
  List<String> savedItems = [];
  final SocketService _socketService = SocketService();

  ListProvider() {
    _socketService.connect();
    loadAvailableItems(); // Load available items when the provider is created
    _socketService.socket!.on('updateItems', (data) {
      availableItems = List<String>.from(data);
      notifyListeners();
    });
  }

  void loadAvailableItems() async {
    try {
      final response = await Dio().get('http://192.168.1.7:3000/stocks');
      print('Response data: ${response.data}'); // In ra dữ liệu nhận được
      availableItems = List<String>.from(response.data.map((stock) => stock['companyName']));
      notifyListeners();
    } catch (e) {
      print('Error fetching items: $e');
    }
  }


  void saveList(String name, List<String> items) {
    savedListName = name;
    savedItems = items;
    notifyListeners();
  }

  void deleteList() {
    savedListName = null;
    savedItems = [];
    notifyListeners();
  }

  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }
}