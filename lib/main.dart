import 'package:domain_firebase/screen/login_screen.dart';
import 'package:domain_firebase/services/auth_service.dart';
import 'package:domain_firebase/services/item_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// New Team Page

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:domain_firebase/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:domain_firebase/screen/new_item_screen.dart';
import 'package:domain_firebase/screen/edit_item_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kawinphop 633410142-5',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    // setup req data user email
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.deepOrange),
            child: Text("You're Welcome: \t$displayEmail"),
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              _service.logout(currentUser);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            }
            // call logout()
            // redirect to login page
            ,
          )
        ],
      )),

      /*body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                //'$_counter',
                '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),*/

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");

          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                return ListTile(
                  title: Text(dataDocuments[index]["name"]),
                  subtitle: Row(
                    children: [
                      Text(dataDocuments[index]["desc"]),
                    ],
                  ),
                  onTap: () => _editItemScreen(
                    dataDocuments[index].id,
                    dataDocuments[index]["name"],
                    dataDocuments[index]["desc"],
                    dataDocuments[index]["email"],
                    dataDocuments[index]["phone"],
                  ),
                );
              });
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'Create New Item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  void _editItemScreen(String documentid, String itemName, String itemDesc,
      String itemEmail, String itemPhone) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditItemScreen(
                documentid, itemName, itemDesc, itemEmail, itemPhone)));
  }
}
