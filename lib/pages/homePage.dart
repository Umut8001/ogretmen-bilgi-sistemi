import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/duyuru.dart';
import 'package:okul_bilgi_sistemi/helper/getnotes.dart';
import 'package:okul_bilgi_sistemi/helper/getogrinfo.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/signInandup.dart';
import 'package:okul_bilgi_sistemi/pages/addNotePage.dart';
import 'package:okul_bilgi_sistemi/pages/add_studentPage.dart';
import 'package:okul_bilgi_sistemi/pages/liststudentinformationPage.dart';
import 'package:okul_bilgi_sistemi/pages/sign_inPage.dart';
import 'package:okul_bilgi_sistemi/pages/studentqueryPage.dart';
import 'package:okul_bilgi_sistemi/widgets/buildDrawer.dart';
import 'package:okul_bilgi_sistemi/widgets/buildDuyurular.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  User user;
  String schoolCode;
  HomePage({super.key, required this.user, required this.schoolCode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Stream<QuerySnapshot> studentStream;
  late Stream<QuerySnapshot> noteStream;

  Map<String, String> okulBilgi = {
    'adres': ' ',
    'email': ' ',
    'isim': ' ',
    'telNo': ' ',
  };

  List<Map<String, dynamic>> ogrlist = [];
  Map<String, String> userData = {'name': '', 'surname': '', 'schoolCode': ''};
  List<Duyuru> notelist = [];
  late int value;
  late bool isDark;
  late bool deviceTheme;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isDark = false;
    studentStream = Getogrinfo.streamStudents(schoolCode: widget.schoolCode);
    noteStream = Getnotes.streamNotes(schoolCode: widget.schoolCode);
    getUserProfileData(widget.user.uid);
    getSchoolInfo(widget.schoolCode);
    deviceTheme = false;
    value = 1;
  }

  @override
  Widget build(BuildContext context) {
    final double height = Helper.getHeight(context);
    final double width = Helper.getWidth(context);

    if (deviceTheme) {
      isDark = Helper.cihazMod(context);
    }
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      drawer: Builddrawer(
        userData: userData,
        schoolData: okulBilgi,
        temaFonk: () {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 15),
              backgroundColor: Colors.transparent,
              content: Column(
                children: [
                  Container(
                    height: height / 20,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          deviceTheme = false;
                          isDark = false;
                        });
                      },
                      child: Text(
                        'home.open_theme'.tr(),
                        style: Helper.sorguTextStyle(isDark),
                      ),
                    ),
                  ),
                  Container(
                    height: height / 15,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          deviceTheme = false;
                          isDark = true;
                        });
                      },
                      child: Text(
                        'home.dark_theme'.tr(),
                        style: Helper.sorguTextStyle(isDark),
                      ),
                    ),
                  ),
                  Container(
                    height: height / 20,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          deviceTheme = true;
                        });
                      },
                      child: Text(
                        'home.device_theme'.tr(),
                        style: Helper.sorguTextStyle(isDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        isDark: isDark,
      ),

      body: Container(
        decoration: BoxDecoration(
          color: isDark
              ? DarkColors.homePagearkaPlanRengi
              : LightColors.homePagearkaPlanRengi,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: height / 70, top: height / 30),
              alignment: Alignment.topLeft,
              child: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, size: height / 30),
                    color: isDark
                        ? DarkColors.drawerIcon
                        : LightColors.drawerIcon,
                  );
                },
              ),
            ),

            Container(
              color: Colors.transparent,
              height: width / 4.5,
              width: width / 4.5,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(height: height / 200),

            Text(
              '${userData['name']} ${userData['surname']}',
              style: Helper.duyuruTitleTextStyle(isDark),
            ),

           
            StreamBuilder<QuerySnapshot>(
              stream: noteStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: isDark
                            ? DarkColors.yukleniyor
                            : LightColors.yukleniyor,
                      ),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(child: Text('home.loading_notes_error'.tr())),
                  );
                }

                if (snapshot.hasData) {
                  List<Duyuru> currentNotelist = snapshot.data!.docs.map((doc) {
                    return Duyuru.fromMap(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    );
                  }).toList();

                  notelist = currentNotelist;

                  return BuildDuyurular(
                    isDark: isDark,
                    liste: currentNotelist,
                    height: height / 15,
                    schoolCode: widget.schoolCode,
                  );
                }

                return const Expanded(child: SizedBox.shrink());
              },
            ),

            Container(
              width: width,
              height: 3,
              color: isDark ? DarkColors.cizgi : LightColors.cizgi,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: studentStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                }

                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('home.loading_students_error'.tr()),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  List<Map<String, dynamic>> currentOgrlist = snapshot
                      .data!
                      .docs
                      .map((doc) {
                        Map<String, dynamic> studentData =
                            doc.data() as Map<String, dynamic>;

                        studentData['studentId'] = doc.id;
                        return studentData;
                      })
                      .toList();

                  ogrlist = currentOgrlist;

                  return Flexible(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.blueGrey),

                      child: GridView.count(
                        crossAxisCount: 2,
                        controller: _scrollController,
                        padding: const EdgeInsets.only(
                          top: 0,
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        children: [
                          Helper.buildMenuItem(
                            'home.add_student'.tr(),
                            "assets/images/user.png",

                            isDark ? DarkColors.butonlar : LightColors.butonlar,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddStudent(
                                    schoolCode: widget.schoolCode,
                                    isDark: isDark,
                                  ),
                                ),
                              );
                            },
                            isDark,
                          ),
                          Helper.buildMenuItem(
                            'home.search_student'.tr(),
                            'assets/images/search.png',

                            isDark ? DarkColors.butonlar : LightColors.butonlar,
                            () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentQueryPage(
                                    isDark: isDark,
                                    schoolCode: widget.schoolCode,
                                  ),
                                ),
                              );
                            },
                            isDark,
                          ),
                          Helper.buildMenuItem(
                            'home.list_students'.tr(),

                            'assets/images/customer.png',
                            isDark ? DarkColors.butonlar : LightColors.butonlar,
                            () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ListStudentInformationPage(
                                        isDark: isDark,

                                        schoolCode: widget.schoolCode,
                                        students: ogrlist,
                                      ),
                                ),
                              );
                            },
                            isDark,
                          ),
                          Helper.buildMenuItem(
                            'home.add_note'.tr(),
                            'assets/images/add.png',

                            isDark ? DarkColors.butonlar : LightColors.butonlar,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNotePage(
                                    isDark: isDark,
                                    schoolCode: widget.schoolCode,
                                  ),
                                ),
                              );
                            },
                            isDark,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const Expanded(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String?>?> getUserProfileData(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        String? name = data['name'] as String?;
        String? surname = data['surname'] as String?;
        String? schoolCode = data['schoolCode'] as String?;
        print('name: $name, surname: $surname, $schoolCode: $schoolCode');

        setState(() {
          userData = {
            'name': name ?? '',
            'surname': surname ?? '',
            'schoolCode': schoolCode ?? '',
          };
        });

        return {'name': name, 'surname': surname, 'schoolCode': schoolCode};
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  

  Future<void> getSchoolInfo(String schoolCode) async {
    final doc = await FirebaseFirestore.instance
        .collection('schools')
        .doc(schoolCode)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      okulBilgi = {
        'adres': data['adres'] ?? '',
        'email': data['email'] ?? '',
        'isim': data['isim'] ?? '',
        'telNo': data['telNo'] ?? '',
      };
    }
  }
}
