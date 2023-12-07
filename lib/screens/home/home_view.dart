import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../common/constants/route_constants.dart';
import '../../common/constants/translation_constants.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
    ));
    final homeViewModel = Provider.of<HomeViewModel>(context);

    Widget tabItem(var pos, String title, var image, var size) {
      return GestureDetector(
        onTap: () {
          homeViewModel.changePos(pos);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/$image.png',
                color: homeViewModel.selectedPos == pos
                    ? AppColor.primaryColor
                    : AppColor.secondaryColor,
                width: size,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  //height: 0.7,
                  color: homeViewModel.selectedPos == pos
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: homeViewModel.pages[homeViewModel.selectedPos],
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor,
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabItem(
                      0, TranslationConstants.orders.t(context), 'home', 20.0),
                  tabItem(
                      1, TranslationConstants.sales.t(context), 'stock', 22.0),
                  Container(width: 45, height: 45),
                  tabItem(2, TranslationConstants.dashBoard.t(context),
                      'tran_history', 20.0),
                  tabItem(3, TranslationConstants.setting.t(context), 'setting',
                      20.0),
                ],
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteList.salePrintScreen,
              );
            },
            child: const Icon(Icons.print_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
