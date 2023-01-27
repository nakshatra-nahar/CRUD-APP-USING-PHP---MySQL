import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:php_crud/view.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> insertData() async {
    if (email.text != "" || password.text != "") {
      try {
        String uri =
            'http://10.0.2.2/CRUD%20API%20FOR%20FLUTTER/insert_data.php';
        var giveResponse = await http.post(Uri.parse(uri),
            body: {'email': email.text, 'password': password.text});
        var getResponse = jsonDecode(giveResponse.body);
        if (getResponse['success'] == 'true') {
          final ViewData getData = new ViewData();
          
          final snackBar = SnackBar(
            content: const Text('Record Inserted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: const Text('Record Not Inserted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Enter All Filed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserting Data Using PHP MySQL'),
      ),
      body: Form(
        key: formGlobalKey,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Email'),
                validator: (email) {
                  if (email.toString().isEmpty) {
                    return 'Enter Email';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Password'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Enter Password';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15.0), shape: StadiumBorder()),
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        insertData();
                      }
                    },
                    child: Text('Save Data')),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
