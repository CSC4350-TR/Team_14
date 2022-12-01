// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ViewImages extends StatelessWidget {
//   List<NetworkImage> _listOfImages = <NetworkImage>[];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: 20,
//         ),
//         Flexible(
//             child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection('Images').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           _listOfImages = [];
//                           for (int i = 0;
//                               i <
//                                   snapshot.data!.docs[index].data['urls'].length;
//                               i++) {
//                             _listOfImages.add(NetworkImage(snapshot
//                                 .data!.docs[index].data(['urls'])[i]));
//                           }
//                           return Column(
//                             children: <Widget>[
                             
//                               Container(
//                                 height: 1,
//                                 width: MediaQuery.of(context).size.width,
//                                 color: Colors.red,
//                               )
//                             ],
//                           );
//                         });
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 }))
//       ],
//     );
//   }
// }
