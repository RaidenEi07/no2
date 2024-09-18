import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:no2/Provider/Provider.dart';

class NewListScreen extends StatefulWidget {
  @override
  _NewListScreenState createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tạo danh sách mới')),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Nhập tên danh sách'),
            ),
            Expanded(
              child: Consumer<ListProvider>(
                builder: (context, listProvider, child) {
                  final items = listProvider.availableItems;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(items[index]),
                        value: selectedItems.contains(items[index]),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedItems.add(items[index]);
                            } else {
                              selectedItems.remove(items[index]);
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ListProvider>(context, listen: false).saveList(
                  _nameController.text,
                  selectedItems,
                );
                Navigator.pop(context);
              },
              child: Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}