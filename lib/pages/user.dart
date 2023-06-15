import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  void alert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Try again'))
        ],
      ),
    );
  }

  void _save() {
    final fields = <String>[
      _name.text,
      _username.text,
      _password.text,
      _confirmPassword.text
    ];

    if (fields.any((field) => field.trim().isEmpty)) {
      alert('An required field is empty');
      return;
    }

    if (_password.text != _confirmPassword.text) {
      alert('Password isn\'t equal to confirmation');
      return;
    }

    _name.text = '';
    _username.text = '';
    _password.text = '';
    _confirmPassword.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New user')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _name,
            ),
            TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(labelText: 'Username'),
              controller: _username,
            ),
            TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: _password,
            ),
            TextFormField(
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(labelText: 'Confirm password'),
              obscureText: true,
              controller: _confirmPassword,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
