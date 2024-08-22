import 'dart:convert';

import 'package:api_project/Models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var item in data) {
        postList.add(PostModel.fromJson(item as Map<String, dynamic>));
      }
      return postList;
    }
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        titleTextStyle: 
        const TextStyle(
          color: Colors.white, fontSize: 25,
        ),
        title: const Text("Api"),
      ),
      body: Column(
        children: [
          Expanded(
  child: FutureBuilder(
    future: getPostApi(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) { // Show loading if no data yet
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  ListTile(
              title: Text('Title\n'+postList[index].title.toString()),
              subtitle: Text('Description\n'+postList[index].body.toString()),
            )
                ],
              ),
            );
          },
        );
      }
    },
  ),
)

        ],
      ),
    );
  }
}
