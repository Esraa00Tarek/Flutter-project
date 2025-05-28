// ignore: file_names
import 'package:flutter/material.dart';
import '../constants/colors.dart'; 
import './SignUp.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: tdBlack,
                  ),
                ),
              ),
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email,
                errorText: _emailError,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() => _emailError = 'Email is required');
                    return '';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    setState(() => _emailError = 'Enter a valid email');
                    return '';
                  }
                  setState(() => _emailError = null);
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                errorText: _passwordError,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() => _passwordError = 'Password is required');
                    return '';
                  }
                  if (value.length < 6) {
                    setState(() => _passwordError = 'Password must be at least 6 characters');
                    return '';
                  }
                  setState(() => _passwordError = null);
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    color: tdBlue,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0.0, 0.0),
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(100, 60),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: tdGrey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: tdBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    String? errorText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(0.0, 0.0),
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              prefixIcon: Icon(icon, color: tdGrey, size: 20),
              prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 25),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: tdGrey),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 15),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: const Text(
        'Login',
        style: TextStyle(
          color: tdBlack,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      leading: const Icon(
        Icons.menu,
        color: tdBlack,
        size: 30,
      ),
    );
  }
}