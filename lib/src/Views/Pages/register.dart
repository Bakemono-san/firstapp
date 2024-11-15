import 'package:firstapp/src/Services/Fetch.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

enum StatusEnum {
  BLOQUER,
  ACTIF,
  INACTIF
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for each field
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idCardNumberController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  StatusEnum? status; // Add your StatusEnum options here
  String? role; // Adjust to use role options

  void register() {
    if (_formKey.currentState!.validate()) {
      
      Fetch.postDatas("auth/register", {"name": nomController.text, "email": emailController.text, "telephone": telephoneController.text, "password": passwordController.text, "idCardNumber": idCardNumberController.text, "adresse": adresseController.text}).then((value) {
        print(value.data.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: const Color.fromARGB(255, 150, 0, 117),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 150, 0, 112),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField("Nom", nomController, "Enter your last name"),
                  _buildTextField("Prenom", prenomController, "Enter your first name"),
                  _buildTextField("Email", emailController, "Enter your email", isEmail: true),
                  _buildTextField("Telephone", telephoneController, "Enter your phone number"),
                  _buildDropdownField("Status", status, (StatusEnum? newValue) {
                    setState(() {
                      status = newValue!;
                    });
                  }),
                  _buildTextField("Password", passwordController, "Enter a strong password", isPassword: true),
                  _buildTextField("Role", TextEditingController(), "Enter your role ID"), // Adjust as necessary
                  _buildTextField("ID Card Number", idCardNumberController, "Enter your ID card number"),
                  _buildTextField("Adresse", adresseController, "Enter your address"),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hintText, {bool isEmail = false, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label is required";
          }
          if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, StatusEnum? selectedValue, ValueChanged<StatusEnum?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<StatusEnum>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
        items: StatusEnum.values.map((status) {
          return DropdownMenuItem<StatusEnum>(
            value: status,
            child: Text(status.toString().split('.').last),
          );
        }).toList(),
        validator: (value) => value == null ? "Please select a status" : null,
      ),
    );
  }
}
