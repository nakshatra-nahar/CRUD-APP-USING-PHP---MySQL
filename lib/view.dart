import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:php_crud/insert.dart';
import 'package:http/http.dart' as http;
import 'package:php_crud/update.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];
  Future<void> getAllData() async {
    String uri = 'http://10.0.2.2/CRUD%20API%20FOR%20FLUTTER/view_data.php';
    var sendReposnse = await http.get(Uri.parse(uri));
    var getResponse = jsonDecode(sendReposnse.body);
    setState(() {
      userData = getResponse;
    });
  }

  Future<void> deleteWithId(id) async {
    String uri =
        'http://10.0.2.2/CRUD%20API%20FOR%20FLUTTER/delete_data.php?id=$id';
    try {
      var sendReponse = await http.post(Uri.parse(uri));
      var getResponse = jsonDecode(sendReponse.body);
      if (getResponse['success'] == 'true') {
        getAllData();
        final snackBar = SnackBar(
          content: const Text('Record Deleted Successfully'),
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
          content: const Text('Record Not Deleted'),
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
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View data Using PHP MySQL'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InsertData()),
            );
          },
          label: Icon(Icons.add)),
      body: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Update(
                          idValue: userData[index]['id'],
                          passwordValue: userData[index]['password'],
                          emailValue: userData[index]['email'])),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(userData[index]['email']),
                  subtitle: Text(userData[index]['password']),
                  trailing: InkWell(
                      onTap: () {
                        deleteWithId(userData[index]['id']);
                      },
                      child: Icon(Icons.delete)),
                ),
              ),
            );
          }),
    );
  }
}
