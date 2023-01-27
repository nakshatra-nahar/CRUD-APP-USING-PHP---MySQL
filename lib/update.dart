import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  String passwordValue;
  String emailValue;
  String idValue;
  Update(
      {super.key,
      required this.passwordValue,
      required this.emailValue,
      required this.idValue});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
    email.text = widget.emailValue;
    password.text = widget.passwordValue;
  }

  Future<void> updateData() async {
    String uri = "http://10.0.2.2/CRUD%20API%20FOR%20FLUTTER/update.php";
    try {
      if (email.text != "" || password.text != "") {
        var postReponse = await http.post(Uri.parse(uri), body: {
          "email": email.text,
          "password": password.text,
          "id": widget.idValue
        });
        var getResponse = jsonDecode(postReponse.body);
        if (getResponse['success'] == 'true') {
          final snackBar = SnackBar(
            content: const Text('Record Updated'),
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
            content: const Text('Record Not Updated'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data Using PHP MySQL'),
      ),
      body: Form(
        key: formGlobalKey,
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                        updateData();
                      }
                    },
                    child: Text('Update Data')),
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
