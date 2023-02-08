import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);
  final bool isLoading;
  final void Function(
    bool isLogin,
    String email,
    // String userName,
    String password,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String _email = '';
  // String _userName = '';
  String _password = '';

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid == true) {
      _formKey.currentState?.save();
      log(_email);
      // log(_userName);
      log(_password);
      widget.submitFn(isLogin, _email.trim(), _password.trim()
          // _userName.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
            fit: BoxFit.cover,
            opacity: 0.3),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.network(
                          'https://assets1.lottiefiles.com/packages/lf20_1pxqjqps.json',
                          height: 300,
                          width: 600),

                      Text(
                        isLogin ? 'Log In' : 'Sign Up',
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.purple,
                            fontFamily: 'poppins'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        key: const ValueKey('email'),
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Please enter a Valid Email Address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Email Address",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.purple,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      // if (!isLogin)
                      //   TextFormField(
                      //     key: const ValueKey('Username'),
                      //     validator: (value) {
                      //       if (value == null || value.length < 4) {
                      //         return 'Please enter a UserName';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: const InputDecoration(
                      //        floatingLabelAlignment: FloatingLabelAlignment.center,
                      //     focusedBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(width: 2, color: Colors.purple),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(15))),
                      //     enabledBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(width: 2, color: Colors.purple),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(15))),
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(15))),
                      //       labelText: "User Name",
                      //       filled: true,
                      //     fillColor: Colors.white,
                      //     labelStyle: TextStyle(color: Colors.purple),
                      //      prefixIcon: Icon(
                      //       Icons.person,
                      //       color: Colors.purple,
                      //     ),
                      //     ),
                      //     onSaved: (value) {
                      //       _userName = value!;
                      //     },
                      //   ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        key: const ValueKey('pasword'),
                        validator: (value) {
                          if (value == null || value.length < 7) {
                            return 'Please enter a Strong Password More than 7';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.purple,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      if (widget.isLoading) const CircularProgressIndicator(),
                      if (!widget.isLoading)
                        GestureDetector(
                          onTap: _onSubmit,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                isLogin ? 'Log In' : 'Sign Up',
                                style: const TextStyle(
                                    fontSize: 26, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (!widget.isLoading)
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? 'Create a New Account'
                                  : 'already Have an Account',
                              style: const TextStyle(
                                  color: Colors.purple, fontSize: 20),
                            ))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
