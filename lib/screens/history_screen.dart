import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = context.read<MainScreenCubit>().history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('История расчетов'),
      ),
      body: history.isEmpty
          ? const Center(
              child: Text('История пуста'),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final result = history[index];
                return ListTile(
                  title: Text('Результат ${index + 1}'),
                  subtitle: Text('Размер файла: ${result['fileSizeInMB']} MB'),
                );
              },
            ),
    );
  }
}
