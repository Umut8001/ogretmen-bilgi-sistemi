import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/school.dart';
import 'package:okul_bilgi_sistemi/helper/signInandup.dart';
import 'package:okul_bilgi_sistemi/pages/school_codePage.dart';
import 'package:okul_bilgi_sistemi/widgets/createSchoolAccount.dart';
import 'package:okul_bilgi_sistemi/widgets/createTeacherAccountPage.dart';
import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AcountCreationPage extends StatefulWidget {
  bool isDark;
  AcountCreationPage({super.key, required this.isDark});
  @override
  State<AcountCreationPage> createState() => _AcountCreationPageState();
}

class _AcountCreationPageState extends State<AcountCreationPage> {
  String? scm = 'teacher';
  User? user;
  static const Uuid uuid = Uuid();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKeySchool = GlobalKey<FormState>();
  final _formKeyTeacher = GlobalKey<FormState>();
  late final TextEditingController okuladController;
  late final TextEditingController okuladresController;
  late final TextEditingController okulepostaController;
  late final TextEditingController telnoController;
  late final TextEditingController okultelnoController;

  late final TextEditingController adController;
  late final TextEditingController soyadController;
  late final TextEditingController epostaController;
  late final TextEditingController ogrttelnoController;
  late final TextEditingController okulkodController;
  late final TextEditingController sifreController;
  late final TextEditingController sifretekrarController;

