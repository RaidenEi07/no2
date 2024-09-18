import 'package:flutter/material.dart';
import 'MyBottomSheet.dart';

class SelectionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            width: 40,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return MyBottomSheet();
                  },
                );
              },
              child: Icon(Icons.add, color: Colors.blue),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.black,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildListTiles(context),
                      ),
                    );
                  },
                );
              },
              child: const Text('Chưa có danh mục', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.black,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildListTiles(context),
                      ),
                    );
                  },
                );
              },
              child: const Text('VNINDEX', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildListTiles(BuildContext context) {
    // List of options
    final options = ['Mục A', 'Mục B', 'Mục C'];

    return options.map((String value) {
      return ListTile(
        title: Text(value, style: TextStyle(color: Colors.white)),
        onTap: () {
          // Handle selection
          print('Selected: $value'); // Replace with your handling logic
          Navigator.pop(context);
        },
      );
    }).toList();
  }
}
