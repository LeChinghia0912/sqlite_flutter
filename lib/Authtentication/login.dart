import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Authtentication/signup.dart';
import 'package:sqflite/sqflite.dart';
import '../screen/product_screen.dart';
import '../service/authservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();

  late AuthService authService;

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    Database db = await openDatabase(
      'my_db.db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, userName TEXT, password TEXT, token TEXT)',
        );
      },
    );
    authService = AuthService(db);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      bool isLoggedIn = await authService.login(username.text, password.text);
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/login.png',
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  // UserName
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.1),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "UserName is required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              border: InputBorder.none,
                              hintText: 'UserName'),
                        ),
                      ],
                    ),
                  ),
                  // Password
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.1),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          obscureText: _obscureText,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ],
                    ),
                  ),

                  //Text Button
                  const SizedBox(height: 10),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple),
                      child: TextButton(
                          onPressed: _login,
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ))),
                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text('SignUp'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