  @override
  void initState() {
    okuladController = TextEditingController();
    okuladresController = TextEditingController();
    okulepostaController = TextEditingController();
    telnoController = TextEditingController();
    okultelnoController = TextEditingController();

    adController = TextEditingController();
    soyadController = TextEditingController();
    epostaController = TextEditingController();
    ogrttelnoController = TextEditingController();
    okulkodController = TextEditingController();
    sifreController = TextEditingController();
    sifretekrarController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    okuladController.dispose();
    okuladresController.dispose();
    okulepostaController.dispose();
    telnoController.dispose();
    okultelnoController.dispose();

    adController.dispose();
    soyadController.dispose();
    epostaController.dispose();
    ogrttelnoController.dispose();
    okulkodController.dispose();
    sifreController.dispose();
    sifretekrarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: isDark
              ? DarkColors.hesapOlusturTextAktif
              : LightColors.hesapOlusturTextAktif,
        ),
      ),
      backgroundColor: isDark
          ? DarkColors.hesapOlusturArkaPlan
          : LightColors.hesapOlusturArkaPlan,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              user == null
                  ? Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? DarkColors.hesapOlusturContainer
                            : LightColors.hesapOlusturContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: width * 0.9,
                      height: height / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'account_creation.school_account'.tr(),
                            style: GoogleFonts.montserrat(
                              fontSize: height / 70,
                              fontWeight: FontWeight.w500,
                              color: scm == 'school'
                                  ? (isDark
                                        ? DarkColors.hesapOlusturTextAktif
                                        : LightColors.hesapOlusturTextAktif)
                                  : (isDark
                                        ? DarkColors.hesapOlusturTextPasif
                                        : LightColors.hesapOlusturTextPasif),
                            ),
                          ),

                          Radio<String>(
                            activeColor: isDark
                                ? DarkColors.hesapOlusturRadio
                                : LightColors.hesapOlusturRadio,
                            value: 'school',
                            // ignore: deprecated_member_use
                            groupValue: scm,
                            // ignore: deprecated_member_use
                            onChanged: (value) {
                              setState(() {
                                scm = value;
                              });
                            },
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: isDark
                                ? DarkColors.hesapOlusturDivider
                                : LightColors.hesapOlusturDivider,
                          ),
                          Radio<String>(
                            activeColor: isDark
                                ? DarkColors.hesapOlusturRadio
                                : LightColors.hesapOlusturRadio,
                            value: 'teacher',
                            // ignore: deprecated_member_use
                            groupValue: scm,

                            // ignore: deprecated_member_use
                            onChanged: (value) {
                              setState(() {
                                scm = value;
                              });
                            },
                          ),
                          Text(
                            'account_creation.teacher_account'.tr(),
                            style: GoogleFonts.montserrat(
                              fontSize: height / 70,
                              fontWeight: FontWeight.w500,
                              color: scm == 'teacher'
                                  ? (isDark
                                        ? DarkColors.hesapOlusturTextAktif
                                        : LightColors.hesapOlusturTextAktif)
                                  : (isDark
                                        ? DarkColors.hesapOlusturTextPasif
                                        : LightColors.hesapOlusturTextPasif),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? DarkColors.hesapOlusturContainer
                            : LightColors.hesapOlusturContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: width * 0.9,
                      padding: EdgeInsets.all(width / 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/yesil_tik.png',
                              height: height / 10,
                            ),
                          ),
                          Text(
                            'account_creation.title_success'.tr(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: height / 40,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? DarkColors.hesapOlusturBasariBaslik
                                  : LightColors.hesapOlusturBasariBaslik,
                            ),
                          ),
                          SizedBox(height: height / 90),
                          Text(
                            'account_creation.subtitle_success'.tr(),
                            style: GoogleFonts.montserrat(
                              fontSize: height / 70,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? DarkColors.hesapOlusturTextPasif
                                  : LightColors.hesapOlusturTextPasif,
                            ),
                          ),
                        ],
                      ),
                    ),
              user != null ? SizedBox(height: height * 0.45) : SizedBox(),
              scm == 'school' && user == null
                  ? BuildSchoolAccountPage(
                      formKey: _formKeySchool,
                      okuladController: okuladController,
                      okuladresController: okuladresController,
                      okulepostaController: okulepostaController,
                      telnoController: telnoController,
                      okultelnoController: okultelnoController,
                    )
                  : SizedBox(),

              scm == 'teacher' && user == null
                  ? BuildTeacherAccountPage(
                      formkey: _formKeyTeacher,
                      adController: adController,
                      soyadController: soyadController,
                      epostaController: epostaController,
                      telnoController: ogrttelnoController,
                      okulkodController: okulkodController,
                      sifretekrarController: sifretekrarController,
                      sifreController: sifreController,
                    )
                  : SizedBox(),

              Builder(
                builder: (BuildContext innerContext) {
                  return user == null
                      ? BuildButton(
                          color: isDark
                              ? DarkColors.hesapOlusturButonBg
                              : LightColors.hesapOlusturButonBg,
                          width: width * 0.9,
                          text: 'account_creation.register_button'.tr(),
                          icon: Icons.check_circle_outlined,
                          height: height / 20,
                          styleColor: isDark
                              ? DarkColors.hesapOlusturButonText
                              : LightColors.hesapOlusturButonText,
                          onTop: () {
                            if (scm == 'school') {
                              if (_formKeySchool.currentState!.validate()) {
                                createSchoolAccount();
                              }
                            } else {
                              if (_formKeyTeacher.currentState!.validate()) {
                                createTeacherAccount();
                              }
                            }
                          },
                          column: false,
                        )
                      : BuildButton(
                          color: isDark
                              ? DarkColors.hesapOlusturButonBg
                              : LightColors.hesapOlusturButonBg,
                          width: width * 0.9,
                          text: 'account_creation.done_button'.tr(),
                          icon: Icons.check_circle_outlined,
                          height: height / 20,
                          styleColor: isDark
                              ? DarkColors.hesapOlusturButonText
                              : LightColors.hesapOlusturButonText,
                          onTop: () {
                            Navigator.pop(context);
                          },
                          column: false,
                        );
                },
              ),
              SizedBox(height: height / 10),
            ],
          ),
        ),
      ),
    );
  }

  void createTeacherAccount() async {
    String? ad = adController.text;
    String? soyad = soyadController.text;
    String? telno = telnoController.text;
    String? ePosta = epostaController.text.trim();
    String? okulkodu = okulkodController.text;

    String sifre = sifreController.text;
    // ignore: unused_local_variable
    String sifretekrar = sifretekrarController.text;

    user = await AuthService.createAccountWithCode(
      email: ePosta,
      password: sifre,
      schoolCode: okulkodu,
      name: ad,
      surname: soyad,
      telNo: telno,
    );

    setState(() {});
  }

  void createSchoolAccount() async {
    String? okulAd = okuladController.text;
    String? okulAdres = okuladresController.text;
    String? okulEposta = okulepostaController.text.trim();
    String? okulTelNo = okultelnoController.text;
    String okulKod = uuid.v4().substring(0, 8);
    School okul = School(
      ad: okulAd,
      adres: okulAdres,
      ePosta: okulEposta,
      telNo: okulTelNo,
      okulKod: okulKod,
    );

    await _firestore.collection('schools').doc(okulKod).set({
      'adres': okul.adres,
      'email': okul.ePosta,
      'createdAt': FieldValue.serverTimestamp(),
      'isim': okul.ad,
      'telNo': okul.telNo,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SchoolCodePage(okulKod: okulKod)),
    );
  }
}
