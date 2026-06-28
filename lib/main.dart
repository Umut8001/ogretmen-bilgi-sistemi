import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/firebase_options.dart';
import 'package:okul_bilgi_sistemi/pages/sign_inPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('tr'), // türkce
        Locale('en'), //ingilizce
        Locale('ru'), //rusca
        Locale('de'), //almanca
        Locale('fr'), //fransizca
        Locale('es'), //ispanyolca
      ],
      fallbackLocale: const Locale('tr'),
      path: 'assets/translations',
      child: SignInPage(),
    ),
  );
}
