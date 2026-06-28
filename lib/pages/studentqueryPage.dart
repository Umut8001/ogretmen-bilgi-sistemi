// ignore: file_names
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/faceAPI.dart';
import 'package:okul_bilgi_sistemi/helper/getogrinfo.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/photo.dart';
import 'package:okul_bilgi_sistemi/helper/searchStudent.dart' as SearchStudent;
import 'package:okul_bilgi_sistemi/helper/validator.dart';
import 'package:okul_bilgi_sistemi/widgets/appBar.dart';
import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';
import 'package:okul_bilgi_sistemi/widgets/studentInfo.dart';
import 'package:okul_bilgi_sistemi/widgets/textFormField.dart';

class StudentQueryPage extends StatefulWidget {
  bool isDark;
  String schoolCode;
  StudentQueryPage({super.key, required this.schoolCode, required this.isDark});

  late var embedding;

  @override
  State<StudentQueryPage> createState() => _StudentQueryPageState();
}

class _StudentQueryPageState extends State<StudentQueryPage> {
  late bool infoTrue;
  late bool photoTrue;
  late bool ogrNum;
  late Map<String, dynamic>? beststd;
  late Stream<QuerySnapshot> studentStream;
  late List<Map<String, dynamic>> newstudents;
  late TextEditingController ogrnumaraController;

  @override
  void initState() {
    super.initState();
    beststd = null;
    ogrNum = false;
    photoTrue = false;
    infoTrue = false;
    studentStream = Getogrinfo.streamStudents(schoolCode: widget.schoolCode);
    ogrnumaraController = TextEditingController();
  }

  @override
  void dispose() {
    ogrnumaraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark
          ? DarkColors.ogrAraarkaPlanRengi
          : LightColors.ogrAraarkaPlanRengi,
      appBar: StdWidgets.standartAppBar(
        'student_query.title'.tr(),
        isDark ? Colors.white : Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: studentStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Bir hata oluştu: ${snapshot.error}'),
                  );
                }

