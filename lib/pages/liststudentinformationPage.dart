import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/getogrinfo.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/pages/%20edit_studentinformationPage.dart';
import 'package:okul_bilgi_sistemi/widgets/appBar.dart';
import 'package:okul_bilgi_sistemi/widgets/studentInfo.dart';

// ignore: must_be_immutable
class ListStudentInformationPage extends StatefulWidget {
  bool isDark;
  String schoolCode;
  List<Map<String, dynamic>> students;
  ListStudentInformationPage({
    super.key,
    required this.schoolCode,
    required this.isDark,
    required this.students,
  });

  @override
  State<ListStudentInformationPage> createState() =>
      _ListStudentInformationPageState();
}

class _ListStudentInformationPageState
    extends State<ListStudentInformationPage> {
  String? selectedValue;
  List<Map<String, dynamic>> newstudents = [];
  late Stream<QuerySnapshot> studentStream;

  @override
  void initState() {
    super.initState();
    studentStream = Getogrinfo.streamStudents(schoolCode: widget.schoolCode);
    selectedValue = 'value1';
  }

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);
    bool isDark = widget.isDark;

    return Scaffold(
      backgroundColor: isDark
          ? DarkColors.listeOgrArkaPlan
          : LightColors.listeOgrArkaPlan,
      appBar: StdWidgets.standartAppBar(
        'list_student.title'.tr(),
        isDark ? Colors.white : Colors.black54,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<Map<String, dynamic>> allData = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              data['studentId'] = doc.id;
              return data;
            }).toList();

            if (selectedValue == 'value2') {
              newstudents = allData
                  .where((element) => element['izin'] == true)
                  .toList();
            } else {
              newstudents = allData;
            }
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? DarkColors.listeOgrContainer
                      : LightColors.listeOgrContainer,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      icon: const SizedBox(),
                      value: selectedValue,
                      dropdownColor: isDark
                          ? DarkColors.listeOgrContainer
                          : LightColors.listeOgrContainer,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: 'value1',
                          child: Text(
                            'list_student.all_students'.tr(),
                            style: Helper.sorguTextStyle(isDark),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'value2',
                          child: Text(
                            'list_student.permitted_students'.tr(),
                            style: Helper.sorguTextStyle(isDark),
                          ),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),

              newstudents.isEmpty
                  ? Center(
                      child: Text(
                        'list_student.empty_list'.tr(),
                        style: Helper.sorguTextStyle(isDark),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? DarkColors.listeOgrContainer
                            : LightColors.listeOgrContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: height / 35,
                        horizontal: width / 20,
                      ),
                      width: width * 0.9,
                      height: height * 0.76,
                      margin: EdgeInsets.symmetric(
                        vertical: height / 100,
                        horizontal: width / 20,
                      ),
                      child: ListView.builder(
                        itemCount: newstudents.length,
                        itemBuilder: (context, index) {
                          final student = newstudents[index];
                          final bool izin = student['izin'] ?? false;
                          return Card(
                            color: isDark
                                ? DarkColors.listeOgrCardBg
                                : LightColors.listeOgrCardBg,
                            child: ListTile(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => Studentinfo(
                                  isDark: isDark,
                                  student: student,
                                  izin: izin,
                                  height: height,
                                  width: width,
                                  schoolCode: widget.schoolCode,
                                ),
                              ),
                              title: Text(
                                '${student['isim']} ${student['soyad']}',
                                style: Helper.duyuruTitleTextStyle(isDark),
                              ),
                              trailing: Icon(
                                izin
                                    ? Icons.task_alt_outlined
                                    : Icons.do_not_disturb_alt,
                                color: izin
                                    ? (isDark
                                          ? DarkColors.listeOgrIconIzinli
                                          : LightColors.listeOgrIconIzinli)
                                    : (isDark
                                          ? DarkColors.listeOgrIconIzinsiz
                                          : LightColors.listeOgrIconIzinsiz),
                                size: width / 15,
                              ),
                              leading: Text(
                                student['studentId']?.toString() ?? 'id',
                                style: Helper.sorguTextStyle(isDark),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              Text(
                'list_student.count'.tr(
                  namedArgs: {'count': newstudents.length.toString()},
                ),
                style: Helper.sorguTextStyle(isDark),
              ),
            ],
          );
        },
      ),
    );
  }
}
