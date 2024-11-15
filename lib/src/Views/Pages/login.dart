import 'package:firstapp/src/Services/DependencyContainer.dart';
import 'package:firstapp/src/Services/UserEntity.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/src/Services/Fetch.dart';
import 'dart:convert';
import 'package:firstapp/src/Services/TokenManager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _Login createState() => _Login();
}

class LoginResponse {
  final bool status;
  final Data data;
  final String message;



  LoginResponse(
      {required this.status, required this.data, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final String? token;
  final int expiresIn;
  final User user;
  Data({required this.token, required this.expiresIn,required this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      expiresIn: json['expiresIn'],
      user: User.fromJson(json['user'])
      
    );
  }
}

class _Login extends State<LoginForm> {
  String username = "";
  String password = "";
  String errorMessage = "";

  void initState() {
    super.initState();
    getDependencys();
  }
  
  void getDependencys() async {
    var client = await DependencyContainer.getDependency("client");
    print("dependencys : $client");
  }


  void login(String username, String password) async {
  if (username.isEmpty || password.isEmpty) {
    print("Please fill out all fields.");
  } else {
    try {
      LoginResponse value = await Fetch.login(username, password);

      var datas = value.data;
      print("Token: ${datas.token}");

      // Convert datas.user to JSON string for printing
      print("User details: ${jsonEncode(datas.user)}");

      TokenManager.saveUser(datas.user);

      if (datas.token != null) {
        Navigator.pushNamed(context, '/acceuil');
      } else {
        setState(() {
          errorMessage = "Email or password is incorrect";
        });
        // Show the SnackBar here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Login failed: $error");
      setState(() {
        errorMessage = error.toString();
      });
      // Show the SnackBar for exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 235, 6, 158),
      ),
      body: Container(
        color: const Color.fromARGB(255, 134, 62, 106),
        child: Center(
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: Container(
                    color: const Color.fromARGB(132, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const SizedBox(height: 10),
                          const Text(
                            "Login Form",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Username: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "ex: bakemono",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            children: [
                              Text(
                                "Password: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "ex: passer1234",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                login(username, password);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 115, 45, 103),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/register");
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
