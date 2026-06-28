import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart'; // Bu importun eklenmesi GEREKİR
import 'package:intl/intl.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/duyuru.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/pages/editNotePage.dart';

class BuildDuyurular extends StatefulWidget {
  final List<Duyuru> liste;
  final double height;
  final String schoolCode;
  bool isDark;
  BuildDuyurular({
    super.key,
    required this.liste,
    required this.height,
    required this.schoolCode,
    required this.isDark,
  });

  @override
  State<BuildDuyurular> createState() => _BuildDuyurularState();
}

class _BuildDuyurularState extends State<BuildDuyurular> {
  PageController pageController = PageController();
  bool acikMi = false;

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);
    bool isDark = widget.isDark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: acikMi ? height / 4 : widget.height + 20,
      width: width * 0.92,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: isDark ? DarkColors.duyurular : LightColors.duyurular,
        border: Border.all(
          color: isDark ? DarkColors.duyuruBorder : LightColors.duyuruBorder,
        ),
      ),
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.liste.length,
        itemBuilder: (context, index) {
          final duyuru = widget.liste[index];
          final String formattedDate = DateFormat(
            'dd.MM.yyyy HH:mm',
          ).format(duyuru.updatetime);

          return GestureDetector(
            onTap: () {
              setState(() => acikMi = !acikMi);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNotePage(
                                      isDark: isDark,
                                      schoolCode: widget.schoolCode,
                                      notelist: widget.liste,
                                      noteId: duyuru.id,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit_note_outlined),
                              color: isDark
                                  ? DarkColors.duyuruIcons
                                  : LightColors.duyuruIcons,
                            ),
                            Expanded(
                              child: Text(
                                duyuru.title,
                                textAlign: TextAlign.center,
                                style: Helper.duyuruTitleTextStyle(isDark),
                                //softWrap: true,
                                //maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: width / 25),
                      Icon(
                        acikMi ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: isDark
                            ? DarkColors.duyuruIcons
                            : LightColors.duyuruIcons,
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: acikMi
                        ? Container(
                            height: MediaQuery.of(context).size.height / 7.5,
                            margin: const EdgeInsets.only(top: 8),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    duyuru.body,
                                    style: Helper.duyuruBodyTextStyle(isDark),
                                    softWrap: true,
                                  ),
                                  SizedBox(height: height / 100),
                                  Text(
                                    'build_note.last_update'.tr(
                                      namedArgs: {'date': formattedDate},
                                    ),
                                    style: TextStyle(
                                      color: isDark
                                          ? DarkColors.sonGuncelleme
                                          : LightColors.sonGuncelleme,
                                      fontSize: 10,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
