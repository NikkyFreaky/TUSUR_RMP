import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen_provider.dart';
import 'screens/cubit/main_screen_cubit.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenCubit>(
          create: (context) => MainScreenCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Калькулятор',
        theme: ThemeData.dark(),
        home: MainScreenProvider(),
      ),
    );
  }
}
