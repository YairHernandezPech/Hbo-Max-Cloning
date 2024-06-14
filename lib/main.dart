import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hbo_max/components/Home.dart';
import 'package:hbo_max/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(HbomaxHome());
}