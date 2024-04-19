import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_auth/signup_page.dart';

import 'auth_services/login_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final LoginService _auth= LoginService();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 30),
               TextField(
                 controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement login functionality here
                  _signIn();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 50)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24), // Set padding
                  ),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>const SignUpPage()),
                  );
                },
                  child: const Text("Don't have an account? Sign up", style: TextStyle(fontSize: 18),)
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async{
    // String username=_usernameController.text;
    String email=_emailController.text;
    String password=_passwordController.text;

    User? user=await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is successfully Signed In'),
          duration: Duration(seconds: 5),
        ),
      );
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'email':email,
            'description':'Sample description of the user',
            'image':'images/userimage.png',
          });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error Occured'),
          duration: Duration(seconds: 15),
        ),
      );
    }
  }
}
