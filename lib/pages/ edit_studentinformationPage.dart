import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/faceAPI.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/photo.dart';
import 'package:okul_bilgi_sistemi/helper/validator.dart';
import 'package:okul_bilgi_sistemi/widgets/appBar.dart';
import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';
import 'package:okul_bilgi_sistemi/widgets/textFormField.dart';
import 'package:okul_bilgi_sistemi/widgets/uyar%C4%B1.dart';

// ignore: must_be_immutable
class EditStudentInformationPage extends StatefulWidget {
  String schoolCode;
  bool isDark;
  Map<String, dynamic> student;
  EditStudentInformationPage({
    super.key,
    required this.schoolCode,
    required this.student,
    required this.isDark,
  });

  DateTime? time;

  @override
  State<EditStudentInformationPage> createState() =>
      _EditStudentInformationState();
}

class _EditStudentInformationState extends State<EditStudentInformationPage> {
  late bool infoTrue;
  late bool photoTrue;
  late var embedding;
  final _formKey = GlobalKey<FormState>();
  late final FirebaseFirestore _firestore;
  late final TextEditingController _ogradController;
  late final TextEditingController _ogrsoyadController;
  late final TextEditingController _ogrdateController;
  @override
  void initState() {
    infoTrue = false;
    photoTrue = widget.student['embedding'] == null ? false : true;
    embedding = widget.student['embedding'];

    _firestore = FirebaseFirestore.instance;
    _ogradController = TextEditingController();
    _ogrsoyadController = TextEditingController();
    _ogrdateController = TextEditingController();

    _ogradController.text = widget.student['isim'];
    _ogrsoyadController.text = widget.student['soyad'];
    _ogrdateController.text = widget.student['dogum_tarihi'].toString();

    super.initState();
  }

