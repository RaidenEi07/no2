import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF23272A),
      title: Text('BIDV Securities', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.refresh, color: Colors.white)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}