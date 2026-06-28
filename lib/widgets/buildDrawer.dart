import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart'; // Bu importun eklenmesi GEREKİR
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';
import 'package:okul_bilgi_sistemi/helper/signInandup.dart';
import 'package:okul_bilgi_sistemi/pages/sign_inPage.dart';
import 'package:okul_bilgi_sistemi/widgets/elevatedButton.dart';

class Builddrawer extends StatefulWidget {
  Map<String, String> userData;
  Map<String, String> schoolData;
  VoidCallback temaFonk;
  bool isDark;
  Builddrawer({
    super.key,
    required this.userData,
    required this.schoolData,
    required this.temaFonk,
    required this.isDark,
  });

  @override
  State<Builddrawer> createState() => _BuilddrawerState();
}

class _BuilddrawerState extends State<Builddrawer> {
  int selectedTheme = 2;

  @override
  Widget build(BuildContext context) {
    double height = Helper.getHeight(context);
    double width = Helper.getWidth(context);

    bool isDark = widget.isDark;

    return Drawer(
      backgroundColor: isDark ? DarkColors.drawer : LightColors.drawer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 50),
            color: Colors.blueGrey,
            width: width,
            height: height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 18),
                Text(
                  '${widget.userData['name'] ?? ''} '
                  '${widget.userData['surname'] ?? ''}',
                  style: Helper.profilNameTextStyle(isDark),
                ),
                Text(
                  widget.schoolData['isim'] ?? '',
                  style: Helper.profilSchoolTextStyle(isDark),
                ),
                SizedBox(height: height / 50),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                ExpansionTile(
                  collapsedIconColor: isDark ? Colors.white : Colors.black54,
                  collapsedBackgroundColor: isDark
                      ? const Color.fromARGB(255, 147, 146, 146)
                      : const Color.fromARGB(136, 126, 125, 125),
                  leading: Icon(
                    Icons.phone_outlined,
                    color: isDark ? Colors.white : Colors.black54,
                  ),
                  title: Text(
                    'drawer.contact_info_title'.tr(),
                    style: Helper.profildetayTextStyle(isDark),
                  ),
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.email_outlined,
                        color: isDark ? Colors.white : Colors.black54,
                      ),
                      title: Text(
                        widget.schoolData['email'] ?? '-',
                        style: Helper.profildetayTextStyle(isDark),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.phone_outlined,
                        color: isDark ? Colors.white : Colors.black54,
                      ),
                      title: Text(
                        widget.schoolData['telNo'] ?? '-',
                        style: Helper.profildetayTextStyle(isDark),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedIconColor: isDark ? Colors.white : Colors.black54,
                  collapsedBackgroundColor: isDark
                      ? const Color.fromARGB(255, 147, 146, 146)
                      : const Color.fromARGB(136, 126, 125, 125),
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: isDark ? Colors.white : Colors.black54,
                  ),
                  title: Text(
                    'drawer.address_info_title'.tr(),
                    style: Helper.profildetayTextStyle(isDark),
                  ),
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.location_city_outlined,
                        color: isDark ? Colors.white : Colors.black54,
                      ),
                      title: Text(
                        widget.schoolData['adres'] ?? '-',
                        style: Helper.profildetayTextStyle(isDark),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: width / 20, bottom: 10),
            child: IconButton(
              icon: Icon(
                isDark ? Icons.nightlight_outlined : Icons.light_mode_outlined,
                color: isDark ? Colors.white : Colors.black54,
              ),
              onPressed: widget.temaFonk,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20),
            child: BuildButton(
              color: const Color.fromARGB(255, 235, 98, 34),
              onTop: () {
                AuthService.signOut().then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  ),
                );
              },
              width: width * 0.65,
              text: 'drawer.logout_button'.tr(),
              height: height / 30,
              icon: Icons.output_rounded,
              styleColor: Colors.white,
              column: false,
            ),
          ),
        ],
      ),
    );
  }
}
