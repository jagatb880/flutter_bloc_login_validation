// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc_for_validation/bloc/sign_in_bloc.dart';
import 'package:bloc_for_validation/bloc/sign_in_event.dart';
import 'package:bloc_for_validation/bloc/sign_in_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign with Email"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              BlocBuilder<SignInBloc, SignInState>(
                builder: ((context, state) {
                  if (state is SignInErrorState) {
                    return Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailCtrl,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangedEvent(emailCtrl.text, passwordCtrl.text),
                  );
                },
                decoration: InputDecoration(hintText: "Email Address"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordCtrl,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangedEvent(emailCtrl.text, passwordCtrl.text),
                  );
                },
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<SignInBloc, SignInState>(
                builder: ((context, state) {
                  if (state is SignInLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CupertinoButton(
                    onPressed: () {
                      if (state is SignInValidState) {
                        BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(
                              emailCtrl.text, passwordCtrl.text),
                        );
                      }
                    },
                    color:
                        (state is SignInValidState) ? Colors.blue : Colors.grey,
                    child: Text("Sign In"),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
