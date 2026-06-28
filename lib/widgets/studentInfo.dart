import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/pages/%20edit_studentinformationPage.dart';
import 'package:intl/intl.dart';

class Studentinfo extends StatelessWidget {
  final Map<String, dynamic> student;
  final bool izin;
  final double height;
  final double width;
  final String schoolCode;
  bool isDark;
  Studentinfo({
    super.key,
    required this.student,
    required this.izin,
    required this.height,
    required this.width,
    required this.schoolCode,
    required this.isDark,
  });

  String _getDogumTarihiStr() {
    dynamic dogumTarihiData = student['dogum_tarihi'];
    String dogumTarihiKey = 'student_info.date_of_birth_unknown';

    if (dogumTarihiData is Timestamp) {
      try {
        DateTime dt = dogumTarihiData.toDate();
        return 'student_info.date_of_birth'.tr(
          namedArgs: {'date': DateFormat('dd/MM/yyyy').format(dt)},
        );
      } catch (e) {
        return 'student_info.date_of_birth_error'.tr();
      }
    } else if (dogumTarihiData is String && dogumTarihiData.isNotEmpty) {
      try {
        DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dogumTarihiData);
        return 'student_info.date_of_birth'.tr(
          namedArgs: {'date': DateFormat('dd/MM/yyyy').format(parsedDate)},
        );
      } catch (e) {
        return 'student_info.date_of_birth_error'.tr();
      }
    }
    return dogumTarihiKey.tr();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = this.isDark;
    String dogumTarihiStr = _getDogumTarihiStr();

    return AlertDialog.adaptive(
      backgroundColor: isDark
          ? DarkColors.studentInfoBg
          : LightColors.studentInfoBg,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('student_info.title'.tr(), style: Helper.sorguTextStyle(isDark)),
          SizedBox(height: height / 100),
          Container(
            color: isDark
                ? DarkColors.studentInfoDividerStrong
                : LightColors.studentInfoDividerStrong,
            height: 1,
          ),

          SizedBox(height: height / 50),
          Text(
            'student_info.name_surname'.tr(
              namedArgs: {
                'name': student['isim'] ?? '',
                'surname': student['soyad'] ?? '',
              },
            ),
            style: TextStyle(
              fontSize: width / 30,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: height / 100),
          Container(
            color: isDark
                ? DarkColors.studentInfoDividerWeak
                : LightColors.studentInfoDividerWeak,
            height: 1,
          ),
          SizedBox(height: height / 100),
          Text(
            'student_info.number'.tr(
              namedArgs: {'id': student['studentId'] ?? 'N/A'},
            ),
            style: TextStyle(
              fontSize: width / 30,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: height / 100),
          Container(
            color: isDark
                ? DarkColors.studentInfoDividerWeak
                : LightColors.studentInfoDividerWeak,
            height: 1,
          ),
          SizedBox(height: height / 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'student_info.permission_status'.tr(),
                style: TextStyle(
                  fontSize: width / 30,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              izin
                  ? Icon(
                      Icons.task_alt_outlined,
                      color: isDark
                          ? DarkColors.studentInfoStatusPositive
                          : LightColors.studentInfoStatusPositive,
                      size: width / 25,
                    )
                  : Icon(
                      Icons.do_not_disturb_alt,
                      color: isDark
                          ? DarkColors.studentInfoStatusNegative
                          : LightColors.studentInfoStatusNegative,
                      size: width / 25,
                    ),
            ],
          ),
          SizedBox(height: height / 100),
          Container(
            color: isDark
                ? DarkColors.studentInfoDividerWeak
                : LightColors.studentInfoDividerWeak,
            height: 1,
          ),
          SizedBox(height: height / 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'student_info.face_data_status'.tr(),
                style: TextStyle(
                  fontSize: width / 30,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              student['embedding'] != null
                  ? Text(
                      'student_info.face_data_defined'.tr(),
                      style: TextStyle(
                        fontSize: width / 30,
                        color: isDark
                            ? DarkColors.studentInfoStatusPositive
                            : LightColors.studentInfoStatusPositive,
                      ),
                    )
                  : Text(
                      'student_info.face_data_undefined'.tr(),
                      style: TextStyle(
                        fontSize: width / 30,
                        color: isDark
                            ? DarkColors.studentInfoStatusNegative
                            : LightColors.studentInfoStatusNegative,
                      ),
                    ),
            ],
          ),
          SizedBox(height: height / 100),
          Container(
            color: isDark
                ? DarkColors.studentInfoDividerWeak
                : LightColors.studentInfoDividerWeak,
            height: 1,
          ),
          SizedBox(height: height / 100),
          Text(
            dogumTarihiStr,
            style: TextStyle(
              fontSize: width / 30,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: height / 50),
          Container(
            color: isDark
                ? DarkColors.studentInfoDividerStrong
                : LightColors.studentInfoDividerStrong,
            height: 1,
          ),
          SizedBox(height: height / 200),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,

      actions: [
        TextButton(
          onPressed: () {
            updateStudent(isDark, context, true);
          },
          child: Text(
            'student_info.permission_grant'.tr(),
            style: Helper.sorguTextStyle(isDark),
          ),
        ),
        TextButton(
          onPressed: () {
            updateStudent(isDark, context, false);
          },
          child: Text(
            'student_info.permission_revoke'.tr(),
            style: Helper.sorguTextStyle(isDark),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditStudentInformationPage(
                  isDark: isDark,
                  schoolCode: schoolCode,
                  student: student,
                ),
              ),
            );
          },
          child: Text(
            'student_info.edit_button'.tr(),
            style: Helper.sorguTextStyle(isDark),
          ),
        ),
      ],
    );
  }

  void updateStudent(bool isDark, BuildContext context, bool izin) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String name = student['isim'] ?? '';
    String surname = student['soyad'] ?? '';
    String studentId = student['studentId'] ?? 'N/A';

    try {
      await _firestore
          .collection('schools')
          .doc(schoolCode)
          .collection('students')
          .doc(studentId)
          .update({'izin': izin});

      String titleMessage = izin
          ? 'student_info.permission_granted_message'.tr(
              namedArgs: {'name': name, 'surname': surname, 'id': studentId},
            )
          : 'student_info.permission_revoked_message'.tr(
              namedArgs: {'name': name, 'surname': surname, 'id': studentId},
            );

      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: true,
        title: titleMessage,
      );
      Navigator.pop(context);
    } catch (e) {
      Helper.buildSnackBar(
        context: context,
        isDark: isDark,
        success: false,
        title: 'student_info.update_error'.tr() + ': $e',
      );
    }
  }
}
