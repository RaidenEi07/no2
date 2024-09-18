import 'package:flutter/material.dart';

class SelectableButtonsRow extends StatefulWidget {
  @override
  _SelectableButtonsRowState createState() => _SelectableButtonsRowState();
}

class _SelectableButtonsRowState extends State<SelectableButtonsRow> {
  bool _isSelectedAtoZ = false;
  bool _isSelectedZtoA = false;
  bool _isSelectedRecent = false;

  void _toggleSelection(String button) {
    setState(() {
      if (button == 'A-Z') {
        _isSelectedAtoZ = !_isSelectedAtoZ;
        _isSelectedZtoA = false;
        _isSelectedRecent = false;
      } else if (button == 'Z-A') {
        _isSelectedZtoA = !_isSelectedZtoA;
        _isSelectedAtoZ = false;
        _isSelectedRecent = false;
      } else if (button == 'Recent') {
        _isSelectedRecent = !_isSelectedRecent;
        _isSelectedAtoZ = false;
        _isSelectedZtoA = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildButton('A-Z', _isSelectedAtoZ),
          _buildButton('Giá', _isSelectedZtoA),
          _buildButton('Khối lượng', _isSelectedRecent),
        ],
      ),
    );
  }

  Widget _buildButton(String label, bool isSelected) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          onPressed: () => _toggleSelection(label),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.white)),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}