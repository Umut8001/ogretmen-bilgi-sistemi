import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';

class Helper {
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool cihazMod(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

  static TextStyle? sorguTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  static TextStyle? duyuruBodyTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  static TextStyle? uyariTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  static TextStyle? duyuruTitleTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: isDark ? Colors.white : Colors.black87,
    );
  }

  static TextStyle? profilNameTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle? profilSchoolTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    );
  }

  static TextStyle? profildetayTextStyle(bool isDark) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : Colors.black54,
    );
  }

  static Widget buildMenuItem(
    String title,
    String image,
    Color color,
    GestureTapCallback? onTap,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black45 : Colors.grey.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.white,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: sorguTextStyle(
                    isDark,
                  )?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-------------------------------------------------------

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  buildSnackBar({
    required BuildContext context,
    required bool isDark,
    required bool success,
    required String title,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        backgroundColor: isDark
            ? DarkColors.duyuruEkleContainer
            : LightColors.duyuruEkleContainer,
        content: Column(
          children: [
            success
                ? Image.asset('assets/images/yesil_tik.png', height: 50)
                : Icon(Icons.close, color: Colors.red, size: 50),
            SizedBox(height: 12),
            Text(title, style: Helper.sorguTextStyle(isDark), softWrap: true),
          ],
        ),
      ),
    );
  }
}
