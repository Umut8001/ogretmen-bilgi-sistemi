import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart'; // Bu importun eklenmesi GEREKİR
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/validator.dart';
import 'package:okul_bilgi_sistemi/widgets/textFormField.dart';

class BuildTeacherAccountPage extends StatefulWidget {
  final TextEditingController adController;
  final TextEditingController soyadController;
  final TextEditingController epostaController;
  final TextEditingController telnoController;
  final TextEditingController okulkodController;
  final TextEditingController sifreController;
  final TextEditingController sifretekrarController;
  final GlobalKey formkey;
  const BuildTeacherAccountPage({
    super.key,
    required this.adController,
    required this.soyadController,
    required this.epostaController,
    required this.telnoController,
    required this.okulkodController,
    required this.sifreController,
    required this.sifretekrarController,
    required this.formkey,
  });

  @override
  State<BuildTeacherAccountPage> createState() =>
      _BuildTeacherAccountPageState();
}

class _BuildTeacherAccountPageState extends State<BuildTeacherAccountPage> {
  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = Helper.cihazMod(context);
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? DarkColors.ogretmenHesapContainer
            : LightColors.ogretmenHesapContainer,
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
            key: widget.formkey,
            child: Column(
              children: [
                BuildTextFormField(
                  inputtype: TextInputType.name,
                  validator: (value) {
                    return Validator.validateName(value);
                  },

                  controller: widget.adController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.name'.tr(),
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

                  controller: widget.soyadController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.surname'.tr(),
                  icon: Icons.person_outline,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.emailAddress,
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },

                  controller: widget.epostaController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.email'.tr(),
                  icon: Icons.mail_outline,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.phone,
                  validator: (value) {
                    return Validator.validatePhoneNumber(value);
                  },

                  controller: widget.telnoController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.phone'.tr(),
                  icon: Icons.phone_outlined,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.text,
                  validator: (value) {
                    return Validator.validateSchoolCode(value);
                  },

                  controller: widget.okulkodController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.school_code'.tr(),
                  icon: Icons.code_outlined,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.visiblePassword,
                  validator: (value) {
                    return Validator.validatePassword(value);
                  },

                  controller: widget.sifreController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.password_create'.tr(),
                  icon: Icons.password_outlined,
                  suffix: false,
                  isDark: isDark,
                ),
                SizedBox(height: height / 50),
                BuildTextFormField(
                  inputtype: TextInputType.visiblePassword,
                  validator: (value) {
                    return Validator.validateConfirmPassword(
                      value,
                      widget.sifreController.text,
                    );
                  },

                  controller: widget.sifretekrarController,
                  color: isDark
                      ? DarkColors.ogretmenHesapInputText
                      : LightColors.ogretmenHesapInputText,
                  width: width * 0.8,
                  text: 'create_teacher.password_confirm'.tr(),
                  icon: Icons.password_outlined,
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
                  ? DarkColors.ogretmenHesapBilgiBg
                  : LightColors.ogretmenHesapBilgiBg,
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
                        ? DarkColors.ogretmenHesapBilgiIcon
                        : LightColors.ogretmenHesapBilgiIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      width: 1,
                      //height: ,
                      color: isDark
                          ? DarkColors.ogretmenHesapBilgiDivider
                          : LightColors.ogretmenHesapBilgiDivider,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'create_teacher.info_1'.tr(),
                          softWrap: true,
                          style: Helper.uyariTextStyle(isDark),
                        ),
                        Text(
                          'create_teacher.info_2'.tr(),
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
