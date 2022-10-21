import "package:flutter/material.dart";
import 'package:brandwave/utils/authPages.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(62, 202, 202, 202),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AuthPageStarter(),
              Divider(height: 2.5,color: Colors.transparent,),
              Divider(height: 1.0,color: Color.fromRGBO(33, 149, 243, 0.18),),
              SignInForm()
            ],
          ),
        ),
      ),
    );
  }
}
