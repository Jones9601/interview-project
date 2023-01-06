// ignore_for_file: unnecessary_string_escapes

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interviewproject/model/data.model.dart';
import 'package:interviewproject/model/first-task.model.dart';

import '../utils/http-utils.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<data> value = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Log In'),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.backpack)),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                ),
                onChanged: (text) {
                  setState(() {});
                },
              )),
          Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  final RegExp emailRegExp = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  );
                  if (emailRegExp.hasMatch(value ?? '')) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
                onChanged: (text) {
                  setState(() {});
                },
              )),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) return Colors.red;
                return null; // Defer to the widget's default.
              }),
            ),
            onPressed: () {
              setState(() {
                value.add(data.fromJson({
                  "name": nameController.text,
                  "email": emailController.text
                }));
              });
              print('====== > ${value}');
            },
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}
