import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu Principal',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Launch'),
            onTap: () {
              Navigator.pushNamed(context, '/launch');
            },
          ),
          ListTile(
            title: Text('Mission'),
            onTap: () {
              Navigator.pushNamed(context, '/mission');
            },
          ),
        ],
      ),
    );
  }
}
