import 'package:flutter/material.dart';
import 'package:oddjobs/services/auth.dart';
import 'package:oddjobs/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function view;
  const SignIn({required this.view});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            //  backgroundColor: Colors.blue,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              // elevation: 0.0,
              title: const Text("Sign In"),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      widget.view();
                    },
                    icon: const Icon(
                      Icons.app_registration,
                      color: Colors.cyan,
                    ),
                    label: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an Password' : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() => loading = false);
                                  setState(() => error = "please valid");
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(color: Colors.blue),
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ))),
          );
  }
}
