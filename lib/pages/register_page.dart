import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:mobile_app/services/api_handler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final TextEditingController _firstName = TextEditingController(),
      _lastName = TextEditingController(),
      _password = TextEditingController(),
      _emailAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.computer_outlined,
                size: 50,
              ),
              const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              TextField(
                controller: _firstName,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
              TextField(
                controller: _lastName,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
              TextField(
                controller: _emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _password,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    ApiHandler().register({
                      "firstName": _firstName.text,
                      "lastName": _lastName.text,
                      "email": _emailAddress.text,
                      "password": _password.text,
                    }).then((value) {
                      if (value) {
                        context.router.replaceAll([const LoginRoute()]);
                      }
                    });
                    //
                  },
                  child: const Text('Register!'),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.router.push(const LoginRoute());
                },
                child: const Text(
                  'Login instead',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
