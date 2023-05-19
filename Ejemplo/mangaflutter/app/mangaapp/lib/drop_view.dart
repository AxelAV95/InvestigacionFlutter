import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mangaapp/view_data.dart';

class MyForm extends StatefulWidget {
   const MyForm({super.key});
 
  @override
  _MyFormState createState() => _MyFormState();
}


class _MyFormState extends State<MyForm> {
  late String _selectedItem;

  final List<String> _items = <String>[    'Item 1',    'Item 2',    'Item 3',    'Item 4',  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Select an item',
                border: OutlineInputBorder(),
              ),
              value: _selectedItem,
              items: _items.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement form submission
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
