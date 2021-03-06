import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'config.dart';
import 'movieCell.dart';

class SearchScreen extends StatefulWidget {
  String movie2search;

  SearchScreen({Key key, @required this.movie2search}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState(movie2search);
}

class _SearchScreenState extends State<SearchScreen> {
  var movies;
  String movie2search;
  _SearchScreenState(this.movie2search);

  @override
  void initState() {
    super.initState();
    getDataSearch(movie2search);
  }

  void getDataSearch(movie2search) async {
    var data = await getJsonSearch(movie2search);

    setState(() {
      movies = data['results'];
    });
  }

//      getDataSearch(movie2search);

  @override
  Widget build(BuildContext context) {
//    getDataSearch(movie2search);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
        title: Text(movie2search),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background_5.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: movies == null ? 0 : movies.length,
                    itemBuilder: (context, i) {
                      return FlatButton(
                        child: MovieCell(movies, i),
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {},
                        color: Colors.transparent,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map> getJsonSearch(movie2search) async {
  var apiKey = getApiKey();
  String parsed = movie2search;
  parsed = parsed.replaceAll(' ', '&');

  var url =
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$parsed';

  var response = await http.get(url);

  return json.decode(response.body);
}
