// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:domain_firebase/firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:domain_firebase/screen/new_item_screen.dart';
// import 'package:domain_firebase/screen/edit_item_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection("items").snapshots(),
//         builder:
//             ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//           final dataDocuments = snapshot.data?.docs;
//           if (dataDocuments == null) return const Text("No data");
//           return ListView.builder(
//             itemCount: dataDocuments.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(dataDocuments[index]["name"]),
//                 subtitle: Text(dataDocuments[index]["desc"]),
//                 onTap: () => _editItemScreen(dataDocuments[index].id,
//                     dataDocuments[index]["name"], dataDocuments[index]["desc"]),
//               );
//             },
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _createNewItem,
//         tooltip: 'Create New Item',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void _createNewItem() {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => NewItemScreen()));
//   }

//   void _editItemScreen(String documentid, String itemName, String itemDesc) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 EditItemScreen(documentid, itemName, itemDesc)));
//   }
// }
