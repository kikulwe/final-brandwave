import 'package:brandwave/models/CustomUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:brandwave/pages/homePage.dart";
import "package:brandwave/pages/signInPage.dart";
import "package:brandwave/pages/signUpPage.dart";
import "package:brandwave/pages/uploadPage.dart";
import "package:brandwave/utils/Wrapper.dart";
import "package:brandwave/pages/selectLocation.dart";
import "package:firebase_core/firebase_core.dart";
import "package:provider/provider.dart";
import "package:brandwave/services/auth.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

// void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
      return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.white,
        ),
        initialRoute: "/authCheck",
        routes: {
          "/": (context) => const HomePage(),
          "/authCheck": (context) => const Wrapper(),
          "/signin": (context) => const SignInPage(),
          "/signUp": (context) => const SignUpPage(),
          "/uploadAd" : (context) => const UploadAd(),
          "/selectLocation" : (context) => const LocationPage(),
        },
      ),
    );
  }
}