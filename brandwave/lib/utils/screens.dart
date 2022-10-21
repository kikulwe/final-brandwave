import 'dart:io';
import 'package:brandwave/models/CustomUser.dart';
import "package:flutter/material.dart";

class AdvertScreenArguments {
  final String ? name;
  final String ? description;
  List<File> ? files;

  AdvertScreenArguments(this.name, this.description, this.files);
}

class userScreenArguments {
  final CustomUser user;

  userScreenArguments(this.user);
}