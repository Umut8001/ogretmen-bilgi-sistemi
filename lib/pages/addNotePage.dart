// ignore: file_names
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
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
import 'package:okul_bilgi_sistemi/helper/duyuru.dart';
import 'package:okul_bilgi_sistemi/widgets/buildDuyurular.dart';

// ignore: must_be_immutable
class AddNotePage extends StatefulWidget {
  String? schoolCode;
  bool isDark;
  AddNotePage({super.key, required this.schoolCode, required this.isDark});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late bool infoTrue;
  late bool nextWid;

  late FirebaseFirestore _firestore;
  late TextEditingController _baslikController;
  late TextEditingController _govdeController;
  late int lenght;
  @override
  void initState() {
    infoTrue = false;
    nextWid = false;
    lenght = 0;
    _firestore = FirebaseFirestore.instance;
    _baslikController = TextEditingController();
    _govdeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _baslikController.dispose();
    _govdeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;

    String appBartitle = nextWid
        ? 'add_note.preview_title'.tr()
        : 'add_note.add_title'.tr();

    return Scaffold(
      backgroundColor: isDark
          ? DarkColors.duyuruEkleArkaPlan
          : LightColors.duyuruEkleArkaPlan,
      appBar: StdWidgets.standartAppBar(
        appBartitle,
        isDark ? Colors.white : Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: nextWid
                  ? Center(
                      child: BuildDuyurular(
                        liste: [
                          Duyuru(
                            id: '',
                            title: _baslikController.text,
                            body: _govdeController.text,
                            gorsel: '',
                            createtime: DateTime.now(),
                            updatetime: DateTime.now(),
                          ),
                        ],
                        height: height / 15,
                        schoolCode: widget.schoolCode as String,
                        isDark: isDark,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? DarkColors.duyuruEkleContainer
                            : LightColors.duyuruEkleContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: height / 35,
                        horizontal: width / 20,
                      ),
                      width: width * 0.9,
                      height: height * 0.60,
                      margin: EdgeInsets.symmetric(
                        vertical: height / 100,
                        horizontal: width / 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'add_note.note_section_title'
                                      .tr(), // DÜZELTİLDİ
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
                            BuildTextFormField(
                              onChanged: () {
                                duyuruKontrol();
                              },
                              inputtype: TextInputType.text,
                              validator: null,
                              controller: _baslikController,
                              color: isDark
                                  ? DarkColors.duyuruEkleBaslikInput
                                  : LightColors.duyuruEkleBaslikInput,
                              width: width * 0.8,
                              text: 'add_note.title_field'.tr(),
                              icon: Icons.title_rounded,
                              suffix: false,
                              isDark: isDark,
                            ),
                            SizedBox(height: height / 50),
                            SizedBox(
                              height: width / 1.5,
                              width: width * 0.8,
                              child: TextFormField(
                                cursorColor: isDark
                                    ? DarkColors.duyuruEkleBaslikInput
                                    : LightColors.duyuruEkleBaslikInput,
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                controller: _govdeController,
                                textAlignVertical: TextAlignVertical.top,
                                onChanged: (value) {
                                  setState(() {
                                    lenght = value.length;
                                    duyuruKontrol();
                                  });
                                },
                                style: TextStyle(
                                  color: isDark
                                      ? DarkColors.duyuruEkleBaslikInput
                                      : LightColors.duyuruEkleBaslikInput,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'add_note.body_hint'
                                      .tr(), // DÜZELTİLDİ
                                  labelStyle: TextStyle(
                                    color: isDark
                                        ? DarkColors.duyuruEkleBaslikInput
                                        : LightColors.duyuruEkleBaslikInput,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue.shade100,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? DarkColors.duyuruDuzenleInputBorder
                                          : LightColors.duyuruEkleInputBorder,
                                      //width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height / 200),
                            Text(
                              'add_note.char_count'.tr(
                                namedArgs: {'count': lenght.toString()},
                              ), // DÜZELTİLDİ (Parametreli)
                              style: TextStyle(
                                color: isDark
                                    ? DarkColors.duyuruEkleKarakterSayisi
                                    : LightColors.duyuruEkleKarakterSayisi,
                                fontSize: width / 35,
                              ),
                            ),
                            SizedBox(height: height / 50),
                            UyariWidget(
                              iconColor: Colors.orangeAccent,
                              color: isDark
                                  ? DarkColors.duyuruEkleUyariBg
                                  : LightColors.duyuruEkleUyariBg,
                              width: width * 0.9,
                              height: height * 0.055,
                              icon: Icons.warning_amber_rounded,
                              liste: [
                                const SizedBox(height: 5),
                                Text(
                                  'add_note.warning_title_empty'.tr(),
                                  softWrap: true,
                                  style: Helper.uyariTextStyle(isDark),
                                ),
                                Text(
                                  'add_note.warning_body_length'.tr(),
                                  softWrap: true,
                                  style: Helper.uyariTextStyle(isDark),
                                ),
                              ],
                              backgroundColor: isDark
                                  ? DarkColors.duyuruEkleContainer
                                  : LightColors.duyuruEkleContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            SizedBox(height: height / 20),
            BuildButton(
              color: isDark
                  ? DarkColors.duyuruEkleIleriButon
                  : LightColors.duyuruEkleIleriButon,
              onTop: () {
                setState(() {
                  if (nextWid == true) {
                    setState(() {
                      addNote(isDark);
                    });
                  } else {
                    nextWid = duyuruKontrol();
                  }
                });
              },
              width: width * 0.9,
              text: 'add_note.next_button'.tr(),
              height: height / 20,
              icon: null,
              styleColor: isDark
                  ? DarkColors.duyuruEkleButonText
                  : LightColors.duyuruEkleButonText,
              column: false,
            ),
            SizedBox(height: height / 30),
            nextWid
                ? BuildButton(
                    color: isDark
                        ? DarkColors.duyuruEkleIkincilButon
                        : LightColors.duyuruEkleIkincilButon,
                    onTop: () {
                      setState(() {
                        nextWid = false;
                      });
                    },
                    width: width * 0.9,
                    text: 'add_note.edit_button'.tr(),
                    height: height / 20,
                    icon: null,
                    styleColor: isDark
                        ? DarkColors.duyuruEkleButonText
                        : LightColors.duyuruEkleButonText,
                    column: false,
                  )
                : BuildButton(
                    color: isDark
                        ? DarkColors.duyuruEkleIkincilButon
                        : LightColors.duyuruEkleIkincilButon,
                    onTop: () {
                      setState(() {
                        _baslikController.text = '';
                        _govdeController.text = '';
                        infoTrue = false;
                        lenght = 0;
                      });
                    },
                    width: width * 0.9,
                    text: 'add_note.clear_button'.tr(),
                    height: height / 20,
                    icon: null,
                    styleColor: isDark
                        ? DarkColors.duyuruEkleButonText
                        : LightColors.duyuruEkleButonText,
                    column: false,
                  ),
          ],
        ),
      ),
    );
  }

  bool duyuruKontrol() {
    if (_baslikController.text != '' && lenght >= 10) {
      infoTrue = true;
      return true;
    } else {
      infoTrue = false;
      return false;
    }
  }

  void addNote(bool isDark) async {
    String? baslik = _baslikController.text;
    String? govde = _govdeController.text;
    try {
      await _firestore
          .collection('schools')
          .doc(widget.schoolCode)
          .collection('notes')
          .add({
            'title': baslik,
            'body': govde,
            'createtime': FieldValue.serverTimestamp(),
            'updatetime': FieldValue.serverTimestamp(),
          });

      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: true,
        title: 'add_note.success_message'.tr(),
      );
      Navigator.pop(context);
    } catch (e) {
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: false,
        title: 'add_note.error_message'.tr() + ': $e',
      );
    }
  }
}