                if (snapshot.hasData) {
                  newstudents = snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> studentData =
                        doc.data() as Map<String, dynamic>;

                    studentData['studentId'] = doc.id;
                    return studentData;
                  }).toList();

                  return Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? DarkColors.ogrAraContainer
                          : LightColors.ogrAraContainer,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height / 35,
                      horizontal: width / 20,
                    ),
                    width: width * 0.9,
                    //height: height * 0.37,
                    margin: EdgeInsets.symmetric(
                      vertical: height / 100,
                      horizontal: width / 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'student_query.select_method'.tr(),
                                style: Helper.sorguTextStyle(isDark),
                              ),
                              photoTrue
                                  ? Image.asset(
                                      'assets/images/yesil_tik.png',
                                      height: height / 45,
                                    )
                                  : Icon(
                                      Icons.face_retouching_off_sharp,
                                      color: isDark
                                          ? DarkColors.ogrAraNoFace
                                          : LightColors.ogrAraNoFace,
                                    ),
                            ],
                          ),
                          SizedBox(height: height / 100),
                          Row(
                            children: [
                              BuildButton(
                                color: isDark
                                    ? DarkColors.ogrAraButon
                                    : LightColors.ogrAraButon,
                                onTop: () {
                                  setState(() {
                                    photoTrue = false;
                                    ogrNum = true;
                                    beststd = null;
                                  });
                                },
                                width: width * 0.388,
                                text: 'student_query.search_by_number'.tr(),
                                height: height / 12,
                                icon: Icons.numbers_outlined,
                                styleColor: isDark
                                    ? DarkColors.ogrAraButontext
                                    : LightColors.ogrAraButontext,
                                column: true,
                              ),
                              SizedBox(width: width / 50),
                              BuildButton(
                                color: isDark
                                    ? DarkColors.ogrAraButon
                                    : LightColors.ogrAraButon,
                                onTop: () {
                                  setState(() {
                                    ogrNum = false;
                                    selectImage();
                                  });
                                },
                                width: width * 0.388,
                                text: 'student_query.search_by_gallery'.tr(),
                                height: height / 12,
                                icon: Icons.image_outlined,
                                styleColor: isDark
                                    ? DarkColors.ogrAraButontext
                                    : LightColors.ogrAraButontext,
                                column: true,
                              ),
                            ],
                          ),
                          SizedBox(height: height / 100),
                          Row(
                            children: [
                              BuildButton(
                                color: isDark
                                    ? DarkColors.ogrAraButon
                                    : LightColors.ogrAraButon,
                                onTop: () {
                                  setState(() {
                                    ogrNum = false;
                                  });
                                },
                                width: width * 0.388,
                                text: 'student_query.search_by_live'.tr(),
                                height: height / 12,
                                icon: Icons.bolt_outlined,
                                styleColor: isDark
                                    ? DarkColors.ogrAraButontext
                                    : LightColors.ogrAraButontext,
                                column: true,
                              ),
                              SizedBox(width: width / 50),
                              BuildButton(
                                color: isDark
                                    ? DarkColors.ogrAraButon
                                    : LightColors.ogrAraButon,
                                onTop: () {
                                  setState(() {
                                    ogrNum = false;
                                    takePhoto();
                                  });
                                },
                                width: width * 0.388,
                                text: 'student_query.search_by_camera'.tr(),
                                height: height / 12,
                                icon: Icons.camera_alt_outlined,
                                styleColor: isDark
                                    ? DarkColors.ogrAraButontext
                                    : LightColors.ogrAraButontext,
                                column: true,
                              ),
                            ],
                          ),
                          ogrNum
                              ? Column(
                                  children: [
                                    SizedBox(height: height / 50),
                                    BuildTextFormField(
                                      inputtype: TextInputType.number,
                                      validator: null,
                                      controller: ogrnumaraController,
                                      color: isDark
                                          ? DarkColors.ogrAraTextField
                                          : LightColors.ogrAraTextField,
                                      width: width * 0.8,
                                      text: 'student_query.number_field'.tr(),
                                      icon: Icons.numbers_outlined,
                                      suffix: false,
                                      isDark: isDark,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),

            ((beststd == null && photoTrue == true) ||
                    (beststd == null && ogrNum == true))
                ? Text(
                    'student_query.not_found'.tr(),
                    style: Helper.sorguTextStyle(isDark),
                  )
                : SizedBox(),
            (beststd != null && ogrNum == false && photoTrue == true) ||
                    (beststd != null && ogrNum == true && photoTrue == false)
                ? Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? DarkColors.ogrAraContainer
                          : LightColors.ogrAraContainer,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height / 400,
                      horizontal: width / 100,
                    ),
                    width: width * 0.9,
                    height: height * 0.10,
                    margin: EdgeInsets.symmetric(
                      vertical: height / 200,
                      horizontal: width / 40,
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return Studentinfo(
                                isDark: isDark,
                                student: beststd!,
                                izin: beststd?['izin'],
                                height: height,
                                width: width,
                                schoolCode: widget.schoolCode,
                              );
                            },
                          );
                          setState(() {
                            _numaraylaAra();
                          });
                        },
                        style: ListTileStyle.list,
                        title: Text(
                          '${beststd?['isim']!} ${beststd?['soyad']!}',
                          style: Helper.duyuruTitleTextStyle(isDark),
                        ),
                        trailing: beststd?['izin']
                            ? Icon(
                                Icons.task_alt_outlined,
                                color: isDark
                                    ? DarkColors.ogrAraIziznli
                                    : LightColors.ogrAraIziznli,
                                size: width / 15,
                              )
                            : Icon(
                                Icons.do_not_disturb_alt,
                                color: isDark
                                    ? DarkColors.ogrAraIzinsiz
                                    : LightColors.ogrAraIzinsiz,
                                size: width / 15,
                              ),
                        leading: Text(
                          beststd?['studentId']?.toString() ?? 'id',
                          style: Helper.sorguTextStyle(isDark),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            photoTrue == false && ogrNum
                ? Column(
                    children: [
                      SizedBox(height: height / 100),
                      BuildButton(
                        color: isDark
                            ? DarkColors.ogrAraButon
                            : LightColors.ogrAraButon,
                        onTop: () {
                          setState(() {
                            _numaraylaAra();
                          });
                        },
                        width: width * 0.9,
                        text: 'student_query.search_button'.tr(),
                        height: height / 20,
                        icon: Icons.search,
                        styleColor: isDark
                            ? DarkColors.ogrAraButontext
                            : LightColors.ogrAraButontext,
                        column: false,
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void selectImage() async {
    File? selectedFile = await ImagePickerHelper.pickImageFromGallery();
    if (selectedFile != null) {
      widget.embedding = await FaceApiService.getEmbedding(selectedFile);
      print(widget.embedding);
      if (widget.embedding != null) {
        setState(() {
          beststd = SearchStudent.findMostSimilarStudent(
            newstudents,
            widget.embedding,
          );
        });
        photoTrue = true;
      } else {
        photoTrue = false;
      }
    } else {}
  }

  void takePhoto() async {
    File? photoFile = await ImagePickerHelper.pickImageFromCamera();
    if (photoFile != null) {
      widget.embedding = await FaceApiService.getEmbedding(photoFile);
      if (widget.embedding != null) {
        beststd = SearchStudent.findMostSimilarStudent(
          newstudents,
          widget.embedding,
        );
        photoTrue = true;
      } else {
        photoTrue = false;
      }
    }
  }

  void _numaraylaAra() {
    String? numara = ogrnumaraController.text;
    beststd = null;
    newstudents.forEach((element) {
      if (element['studentId'] == numara) {
        beststd = element;
      }
    });
  }
}
