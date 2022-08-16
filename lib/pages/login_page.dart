import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testscout/bloc/bloc/login_bloc.dart';

import '../routes/routes.dart';
import '../services/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = true;
    bool remember = false;

  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    remember = Prefs.username?.isNotEmpty ?? false;
    _usernameController.text = Prefs.username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 230, 242, 1),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.only(
                  top: 80,
                ),
                child: Center(
                  child: Text(
                    'ERM MOBILE',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        color: Color.fromRGBO(57, 115, 172, 1)),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Center(
                child: SizedBox(
                    height: 100.0,
                    width: 200.0,
                    child: Image.asset('assets/images/ic_logo.png')),
              ),
            ),
            // _body,
            Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _body,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget get _body => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(57, 115, 172, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(120),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Hi, Welcome Back!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          // fontFamily:,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // fontFamily:,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 255, 255, 1))),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 255, 255, 1))),
                            hintText: "Enter your username",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: visible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: visible
                                  ? Icon(Icons.visibility_outlined)
                                  : Icon(Icons.visibility_off_outlined),
                              onPressed: () => setState(
                                () => visible = !visible,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 255, 255, 1))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 255, 255, 1))),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginError) {
                          showErrorDialog(message: state.message);
                        } else if (state is LoginLoaded) {
                          Navigator.pushReplacementNamed(
                              context, Routes.routeHomeStart);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: InkWell(
                              onTap: (() {
                                BlocProvider.of<LoginBloc>(context).add(LoginViewModel(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                  remember: remember,
                                ));
                              }),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 30,
                                ),
                                width: double.infinity,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(38, 50, 56, 0.66),
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  ScaffoldFeatureController showErrorDialog({String? message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? 'Please enter username/password!'),
      ),
    );
  }
}