import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_auth/auth_services/login_service.dart';
import 'package:sample_auth/home_page.dart';
import 'package:sample_auth/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {

  final LoginService _auth= LoginService();
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SignUp',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 30),
               TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'username',
                  labelText: 'Username',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 15),
               TextField(
                 controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Implement signup functionality here
                  _signUp();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Set padding
                  ),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 15),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>const LoginPage()),
                    );
                  },
                  child: const Text("Already have an account? Sign In", style: TextStyle(fontSize: 16),)
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async{
    String username=_usernameController.text;
    String email=_emailController.text;
    String password=_passwordController.text;

    User? user=await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is successfully created'),
          duration: Duration(seconds: 5),
        ),
      );
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
