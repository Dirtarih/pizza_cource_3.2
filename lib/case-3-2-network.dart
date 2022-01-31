import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost(int postNumber) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postNumber'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class MyNetworkApp extends StatefulWidget {
  const MyNetworkApp({Key? key}) : super(key: key);

  @override
  _MyNetworkAppState createState() => _MyNetworkAppState();
}

class _MyNetworkAppState extends State<MyNetworkApp> {
  late Future<Post> futurePost;

  @override
  void initState(){
    super.initState();
    futurePost = fetchPost(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Работа по http",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Работа по http"),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Text('Тема: ${snapshot.data!.title}', style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 6),
                      Text('Сообщение: ${snapshot.data!.body}', style: Theme.of(context).textTheme.headline5),
                    ]
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }
          ),
        ),
      ),
    );
  }
}
