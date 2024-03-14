// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_application_1/colour.dart';
// // import 'package:flutter_application_1/constants.dart';

// // class WatchListScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colours.colBackground,
// //       appBar: AppBar(
// //         title: Text('Watch List'),
// //       ),
// //       body: StreamBuilder(
// //       stream: FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(FirebaseAuth.instance.currentUser!.uid)
// //           .collection('watch') 
// //           .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //           if (snapshot.hasError) {
// //             return Center(
// //               child: Text('Error: ${snapshot.error}'),
// //             );
// //           }
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Center(
// //               child: Text('No movies added to watch list.'),
// //             );
// //           }
// //           return ListView(
// //             children: snapshot.data!.docs.map((doc) {
// //               Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
// //               return Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: InkWell(
// //                   onTap: () {
// //                   //have to add the moviedetails screen 
// //                   },
// //                   child: Card(
// //                     elevation: 3,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Row(
// //                         children: [
// //                           // Movie Image
// //                           Container(
// //                             width: 100,
// //                             height: 150,
// //                             decoration: BoxDecoration(
// //                               image: DecorationImage(
// //                                 image: NetworkImage('${Constants.imagePath}${data['poster_path']}'),
// //                                 fit: BoxFit.cover,
// //                               ),
// //                               borderRadius: BorderRadius.circular(8.0),
// //                             ),
// //                           ),
                          
// //                           SizedBox(width: 10),
// //                           // Movie Details
// //                           Expanded(
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   data['title'],
// //                                   style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 4),
// //                                 Text(
// //                                   data['overview'],
// //                                   maxLines: 2,
// //                                   overflow: TextOverflow.ellipsis,
// //                                 ),
// //                                 SizedBox(height: 4),
// //                                 Text(
// //                                   'Release Date: ${data['release_date']}',
// //                                   style: TextStyle(
// //                                     color: Colors.grey,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/colour.dart';
// import 'package:flutter_application_1/constants.dart';

// class WatchListScreen extends StatefulWidget {
//   @override
//   _WatchListScreenState createState() => _WatchListScreenState();
// }

// class _WatchListScreenState extends State<WatchListScreen> {
//   bool _isAscending = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colours.colBackground,
//       appBar: AppBar(
//         title: Text('Watch List'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.sort),
//             onPressed: () {
//               setState(() {
//                 _isAscending = !_isAscending;
//               });
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection('watch')
//             .orderBy('title', descending: !_isAscending) // Ordering based on title
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No movies added to watch list.'),
//             );
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               Map<String, dynamic> data =
//                   doc.data() as Map<String, dynamic>;
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     // Navigate to movie details screen
//                   },
//                   child: Card(
//                     elevation: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           // Movie Image
//                           Container(
//                             width: 100,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                     '${Constants.imagePath}${data['poster_path']}'),
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           // Movie Details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data['title'],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   data['overview'],
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   'Release Date: ${data['release_date']}',
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/constants.dart';

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.colBackground,
      appBar: AppBar(
        title: Text('Watch List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() {
                _isAscending = !_isAscending;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('watch')
            .orderBy('title', descending: !_isAscending) // Ordering based on title
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No movies added to watch list.'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data =
                  doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Navigate to movie details screen
                  },
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Movie Image
                          Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${Constants.imagePath}${data['poster_path']}'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Movie Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  data['overview'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Release Date: ${data['release_date']}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


