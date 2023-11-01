import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    Widget tabItem(var pos, String title, var image, var size) {
      return GestureDetector(
        onTap: () {
          homeViewModel.changePos(pos);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/$image.png',
                color: homeViewModel.selectedPos == pos
                    ? AppColor.primaryColor
                    : Colors.black54,
                width: size,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  //height: 0.7,
                  color: homeViewModel.selectedPos == pos
                      ? AppColor.primaryColor
                      : Colors.black54,
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
                  tabItem(0, 'Orders', 'home', 20.0),
                  tabItem(1, 'Sales', 'stock', 22.0),
                  Container(width: 45, height: 45),
                  tabItem(2, 'Target', 'tran_history', 20.0),
                  tabItem(3, 'Setting', 'setting', 20.0),
                ],
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => AddNewTransactionScreen(),
              // ));
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
