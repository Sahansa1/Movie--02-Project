import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/watch_list_screen.dart';
import 'package:flutter_application_1/Screens/watched_list_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('nanan'), 
            accountEmail: Text('lalalal@dadad'), 
            //currentAccountPicture: CircleAvatar(
            //  child: Iamge.,
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite), 
            title: const Text('Watch List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WatchListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.done_all), 
            title: const Text('Watched List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WatchedListScreen()), 
              );
            },
          ),
        ],
      ),
    );
  }
}