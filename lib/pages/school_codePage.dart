import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:easy_localization/easy_localization.dart'; // Bu importun eklenmesi GEREKİR
import 'package:google_fonts/google_fonts.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';

import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';
import 'package:okul_bilgi_sistemi/widgets/uyar%C4%B1.dart';

class SchoolCodePage extends StatefulWidget {
  final String okulKod;
  const SchoolCodePage({super.key, required this.okulKod});

  @override
  State<SchoolCodePage> createState() => _SchoolCodePageState();
}

class _SchoolCodePageState extends State<SchoolCodePage> {
  bool kopyalandi = false;
  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = Helper.cihazMod(context);

    return Scaffold(
      //appBar: AppBar(title: Text('Material App Bar')),
      backgroundColor: isDark
          ? DarkColors.okulKodArkaPlan
          : LightColors.okulKodArkaPlan,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? DarkColors.okulKodContainer
                  : LightColors.okulKodContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            width: width * 0.9,
            height: height * 0.88,
            margin: EdgeInsets.symmetric(
              vertical: height / 15,
              horizontal: width / 20,
            ),
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
                  'school_code.title_success'.tr(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: height / 40,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? DarkColors.okulKodBaslikText
                        : LightColors.okulKodBaslikText,
                  ),
                ),
                SizedBox(height: height / 90),
                Text(
                  'school_code.subtitle_success'.tr(),
                  style: GoogleFonts.montserrat(
                    fontSize: height / 70,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? DarkColors.okulKodAciklamaText
                        : LightColors.okulKodAciklamaText,
                  ),
                ),
                // SizedBox(height: _height / 200),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? DarkColors.okulKodKodAlani
                        : LightColors.okulKodKodAlani,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isDark
                          ? DarkColors.okulKodBorder
                          : LightColors.okulKodBorder,
                    ),
                  ),
                  width: width * 0.9,
                  height: height * 0.179,
                  margin: EdgeInsets.symmetric(
                    vertical: height / 100,
                    horizontal: width / 20,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'school_code.code_label'.tr(),
                          style: GoogleFonts.montserrat(
                            fontSize: height / 70,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? DarkColors.okulKodEtiketText
                                : LightColors.okulKodEtiketText,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? DarkColors.okulKodContainer
                              : LightColors.okulKodContainer,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: width * 0.7,
                        height: height * 0.05,
                        child: Center(
                          child: Text(
                            widget.okulKod,
                            style: GoogleFonts.montserrat(
                              fontSize: height / 40,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? DarkColors.okulKodBaslikText
                                  : LightColors.okulKodBaslikText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height / 70),
                      BuildButton(
                        color: isDark
                            ? DarkColors.okulKodKopyalaButon
                            : LightColors.okulKodKopyalaButon,
                        onTop: () async {
                          await Clipboard.setData(
                            ClipboardData(text: widget.okulKod),
                          );
                          setState(() {
                            kopyalandi = true;
                          });
                          print('kopyalama başarılı');
                        },
                        width: width * 0.7,
                        text: kopyalandi == false
                            ? 'school_code.copy_button'.tr()
                            : 'school_code.copied_button'.tr(),
                        height: height * 0.05,
                        icon: null,
                        styleColor: isDark
                            ? DarkColors.okulKodButonText
                            : LightColors.okulKodButonText,
                        column: false,
                      ),
                    ],
                  ),
                ),
                UyariWidget(
                  iconColor: isDark
                      ? DarkColors.okulKodGuvenlikIcon
                      : LightColors.okulKodGuvenlikIcon,
                  color: isDark
                      ? DarkColors.okulKodGuvenlikBg
                      : LightColors.okulKodGuvenlikBg,
                  width: width * 0.8,
                  height: height * 0.12,
                  liste: [
                    Text(
                      'school_code.security_warning_title'.tr(),
                      softWrap: true,
                      style: Helper.sorguTextStyle(isDark),
                    ),
                    Text(
                      'school_code.security_warning_body'.tr(),
                      softWrap: true,
                      style: Helper.uyariTextStyle(isDark),
                    ),
                  ],
                  icon: Icons.security_outlined,
                  backgroundColor: isDark
                      ? DarkColors.okulKodContainer
                      : LightColors.okulKodContainer,
                ),
                SizedBox(height: height / 70),
                UyariWidget(
                  iconColor: isDark
                      ? DarkColors.okulKodBilgiIcon
                      : LightColors.okulKodBilgiIcon,
                  color: isDark
                      ? DarkColors.okulKodBilgiBg
                      : LightColors.okulKodBilgiBg,
                  width: width * 0.8,
                  height: height * 0.17,
                  liste: [
                    Text(
                      'school_code.info_title'.tr(),
                      softWrap: true,
                      style: Helper.sorguTextStyle(isDark),
                    ),
                    Text(
                      'school_code.info_1'.tr(),
                      softWrap: true,
                      style: Helper.uyariTextStyle(isDark),
                    ),
                    Text(
                      'school_code.info_2'.tr(),
                      softWrap: true,
                      style: Helper.uyariTextStyle(isDark),
                    ),
                    Text(
                      'school_code.info_3'.tr(),
                      softWrap: true,
                      style: Helper.uyariTextStyle(isDark),
                    ),
                  ],
                  icon: Icons.warning_amber_outlined,
                  backgroundColor: isDark
                      ? DarkColors.okulKodContainer
                      : LightColors.okulKodContainer,
                ),
                SizedBox(height: height / 70),
                BuildButton(
                  color: isDark
                      ? DarkColors.okulKodTamamButon
                      : LightColors.okulKodTamamButon,
                  onTop: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  width: width * 0.8,
                  text: 'school_code.done_button'.tr(),
                  height: height * 0.05,
                  icon: null,
                  styleColor: isDark
                      ? DarkColors.okulKodButonText
                      : LightColors.okulKodButonText,
                  column: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
