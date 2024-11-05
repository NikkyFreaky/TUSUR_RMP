import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/history_screen_cubit.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryScreenCubit()..loadCalculations(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("История расчетов"),
        ),
        body: BlocBuilder<HistoryScreenCubit, HistoryScreenState>(
          builder: (context, state) {
            if (state is HistoryScreenLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HistoryScreenLoaded) {
              if (state.calculations.isEmpty) {
                return Center(child: Text("Нет сохраненных данных."));
              }
              return ListView.builder(
                itemCount: state.calculations.length,
                itemBuilder: (context, index) {
                  final calculation = state.calculations[index];
                  return ListTile(
                    title: Text("Тип файла: ${calculation['fileType']}"),
                    subtitle: Text(
                      "Размер: ${calculation['fileSizeInMB'].toStringAsFixed(2)} МБ",
                    ),
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
