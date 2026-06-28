// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/duyuru.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';

import 'package:okul_bilgi_sistemi/widgets/appBar.dart';
import 'package:okul_bilgi_sistemi/widgets/buildDuyurular.dart';
import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';
import 'package:okul_bilgi_sistemi/widgets/textFormField.dart';
import 'package:okul_bilgi_sistemi/widgets/uyar%C4%B1.dart';

// ignore: must_be_immutable
class EditNotePage extends StatefulWidget {
  final List<Duyuru> notelist;
  final String? schoolCode;
  final String? noteId;
  bool isDark;
  EditNotePage({
    super.key,
    required this.schoolCode,
    required this.notelist,
    this.noteId,
    required this.isDark,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late bool infoTrue;
  late int lenght;
  late bool nextWid;
  late String createTime;
  late String updateTime;
  late Duyuru? selectedDuyuru;
  late String? selectedDuyuruId;
  final _formKey = GlobalKey<FormState>();
  late final FirebaseFirestore _firestore;
  late final TextEditingController _baslikController;
  late final TextEditingController _govdeController;
  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _baslikController = TextEditingController();
    _govdeController = TextEditingController();

    infoTrue = false;
    lenght = 0;
    nextWid = false;
    createTime = '';
    updateTime = '';

    selectedDuyuruId = widget.noteId;

    searchNote();

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
    print(selectedDuyuru?.id);
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;

    String appBartitle = nextWid
        ? 'edit_note.preview_title'.tr()
        : 'edit_note.edit_title'.tr();

    return Scaffold(
      backgroundColor: isDark
          ? DarkColors.duyuruDuzenleArkaPlan
          : LightColors.duyuruDuzenleArkaPlan,
      appBar: StdWidgets.standartAppBar(
        appBartitle,
        isDark ? Colors.white : Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nextWid
                ? SizedBox()
                : Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? DarkColors.duyuruDuzenleContainer
                          : LightColors.duyuruDuzenleContainer,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: height / 200,
                      horizontal: width / 20,
                    ),
                    width: width * 0.9,
                    margin: EdgeInsets.symmetric(
                      vertical: height / 100,
                      horizontal: width / 20,
                    ),
                    child: DropdownButton<String>(
                      value: selectedDuyuru?.id,
                      hint: Text(
                        'edit_note.select_note'.tr(),
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      dropdownColor: isDark
                          ? DarkColors.duyuruDuzenleContainer
                          : LightColors.duyuruDuzenleContainer,
                      isExpanded: true,
                      underline: SizedBox(),
                      items: widget.notelist.map((duyuru) {
                        return DropdownMenuItem<String>(
                          value: duyuru.id,
                          child: Text(
                            duyuru.title,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDuyuruId = value;
                          searchNote();
                          _yerlestir();
                        });
                      },
                    ),
                  ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: nextWid
                  ? Center(
                      child: BuildDuyurular(
                        isDark: isDark,
                        liste: [
                          Duyuru(
                            id: '',
                            title: _baslikController.text,
                            body: _govdeController.text,
                            gorsel: '',
                            createtime: selectedDuyuru!.createtime,
                            updatetime: DateTime.now(),
                          ),
                        ],
                        height: height / 15,
                        schoolCode: widget.schoolCode as String,
                      ),
                    )
                  : selectedDuyuru != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? DarkColors.duyuruDuzenleContainer
                            : LightColors.duyuruDuzenleContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: height / 35,
                        horizontal: width / 20,
                      ),
                      width: width * 0.9,
                      height: height * 0.625,
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
                                  'edit_note.note_section_title'.tr(),
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
                              inputtype: TextInputType.text,
                              validator: null,
                              controller: _baslikController,
                              color: isDark
                                  ? DarkColors.duyuruDuzenleBaslikInput
                                  : LightColors.duyuruDuzenleBaslikInput,
                              width: width * 0.8,
                              text: 'edit_note.title_field'.tr(),
                              icon: Icons.title_rounded,
                              suffix: false,
                              isDark: isDark,
                            ),
                            SizedBox(height: height / 50),
                            SizedBox(
                              height: width / 1.7,
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
                                  labelText: 'edit_note.body_hint'.tr(),
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height / 200),
                            Text(
                              'edit_note.char_count'.tr(
                                namedArgs: {'count': lenght.toString()},
                              ),
                              style: TextStyle(
                                color: isDark
                                    ? DarkColors.duyuruDuzenleKarakterSayisi
                                    : LightColors.duyuruDuzenleKarakterSayisi,
                                fontSize: width / 35,
                              ),
                            ),
                            SizedBox(height: height / 50),
                            UyariWidget(
                              iconColor: isDark
                                  ? DarkColors.duyuruDuzenleUyariIcon
                                  : LightColors.duyuruDuzenleUyariIcon,
                              color: isDark
                                  ? DarkColors.duyuruDuzenleUyariBg
                                  : LightColors.duyuruDuzenleUyariBg,
                              width: width * 0.9,
                              height: height * 0.055,
                              icon: Icons.warning_amber_rounded,
                              liste: [
                                const SizedBox(height: 5),
                                Text(
                                  'edit_note.warning_title_empty'.tr(),
                                  softWrap: true,
                                  style: Helper.uyariTextStyle(isDark),
                                ),
                                Text(
                                  'edit_note.warning_body_length'.tr(),
                                  softWrap: true,
                                  style: Helper.uyariTextStyle(isDark),
                                ),
                              ],
                              backgroundColor: isDark
                                  ? DarkColors.duyuruDuzenleContainer
                                  : LightColors.duyuruDuzenleContainer,
                            ),
                            SizedBox(height: height / 50),
                            UyariWidget(
                              iconColor: isDark
                                  ? DarkColors.duyuruDuzenleTarihIcon
                                  : LightColors.duyuruDuzenleTarihIcon,
                              color: isDark
                                  ? DarkColors.duyuruDuzenleTarihBg
                                  : LightColors.duyuruDuzenleTarihBg,
                              width: width * 0.9,
                              height: height * 0.055,
                              icon: Icons.date_range_outlined,
                              liste: [
                                SizedBox(height: 5),
                                Text(
                                  'edit_note.created_date'.tr() + createTime,
                                  softWrap: true,
                                  style: Helper.uyariTextStyle(isDark),
                                ),
                                createTime == updateTime
                                    ? Text(
                                        'edit_note.updated_date'.tr() +
                                            updateTime,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black,
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                              backgroundColor: isDark
                                  ? DarkColors.duyuruDuzenleContainer
                                  : LightColors.duyuruDuzenleContainer,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            SizedBox(height: height / 100),
            BuildButton(
              color: isDark
                  ? DarkColors.duyuruDuzenleIleriButon
                  : LightColors.duyuruDuzenleIleriButon,
              onTop: () {
                setState(() {
                  if (nextWid == true) {
                    updateNote(isDark);
                  } else {
                    nextWid = duyuruKontrol();
                  }
                });
              },
              width: width * 0.9,
              text: 'edit_note.next_button'.tr(),
              height: height / 20,
              icon: null,
              styleColor: isDark
                  ? DarkColors.duyuruDuzenleButonText
                  : LightColors.duyuruDuzenleButonText,
              column: false,
            ),
            SizedBox(height: height / 80),
            nextWid
                ? BuildButton(
                    color: isDark
                        ? DarkColors.duyuruDuzenleIkincilButon
                        : LightColors.duyuruDuzenleIkincilButon,
                    onTop: () {
                      setState(() {
                        nextWid = false;
                      });
                    },
                    width: width * 0.9,
                    text: 'edit_note.edit_button_continue'.tr(),
                    height: height / 20,
                    icon: null,
                    styleColor: isDark
                        ? DarkColors.duyuruDuzenleButonText
                        : LightColors.duyuruDuzenleButonText,
                    column: false,
                  )
                : BuildButton(
                    color: isDark
                        ? DarkColors.duyuruDuzenleIkincilButon
                        : LightColors.duyuruDuzenleIkincilButon,
                    onTop: () {
                      setState(() {
                        _baslikController.text = '';
                        _govdeController.text = '';
                        infoTrue = false;
                        lenght = 0;
                      });
                    },
                    width: width * 0.9,
                    text: 'edit_note.clear_button'.tr(),
                    height: height / 20,
                    icon: null,
                    styleColor: isDark
                        ? DarkColors.duyuruDuzenleButonText
                        : LightColors.duyuruDuzenleButonText,
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

  void updateNote(bool isDark) async {
    String? baslik = _baslikController.text;
    String? govde = _govdeController.text;

    String duyuruId = selectedDuyuru!.id;

    try {
      await _firestore
          .collection('schools')
          .doc(widget.schoolCode)
          .collection('notes')
          .doc(duyuruId)
          .update({
            'title': baslik,
            'body': govde,
            'updatetime': FieldValue.serverTimestamp(),
          });

      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: true,
        title: 'edit_note.update_success'.tr(),
      );
      Navigator.pop(context);
    } catch (e) {
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: false,
        title: 'edit_note.update_error'.tr() + ': $e',
      );
    }
  }

  void _yerlestir() {
    _baslikController.text = selectedDuyuru!.title;
    _govdeController.text = selectedDuyuru!.body;
    createTime = DateFormat(
      'dd.MM.yyyy HH:mm',
    ).format(selectedDuyuru!.createtime).toString();
    updateTime = DateFormat(
      'dd.MM.yyyy HH:mm',
    ).format(selectedDuyuru!.updatetime).toString();
    lenght = _govdeController.text.length;
    duyuruKontrol();
  }

  void searchNote() {
    try {
      selectedDuyuru = widget.notelist.firstWhere(
        (element) => element.id == selectedDuyuruId,
        orElse: () => null as Duyuru,
      );
    } catch (e) {
      selectedDuyuru = null;
    }

    if (selectedDuyuru != null) {
      _yerlestir();
      selectedDuyuruId = selectedDuyuru!.id;
    } else {
      if (widget.notelist.isNotEmpty) {
        selectedDuyuruId = widget.notelist.first.id;
      }
    }
  }
}
