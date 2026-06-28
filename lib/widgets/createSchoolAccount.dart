import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart'; // Bu importun eklenmesi GEREKİR
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/validator.dart';
import 'package:okul_bilgi_sistemi/widgets/textFormField.dart';

class BuildSchoolAccountPage extends StatefulWidget {
  final TextEditingController okuladController;
  final TextEditingController okuladresController;
  final TextEditingController okulepostaController;
  final TextEditingController telnoController;
  final TextEditingController okultelnoController;
  final GlobalKey formKey;
  const BuildSchoolAccountPage({
    super.key,
    required this.okuladController,
    required this.okuladresController,
    required this.okulepostaController,
    required this.telnoController,
    required this.okultelnoController,
    required this.formKey,
  });
  @override
  State<BuildSchoolAccountPage> createState() => _BuildSchoolAccountPageState();
}

class _BuildSchoolAccountPageState extends State<BuildSchoolAccountPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);
    bool isDark = Helper.cihazMod(context);
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? DarkColors.okulHesapContainer
            : LightColors.okulHesapContainer,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(
        vertical: height / 20,
        horizontal: width / 20,
      ),
      width: width * 0.9,
      margin: EdgeInsets.symmetric(
        vertical: height / 50,
        horizontal: width / 20,
      ),
      child: Column(
        children: [
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                BuildTextFormField(
                  inputtype: TextInputType.text,
                  validator: (value) {
                    return Validator.validateName(value);
                  },

                  controller: widget.okuladController,
                  color: isDark
                      ? DarkColors.okulHesapInputText
                      : LightColors.okulHesapInputText,
                  width: width * 0.8,
                  text: 'create_school.school_name'.tr(),
                  icon: Icons.school_outlined,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.text,
                  validator: (value) {
                    return Validator.validateAddress(value);
                  },

                  controller: widget.okuladresController,
                  color: isDark
                      ? DarkColors.okulHesapInputText
                      : LightColors.okulHesapInputText,
                  width: width * 0.8,
                  text: 'create_school.school_address'.tr(),
                  icon: Icons.location_on_outlined,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.emailAddress,
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },

                  controller: widget.okulepostaController,
                  color: isDark
                      ? DarkColors.okulHesapInputText
                      : LightColors.okulHesapInputText,
                  width: width * 0.8,
                  text: 'create_school.school_email'.tr(),
                  icon: Icons.mail_outline,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.number,
                  validator: (value) {
                    return Validator.validatePhoneNumber(value);
                  },

                  controller: widget.okultelnoController,
                  color: isDark
                      ? DarkColors.okulHesapInputText
                      : LightColors.okulHesapInputText,
                  width: width * 0.8,
                  text: 'create_school.school_phone'.tr(),
                  icon: Icons.phone_outlined,
                  suffix: false,
                  isDark: isDark,
                ),
              ],
            ),
          ),
          SizedBox(height: height / 50),
          Container(
            width: width * 0.8,
            height: height / 15,
            decoration: BoxDecoration(
              color: isDark
                  ? DarkColors.okulHesapBilgiBg
                  : LightColors.okulHesapBilgiBg,
              borderRadius: BorderRadius.circular(15),
              // border: BoxBorder.all(color: Colors.black38),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: width / 100),
                  Icon(
                    Icons.error_outline,
                    color: isDark
                        ? DarkColors.okulHesapBilgiIcon
                        : LightColors.okulHesapBilgiIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      width: 1,
                      color: isDark
                          ? DarkColors.okulHesapBilgiDivider
                          : LightColors.okulHesapBilgiDivider,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'create_school.info_1'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                        Text(
                          'create_school.info_2'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
