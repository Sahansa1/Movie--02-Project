import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text('nanan'), 
            accountEmail: Text('lalalal@dadad'), 
          //currentAccountPicture: CircleAvatar(
            //child: Iamge.,
          
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
          )
        ],
      ),
    );
  }
}

