import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: HomeView(),
    );
  }
}