  @override
  void dispose() {
    _ogradController.dispose();
    _ogrsoyadController.dispose();
    _ogrdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;

    return Scaffold(
      appBar: StdWidgets.standartAppBar(
        'edit_student.title'.tr(),
        isDark ? Colors.white : Colors.black54,
      ),
      backgroundColor: isDark
          ? DarkColors.ogrenciDuzenleArkaPlan
          : LightColors.ogrenciDuzenleArkaPlan,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? DarkColors.ogrenciDuzenleContainer
                    : LightColors.ogrenciDuzenleContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                vertical: height / 35,
                horizontal: width / 20,
              ),
              width: width * 0.9,
              height: height * 0.344,
              margin: EdgeInsets.symmetric(
                vertical: height / 100,
                horizontal: width / 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'edit_student.student_info'.tr(),
                          style: Helper.sorguTextStyle(isDark),
                        ),
                        infoTrue
                            ? Image.asset(
                                'assets/images/yesil_tik.png',
                                height: height / 45,
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BuildTextFormField(
                            inputtype: TextInputType.name,
                            validator: (value) {
                              return Validator.validateName(value);
                            },

                            controller: _ogradController,
                            color: isDark
                                ? DarkColors.ogrenciDuzenleInputText
                                : LightColors.ogrenciDuzenleInputText,
                            width: width * 0.8,
                            text: 'edit_student.name'.tr(),
                            icon: Icons.person_outline,
                            suffix: false,
                            isDark: isDark,
                          ),
                          SizedBox(height: height / 50),
                          BuildTextFormField(
                            inputtype: TextInputType.name,
                            validator: (value) {
                              return Validator.validateSurname(value);
                            },

                            controller: _ogrsoyadController,
                            color: isDark
                                ? DarkColors.ogrenciDuzenleInputText
                                : LightColors.ogrenciDuzenleInputText,
                            width: width * 0.8,
                            text: 'edit_student.surname'.tr(),
                            icon: Icons.person_outline,
                            suffix: false,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height / 50),

                    DateTimePicker(
                      type: DateTimePickerType.date,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      controller: _ogrdateController,
                      style: TextStyle(
                        color: isDark
                            ? DarkColors.ogrenciDuzenleInputText
                            : LightColors.ogrenciDuzenleInputText,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Colors.blue.shade100,
                            width: 2,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),

                          borderSide: BorderSide(
                            color: Colors.blue.shade100,
                            width: 2,
                          ),
                        ),
                        iconColor: isDark
                            ? DarkColors.ogrenciDuzenleInputText
                            : LightColors.ogrenciDuzenleInputText,
                        prefixIcon: Icon(
                          Icons.event,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                        labelText: 'edit_student.birthdate_hint'.tr(),
                        labelStyle: TextStyle(
                          color: isDark
                              ? DarkColors.ogrenciDuzenleInputText
                              : LightColors.ogrenciDuzenleInputText,
                        ),
                      ),

                      onChanged: (val) {
                        widget.time = DateTime.parse(val);
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? DarkColors.ogrenciDuzenleContainer
                    : LightColors.ogrenciDuzenleContainer,
                borderRadius: BorderRadius.circular(30),
              ),

              padding: EdgeInsets.symmetric(
                vertical: height / 35,
                horizontal: width / 20,
              ),
              width: width * 0.9,
              height: height * 0.35,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'edit_student.face_photo'.tr(),
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
                                    ? DarkColors.ogrenciDuzenleNoFace
                                    : LightColors.ogrenciDuzenleNoFace,
                              ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? DarkColors.ogrenciDuzenleGaleriBg
                                  : LightColors.ogrenciDuzenleGaleriBg,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: height / 1000,
                              horizontal: width / 200,
                            ),
                            width: width * 0.37,
                            height: height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: width / 15,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                Text(
                                  'edit_student.gallery'.tr(),
                                  style: Helper.sorguTextStyle(isDark),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => selectImage(),
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? DarkColors.ogrenciDuzenleGaleriBg
                                  : LightColors.ogrenciDuzenleGaleriBg,
                              borderRadius: BorderRadius.circular(15),
                            ),

                            padding: EdgeInsets.symmetric(
                              vertical: height / 1000,
                              horizontal: width / 200,
                            ),
                            width: width * 0.37,
                            height: height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: width / 15,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                Text(
                                  'edit_student.camera'.tr(),
                                  style: Helper.sorguTextStyle(isDark),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => takePhoto(),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    UyariWidget(
                      backgroundColor: isDark
                          ? DarkColors.ogrenciDuzenleContainer
                          : LightColors.ogrenciDuzenleContainer,
                      iconColor: isDark
                          ? DarkColors.ogrenciDuzenleUyariIcon
                          : LightColors.ogrenciDuzenleUyariIcon,
                      color: isDark
                          ? DarkColors.ogrenciDuzenleUyariBg
                          : LightColors.ogrenciDuzenleUyariBg,
                      width: width * 0.9,
                      height: height * 0.15,
                      icon: Icons.filter_center_focus_outlined,
                      liste: [
                        Text(
                          'edit_student.photo_warning_title'.tr(),
                          softWrap: true,
                          style: Helper.sorguTextStyle(isDark),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'edit_student.photo_warning_1'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                        Text(
                          'edit_student.photo_warning_2'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height / 50),
            SizedBox(
              width: width * 0.9,
              child: BuildButton(
                color: isDark
                    ? DarkColors.ogrenciDuzenleGuncelleButon
                    : LightColors.ogrenciDuzenleGuncelleButon,
                onTop: () {
                  if (_formKey.currentState!.validate()) {
                    updateStudent(isDark);
                  }
                },
                width: width * 0.9,
                text: 'edit_student.update_button'.tr(),
                height: height / 20,
                icon: null,
                styleColor: isDark
                    ? DarkColors.ogrenciDuzenleGuncelleText
                    : LightColors.ogrenciDuzenleGuncelleText,
                column: false,
              ),
            ),
            SizedBox(height: height / 50),
            SizedBox(
              width: width * 0.9,
              child: BuildButton(
                color: const Color.fromARGB(255, 235, 98, 34),
                onTop: () {
                  deleteStudent(isDark);
                },
                width: width * 0.9,
                text: 'edit_student.delete_button'.tr(),
                height: height / 20,
                icon: null,
                styleColor: isDark
                    ? DarkColors.ogrenciDuzenleGuncelleText
                    : LightColors.ogrenciDuzenleGuncelleText,
                column: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectImage() async {
    File? selectedFile = await ImagePickerHelper.pickImageFromGallery();

    if (selectedFile != null) {
      print('Dosya yolu: ${selectedFile.path}');
      embedding = (await FaceApiService.getEmbedding(selectedFile))!;
      embedding == null ? photoTrue = false : photoTrue = true;
      setState(() {
        print(embedding.toString());
      });
    } else {}
  }

  void takePhoto() async {
    File? photoFile = await ImagePickerHelper.pickImageFromCamera();
    if (photoFile != null) {
      embedding = (await FaceApiService.getEmbedding(photoFile))!;
      embedding == null ? photoTrue = false : photoTrue = true;
      setState(() {
        print(embedding.toString());
      });
    }
  }

  void updateStudent(bool isDark) async {
    String? isim = _ogradController.text;
    String? soyisim = _ogrsoyadController.text;

    try {
      await _firestore
          .collection('schools')
          .doc(widget.schoolCode)
          .collection('students')
          .doc(widget.student['studentId'])
          .update({
            'isim': isim,
            'soyad': soyisim,
            'dogum_tarihi': widget.time,
            'embedding': embedding,
            'izin': false,
          });
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: true,
        title: 'edit_student.update_success'.tr(),
      );
      Navigator.pop(context);
    } catch (e) {
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: false,
        title: 'edit_student.update_error'.tr() + ': $e',
      );

      print('Firestore Veri Yazma Hatası: $e');
    }
  }

  void deleteStudent(bool isDark) async {
    try {
      await _firestore
          .collection('schools')
          .doc(widget.schoolCode)
          .collection('students')
          .doc(widget.student['studentId'])
          .delete();

      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: true,
        title: 'edit_student.delete_success'
            .tr()
            .replaceAll('{name}', widget.student['isim'])
            .replaceAll('{surname}', widget.student['soyad'])
            .replaceAll('{id}', widget.student['studentId']),
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: false,
        title: 'edit_student.delete_error'.tr() + ': $e',
      );
    }
  }
}
