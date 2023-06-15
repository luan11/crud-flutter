import 'package:crud_flutter/pages/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _signIn() {
    if (_username.text == 'luan11' && _password.text == '123456') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Username and/or password are invalid'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Try again'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(labelText: 'Username'),
                controller: _username),
            TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                controller: _password),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: _signIn,
                    icon: const Icon(Icons.login_outlined),
                    label: const Text('Go')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
