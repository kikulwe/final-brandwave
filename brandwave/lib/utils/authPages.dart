import 'package:brandwave/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import "package:brandwave/services/database.dart";

class AuthPageStarter extends StatelessWidget {
  const AuthPageStarter({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "BRANDWAVE",
            style: TextStyle(
              fontSize: 26.0,
              color: Color.fromRGBO(33, 150, 243, 1),
              fontWeight: FontWeight.w600
            ),
          ),
          Divider(height: 5.0,color: Color.fromARGB(0, 33, 149, 243),),
          Text(
            "Mobile Advertisement",
            style: TextStyle(
              fontSize: 16.0,
                color: Colors.black45
            ),
          ),
        ],
      ),
    );
  }
}


class SignInForm extends StatefulWidget {
  const   SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String ? errorMsg;

  final AuthService _auth = AuthService();

  void redirect() => Navigator.pushNamed(context, '/authCheck');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Sign In To Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 58, 144, 214),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10.0),
          errorMsg != null ? Text(
            errorMsg!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.red,
              fontWeight: FontWeight.normal,
            ),
          ) : const SizedBox(height: 0,),
          const SizedBox(height: 5.0),
          TextFormField(
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 69, 161, 236),
            ),
            controller: emailController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
              ),
              labelText: "Email",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 69, 161, 236),
              ),
            ),
            onChanged: (text) => {},
          ),
          const Divider(height: 10.0,color: Colors.transparent,),
          TextFormField(
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 69, 161, 236),
            ),
            controller: passwordController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
              ),
              labelText: "Password",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 69, 161, 236),
              ),
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            onChanged: (text) => {},
          ),
          const Divider(height: 15.0,color: Colors.transparent,),
          ElevatedButton(
            onPressed: () async {
              // dynamic result = await _auth.signInAnon();
              if (emailController.text == null && passwordController.text == null) {
                return null;
              }
              dynamic result = await _auth.signIn(emailController.text, passwordController.text);
              if (result == "User Account not Found") {
                setState(() {
                  errorMsg = result;
                });
              }
              if (result != null) {
                redirect();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Sign In", style: TextStyle(fontSize: 17.0),),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signUp'),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Create Account", style: TextStyle(fontSize: 16.0),),
            ),
          ),
        ],
      ),
    );
  }
}



class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final contactController = TextEditingController();

  String ? errorMsg;
  String ? successMsg;

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    contactController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Create New Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 58, 144, 214),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10.0),
          errorMsg != null ? Text(
            errorMsg!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.red,
              fontWeight: FontWeight.normal,
            ),
          ) : const SizedBox(height: 0,),
          successMsg != null ? Text(
            successMsg!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.greenAccent,
              fontWeight: FontWeight.normal,
            ),
          ) : const SizedBox(height: 0,),
          const Divider(height: 10.0,color: Colors.transparent,),
          TextFormField(
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 69, 161, 236),
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
              ),
              labelText: "Username",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 69, 161, 236),
              ),
            ),
            controller: usernameController,
          ),
          const Divider(height: 10.0,color: Colors.transparent,),
          TextFormField(
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 69, 161, 236),
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
              ),
              labelText: "Contact",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 69, 161, 236),
              ),
            ),
            controller: contactController,
          ),
          const Divider(height: 10.0,color: Colors.transparent,),
          TextFormField(
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 69, 161, 236),
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
              ),
              labelText: "Email",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 69, 161, 236),
              ),
            ),
            controller: emailController,
          ),
          const Divider(height: 10.0,color: Colors.transparent,),
          TextFormField(
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 69, 161, 236),
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 3, color: Color.fromRGBO(33, 149, 243, 0.551))
              ),
              labelText: "Password",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 69, 161, 236),
              ),
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: passwordController,
          ),
          const Divider(height: 15.0,color: Colors.transparent,),
          ElevatedButton(
            onPressed: () async {

              if (emailController.text == null && passwordController.text == null) {
                return null;
              }
              dynamic result = await _auth.signUp(emailController.text, passwordController.text);
              if (result == "The password provided is too weak" ||result == "email-already-in-use" ) {
                setState(() {
                  errorMsg = result;
                });
              }
              else if (result != null) {

                await DatabaseService().addUser(
                    result!.uid, usernameController.text, contactController.text
                );

                emailController.dispose();
                passwordController.dispose();
                usernameController.dispose();
                contactController.dispose();

                setState(() {
                  successMsg = "Account created Successfully. Please Login.";
                });
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Register", style: TextStyle(fontSize: 17.0),),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signin'),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Already Have An Account", style: TextStyle(fontSize: 16.0),),
            ),
          ),
        ],
      ),
    );
  }
}