import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/signInandup.dart';
import 'package:okul_bilgi_sistemi/helper/validator.dart';
import 'package:okul_bilgi_sistemi/pages/account_creationPage.dart';
import 'package:okul_bilgi_sistemi/pages/homePage.dart';
import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';
import 'package:okul_bilgi_sistemi/widgets/textFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  User? user;
  late bool rememberMe;
  final _formKey = GlobalKey<FormState>();
  static const String _remember = 'rememberMe';
  static const String _sc = 'schoolCode';
  static const String _email = 'userEmail';
  static const String _pass = 'pass';
  late final TextEditingController _epostaController;
  late final TextEditingController _okulkodController;
  late final TextEditingController _sifreController;
  @override
  void initState() {
    _epostaController = TextEditingController();
    _okulkodController = TextEditingController();
    _sifreController = TextEditingController();
    rememberMe = false;
    _loadRememberMeData();

    super.initState();
  }

  Future<void> _loadRememberMeData() async {
    final prefs = await SharedPreferences.getInstance();

    final bool savedRememberMe = prefs.getBool(_remember) ?? false;

    if (savedRememberMe) {
      final String? savedEmail = prefs.getString(_email);
      final String? savedSchoolCode = prefs.getString(_sc);
      final String? savedPassword = prefs.getString(_pass);

      setState(() {
        rememberMe = savedRememberMe;
        if (savedEmail != null) {
          _epostaController.text = savedEmail;
        }
        if (savedSchoolCode != null) {
          _okulkodController.text = savedSchoolCode;
        }
        if (savedPassword != null) {
          _sifreController.text = savedPassword;
        }
      });
    } else {
      setState(() {
        rememberMe = false;
      });
    }
  }

  Future<void> _saveRememberMeData(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_remember, value);

    if (value) {
      await prefs.setString(_email, _epostaController.text.trim());
      await prefs.setString(_sc, _okulkodController.text);
      await prefs.setString(_pass, _sifreController.text);
    } else {
      await prefs.remove(_email);
      await prefs.remove(_sc);
      await prefs.remove(_pass);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = Helper.cihazMod(context);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: isDark
            ? DarkColors.signInarkaPlanRengi
            : LightColors.signInarkaPlanRengi,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? DarkColors.girisContainer
                  : LightColors.girisContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(
              vertical: height / 8,
              horizontal: width / 20,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: height / 25),

                  Container(
                    color: Colors.transparent,
                    height: width / 4.5,
                    width: width / 4.5,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: height / 70),
                  Text(
                    'sign_in.welcome_title'.tr(),
                    style: GoogleFonts.montserrat(
                      fontSize: height / 40,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? DarkColors.hosGeldiniz
                          : LightColors.hosGeldiniz,
                    ),
                  ),
                  SizedBox(height: height / 90),
                  Text(
                    'sign_in.welcome_subtitle'.tr(),
                    style: GoogleFonts.montserrat(
                      fontSize: height / 70,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? DarkColors.devamEtmek
                          : LightColors.devamEtmek,
                    ),
                  ),
                  SizedBox(height: height / 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BuildTextFormField(
                          inputtype: TextInputType.emailAddress,
                          validator: (value) {
                            return Validator.validateEmail(value);
                          },

                          controller: _epostaController,
                          color: isDark
                              ? DarkColors.textFieldText
                              : LightColors.textFieldText,
                          width: width * 0.8,
                          text: 'sign_in.email_field'.tr(),
                          icon: Icons.mail_outline,
                          suffix: false,
                          isDark: isDark,
                        ),
                        SizedBox(height: height / 100),
                        BuildTextFormField(
                          inputtype: TextInputType.text,
                          validator: (value) {
                            return Validator.validateSchoolCode(value);
                          },

                          controller: _okulkodController,
                          color: isDark
                              ? DarkColors.textFieldText
                              : LightColors.textFieldText,
                          width: width * 0.8,
                          text: 'sign_in.school_code_field'.tr(),
                          icon: Icons.school_outlined,
                          suffix: false,
                          isDark: isDark,
                        ),
                        SizedBox(height: height / 100),
                        BuildTextFormField(
                          inputtype: TextInputType.visiblePassword,
                          validator: (value) {
                            return Validator.validatePassword(value);
                          },

                          controller: _sifreController,
                          color: isDark
                              ? DarkColors.textFieldText
                              : LightColors.textFieldText,
                          width: width * 0.8,
                          text: 'sign_in.password_field'.tr(),
                          icon: Icons.lock_outlined,
                          suffix: true,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: height / 40),
                  Container(
                    width: width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: isDark ? Colors.black38 : Colors.green,
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                            _saveRememberMeData(rememberMe);
                          },
                        ),
                        Text(
                          'sign_in.remember_me'.tr(),
                          style: Helper.uyariTextStyle(isDark),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: height / 40),
                  Builder(
                    builder: (BuildContext innerContext) {
                      return BuildButton(
                        color: isDark
                            ? DarkColors.girisYapButon
                            : LightColors.girisYapButon,
                        width: width * 0.8,
                        text: 'sign_in.sign_in_button'.tr(),
                        icon: null,
                        height: height / 20,
                        styleColor: isDark
                            ? DarkColors.girisYapText
                            : LightColors.girisYapText,
                        onTop: () {
                          if (_formKey.currentState!.validate()) {
                            _signIn(innerContext);
                          }
                        },
                        column: false,
                      );
                    },
                  ),
                  SizedBox(height: height / 100),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark ? DarkColors.cizgi : LightColors.cizgi,
                          thickness: 1,
                          height: 20,
                          indent: width / 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'sign_in.or_divider'.tr(),
                          style: GoogleFonts.montserrat(
                            fontSize: height / 70,
                            fontWeight: FontWeight.w500,
                            color: isDark ? DarkColors.veya : LightColors.veya,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDark ? DarkColors.cizgi : LightColors.cizgi,
                          thickness: 1,
                          height: 20,
                          endIndent: width / 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 100),
                  Builder(
                    builder: (BuildContext innerContext) {
                      return BuildButton(
                        color: isDark
                            ? DarkColors.kayitOlButon
                            : LightColors.kayitOlButon,
                        width: width * 0.8,
                        text: 'sign_in.sign_up_button'.tr(),
                        icon: null,
                        height: height / 20,
                        styleColor: isDark
                            ? DarkColors.kayitOlText
                            : LightColors.kayitOlText,
                        onTop: () {
                          signUp(innerContext);
                        },
                        column: false,
                      );
                    },
                  ),
                  SizedBox(height: height / 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    String? ePosta = _epostaController.text.trim();
    String? okulKod = _okulkodController.text;
    String? sifre = _sifreController.text;

    user = await AuthService.signInWithEmailPassword(
      email: ePosta,
      password: sifre,
    );

    if (user != null) {
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: user!, schoolCode: okulKod),
        ),
      );
    }

    return;
  }

  void signUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AcountCreationPage(isDark: Helper.cihazMod(context)),
      ),
    );
  }
}
