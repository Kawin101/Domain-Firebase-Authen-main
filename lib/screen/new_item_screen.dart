import 'dart:js';

import 'package:domain_firebase/services/item_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewItemScreen extends StatelessWidget {
  // Create object
  final _itemName = TextEditingController();
  final _itemDesc = TextEditingController();
  final _itemEmil = TextEditingController();
  final _itemPhone = TextEditingController();

  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemName,
              decoration: InputDecoration(label: Text("Item Name")),
            ),
            TextField(
              controller: _itemDesc,
              decoration:
                  InputDecoration(label: const Text("Item Description")),
            ),
            TextField(
              controller: _itemEmil,
              decoration: InputDecoration(label: Text("Item Email")),
            ),
            TextField(
              controller: _itemPhone,
              decoration: InputDecoration(label: Text("Item Phone")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _addItem(context);
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  _addItem(BuildContext context) {
    _itemService.addItem2Firebase(_itemName.text, {
      "name": _itemName.text,
      "desc": _itemDesc.text,
      "email": _itemEmil.text,
      "phone": _itemPhone.text
    });
    Navigator.pop(context);
  }
}
