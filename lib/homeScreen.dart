import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mymoviesapp/searchScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'config.dart';
import 'movieCell.dart';
import 'movieTitles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var movies;
  Color mainColor = Colors.black;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Movie App");
  String movie2search;

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
//      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
        title: cusSearchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search your favorite movie"),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    onSubmitted: (term) {
                      movie2search = term.toString();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen(movie2search: movie2search),
                        ),
                      );
                    },
                  );
//                  print('search');
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("Movie App");
                }
              });
            },
            icon: cusIcon,
          ),
        ],
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
              MovieTitle(mainColor),
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

Future<Map> getJson() async {
  var apiKey = getApiKey();
  var url = 'https://api.themoviedb.org/3/discover/movie?api_key=${apiKey}';
  var response = await http.get(url);
  return json.decode(response.body);
}
