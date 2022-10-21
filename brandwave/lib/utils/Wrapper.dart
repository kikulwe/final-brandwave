import 'package:brandwave/models/CustomUser.dart';
import 'package:brandwave/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:brandwave/pages/signInPage.dart';
import 'package:provider/provider.dart';
import "package:brandwave/models/CustomUser.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>((context));

    return user != null ? const HomePage() : const SignInPage();
  }
}
