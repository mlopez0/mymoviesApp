import 'package:flutter/material.dart';
import 'package:mymoviesapp/homeScreen.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'credential.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _valid = true;
  var errorMsg;
  final TextEditingController mailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  Credential userSave = Credential();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background_5.jpg"), fit: BoxFit.cover)),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'My Movies',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 50.0, left: 50.0),
                    child: TextFormField(
                      controller: mailController,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 50.0, left: 50.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ),
                  _valid
                      ? Center(child: Text(''))
                      : Center(
                          child: Text(
                          'Invalid Credentials',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                  ),
                  RaisedButton.icon(
                    elevation: 10.0,
                    color: Colors.grey[100],
                    icon: Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    label: Text('Log-in',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 100.0, left: 100.0),
                    onPressed: () {
                      print("Login pressed");
                      setState(() {
                        _isLoading = true;
                      });
                      signIn(mailController.text, passwordController.text);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                  ),
                ],
              ),
            ),
    ));
  }

  signIn(String email, pass) async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    Map data = {'email': email, 'password': pass};
    Map data = {'email': "eve.holt@reqres.in", 'password': "cityslicka"};
    var jsonResponse = null;
    var response = await http.post("https://reqres.in/api/login", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body); //TOKEN
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        userSave.token = jsonResponse['token'];
        userSave.username = data['email'];
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
        _valid = false;
      });
      errorMsg = response.body;
//      _valid = true;
      print("The error message is: ${response.body}");
    }
  }
}
