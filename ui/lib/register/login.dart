import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:spotify/endpoints.dart';
import 'package:spotify/routes.dart';
import 'package:spotify/store.dart';
import 'package:spotify/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a custom Form widget.
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _Login extends State<Login> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final firstFormController = TextEditingController();
  final secondFormController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstFormController.dispose();
    secondFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            padding: EdgeInsets.all(16),

            child: Column(
              children: [
                Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'username',
                  ),
                  style: TextStyle(color: Colors.white),
                  controller: firstFormController,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                  ),
                  style: TextStyle(color: Colors.white),
                  controller: secondFormController,
                ),

                Row(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(ThemeColors.cardColor),
                      ),
                      onPressed: () async {
                        // var username = firstFormController.text;
                        // var password = secondFormController.text;

                        var username = 'valentin';
                        var password = '123456789qwe';

                        var response = await http.post(Uri.parse(Endpoints.login),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              "username": username,
                              "password": password,
                            }));

                        debugPrint(response.body);

                        final prefs = await SharedPreferences.getInstance();
                        if (response.statusCode == 200) {
                          prefs.setString(StoreKey.token, response.body);
                        }

                        debugPrint(prefs.getString(StoreKey.token));

                      },
                      child: Text('Login'),
                    ),

                    Spacer(),

                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(ThemeColors.cardColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: Text('Signup'),
                    ),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}