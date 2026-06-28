import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
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
class AddStudent extends StatefulWidget {
  String schoolCode;
  bool isDark;
  AddStudent({super.key, required this.schoolCode, required this.isDark});

  DateTime? time;
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  late bool infoTrue;
  late bool photoTrue;
  late var embedding;
  final _formKey = GlobalKey<FormState>();
  late final FirebaseFirestore _firestore;
  late final TextEditingController _ogradController;
  late final TextEditingController _ogrsoyadController;
  late final TextEditingController _ogrnumaraController;
  late final TextEditingController _ogrdateController;
  @override
  void initState() {
    infoTrue = false;
    photoTrue = false;
    embedding = null;
    _firestore = FirebaseFirestore.instance;
    _ogradController = TextEditingController();
    _ogrsoyadController = TextEditingController();
    _ogrnumaraController = TextEditingController();
    _ogrdateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _ogradController.dispose();
    _ogrnumaraController.dispose();
    _ogrsoyadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;

    return Scaffold(
      appBar: StdWidgets.standartAppBar(
        'add_student.title'.tr(),
        isDark ? Colors.white : Colors.black54,
      ),
      backgroundColor: isDark
          ? DarkColors.ogrenciEklearkaPlanRengi
          : LightColors.ogrenciEklearkaPlanRengi,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? DarkColors.ogrenciEkleContainer
                    : LightColors.ogrenciEkleContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                vertical: height / 35,
                horizontal: width / 20,
              ),
              width: width * 0.9,
              height: height * 0.41,
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
                          'add_student.student_info'.tr(),
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
                                ? DarkColors.textFieldIcon
                                : LightColors.textFieldIcon,
                            width: width * 0.8,
                            text: 'add_student.name'.tr(),
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
                                ? DarkColors.textFieldIcon
                                : LightColors.textFieldIcon,
                            width: width * 0.8,
                            text: 'add_student.surname'.tr(),
                            icon: Icons.person_outline,
                            suffix: false,
                            isDark: isDark,
                          ),
                          SizedBox(height: height / 50),
                          BuildTextFormField(
                            inputtype: TextInputType.number,
                            validator: (value) {
                              return Validator.validateName(value);
                            },

                            controller: _ogrnumaraController,
                            color: isDark
                                ? DarkColors.ogrenciDuzenleInputText
                                : LightColors.ogrenciDuzenleInputText,
                            width: width * 0.8,
                            text: 'add_student.number'.tr(),
                            icon: Icons.numbers_outlined,
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
                        labelText: 'add_student.birthdate_hint'.tr(),
                        labelStyle: TextStyle(
                          color: isDark
                              ? DarkColors.ogrenciDuzenleInputText
                              : LightColors.ogrenciDuzenleInputText,
                        ),
                      ),

                      onChanged: (val) {
                        widget.time = DateTime.tryParse(val) ?? DateTime.now();
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
                    ? DarkColors.ogrenciEkleContainer
                    : LightColors.ogrenciEkleContainer,
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
                          'add_student.face_photo'.tr(),
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
                                    ? DarkColors.ogrEklenoFaceIcon
                                    : LightColors.ogrEklenoFaceIcon,
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
                                  ? DarkColors.ogrEklegaleriKameraButon
                                  : LightColors.ogrEklegaleriKameraButon,
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
                                  color: isDark
                                      ? DarkColors.ogrEklegaleriKameraIcon
                                      : LightColors.ogrEklegaleriKameraIcon,
                                ),
                                Text(
                                  'add_student.gallery'.tr(),
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
                                  ? DarkColors.ogrEklegaleriKameraButon
                                  : LightColors.ogrEklegaleriKameraButon,
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
                                  color: isDark
                                      ? DarkColors.ogrEklegaleriKameraIcon
                                      : LightColors.ogrEklegaleriKameraIcon,
                                ),
                                Text(
                                  'add_student.camera'.tr(),
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
                      iconColor: isDark
                          ? DarkColors.ogrEkleuyariIcon
                          : LightColors.ogrEkleuyariIcon,
                      color: isDark
                          ? DarkColors.ogrEkleuyariArkaPlan
                          : LightColors.ogrEkleuyariArkaPlan,
                      width: width * 0.9,
                      height: height * 0.15,
                      icon: Icons.filter_center_focus_outlined,
                      liste: [
                        Text(
                          'add_student.photo_warning_title'.tr(),
                          softWrap: true,
                          style: Helper.sorguTextStyle(isDark),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'add_student.photo_warning_1'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                        Text(
                          'add_student.photo_warning_2'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                      ],
                      backgroundColor: isDark
                          ? DarkColors.ogrenciEkleContainer
                          : LightColors.ogrenciEkleContainer,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height / 40),
            SizedBox(
              width: width * 0.9,
              child: BuildButton(
                color: isDark
                    ? DarkColors.ogrEklekaydetButon
                    : LightColors.ogrEklekaydetButon,
                onTop: () {
                  if (_formKey.currentState!.validate() && embedding != null) {
                    addStudent(isDark);
                  }
                },
                width: width * 0.9,
                text: 'add_student.save_button'.tr(),
                height: height / 20,
                icon: null,
                styleColor: isDark
                    ? DarkColors.ogrEkleKaydettext
                    : LightColors.ogrEkleKaydettext,
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
      embedding = await FaceApiService.getEmbedding(selectedFile);
      embedding == null ? photoTrue = false : photoTrue = true;
      setState(() {
        print(embedding.toString());
      });
    } else {}
  }

  void takePhoto() async {
    File? photoFile = await ImagePickerHelper.pickImageFromCamera();
    if (photoFile != null) {
      embedding = await FaceApiService.getEmbedding(photoFile);
      embedding == null ? photoTrue = false : photoTrue = true;
      setState(() {
        print(embedding.toString());
      });
    }
  }

  void addStudent(bool isDark) async {
    String? isim = _ogradController.text;
    String? soyisim = _ogrsoyadController.text;
    int? numaraInt = int.tryParse(_ogrnumaraController.text);
    DateTime? dogum_tarihi = DateFormat(
      'yyyy-MM-dd',
    ).parse(_ogrdateController.text);

    if (numaraInt == null) {
      return;
    }
    String numaraId = numaraInt.toString();

    try {
      await _firestore
          .collection('schools')
          .doc(widget.schoolCode)
          .collection('students')
          .doc(numaraId)
          .set({
            'isim': isim,
            'soyad': soyisim,
            'dogum_tarihi': dogum_tarihi,
            'embedding': embedding,
            'izin': false,
          });
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: true,
        title: 'add_student.save_success'.tr(),
      );
      Navigator.pop(context);
    } catch (e) {
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: false,
        title: 'add_student.save_error'.tr() + ': $e',
      );
    }
  }
}
