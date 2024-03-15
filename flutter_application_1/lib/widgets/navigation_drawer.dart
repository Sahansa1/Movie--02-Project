import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/watch_list_screen.dart';
import 'package:flutter_application_1/Screens/watched_list_screen.dart';


import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/login.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
          accountName: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              }
              var userDocument = snapshot.data!;
              return Text(userDocument['name']);
            },
          ),
          accountEmail: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }

                var userDocument = snapshot.data!;
                return Text(userDocument['email']);
              },
            ),
            currentAccountPicture: Image.asset(
              'assets/mug.png', 
              width:300, 
              height: 300, 
            ),
          decoration: BoxDecoration(
          color: Colours.colBackground,
            
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
          ListTile(
              title: Text('Sign Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthGate()));
              },
          ),
        ],
      ),
    );
  }
}