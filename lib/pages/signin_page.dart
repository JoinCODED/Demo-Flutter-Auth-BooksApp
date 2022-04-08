import 'package:books_app/models/user.dart';
import 'package:books_app/providers/auth_provider.dart';
import 'package:books_app/widgets/add_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign In"),
            TextField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signin(
                    user: User(
                        username: usernameController.text,
                        password: passwordController.text));
              },
              child: const Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
