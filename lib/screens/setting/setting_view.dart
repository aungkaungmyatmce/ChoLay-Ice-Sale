import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/constants/decoration.dart';
import '../../common/constants/route_constants.dart';
import '../../common/constants/style.dart';
import '../language/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void rejectToEnter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          'Admin acc required',
          style: secondaryTextStyle(),
        ),
        contentPadding: EdgeInsets.all(20),
        children: [
          Text(
            'Login with admin acc to view this screen',
            style: secondaryTextStyle(),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Container(
          //margin: EdgeInsets.only(top: 90),
          decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        child: Text(
                          TranslationConstants.setting.t(context),
                          style: boldTextStyle(size: 16, height: 1),
                        ),
                      ),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration: boxDecorationWithRoundedCorners(
                            boxShape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.3)),
                          ),
                          child: Icon(Icons.settings,
                              color: AppColor.primaryColor, size: 20)),
                      //SizedBox(width: 10)
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                        padding: EdgeInsets.all(12.0),
                        decoration: boxDecorationRoundedWithShadow(8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    RouteList.customerNamesScreen,
                                  );
                                },
                                leading: Icon(Icons.store_outlined,
                                    size: 24, color: AppColor.primaryColor),
                                title: Text(
                                    TranslationConstants.customerNames
                                        .t(context),
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    RouteList.productNamesScreen,
                                  );
                                },
                                leading: Icon(Icons.category_outlined,
                                    size: 24, color: AppColor.primaryColor),
                                title: Text(
                                    AppLocalizations.of(context)!
                                        .translate('products')!,
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                        padding: EdgeInsets.all(12.0),
                        decoration: boxDecorationRoundedWithShadow(8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () {
                                  if (_auth.currentUser!.email ==
                                      'cholayadmin@gmail.com') {
                                    Navigator.of(context).pushNamed(
                                      RouteList.saleTargetSettingScreen,
                                    );
                                  } else {
                                    rejectToEnter(context);
                                  }
                                },
                                leading: Icon(
                                    Icons.insert_chart_outlined_rounded,
                                    size: 24,
                                    color: AppColor.primaryColor),
                                title: Text(
                                    TranslationConstants.productTargets
                                        .t(context),
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () {
                                  if (_auth.currentUser!.email ==
                                      'cholayadmin@gmail.com') {
                                    Navigator.of(context).pushNamed(
                                      RouteList.transportTargetSettingScreen,
                                    );
                                  } else {
                                    rejectToEnter(context);
                                  }
                                },
                                leading: Icon(Icons.emoji_transportation,
                                    size: 24, color: AppColor.primaryColor),
                                title: Text(
                                    TranslationConstants.transportTargets
                                        .t(context),
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                        padding: EdgeInsets.all(12.0),
                        decoration: boxDecorationRoundedWithShadow(8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () {
                                  if (_auth.currentUser!.email ==
                                      'cholayadmin@gmail.com') {
                                    Navigator.of(context).pushNamed(
                                      RouteList.accountingScreen,
                                    );
                                  } else {
                                    rejectToEnter(context);
                                  }
                                },
                                leading: Icon(Icons.pie_chart,
                                    size: 24,
                                    color:
                                        AppColor.primaryColor.withOpacity(0.8)),
                                title: Text(
                                    TranslationConstants.statistics.t(context),
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    RouteList.languageChangeScreen,
                                  );
                                },
                                leading: Icon(Icons.language,
                                    size: 24,
                                    color:
                                        AppColor.primaryColor.withOpacity(0.8)),
                                title: Text(
                                    TranslationConstants.language.t(context),
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 35,
                              child: ListTile(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('Are you sure?',
                                          style: secondaryTextStyle()),
                                      content: Text('Do you want to log out ?',
                                          style: secondaryTextStyle()),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('No'),
                                          onPressed: () async {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Yes'),
                                          onPressed: () async {
                                            _auth.signOut();
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                leading: Icon(Icons.logout,
                                    size: 24,
                                    color:
                                        AppColor.primaryColor.withOpacity(0.8)),
                                title: Text(
                                    TranslationConstants.logout.t(context),
                                    style: secondaryTextStyle()),
                                trailing: Icon(Icons.logout,
                                    color: Colors.grey[300], size: 16),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                visualDensity: VisualDensity(vertical: -3),
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
