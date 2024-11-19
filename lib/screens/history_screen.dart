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
          centerTitle: true,
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
                  final reverseIndex =
                      state.calculations.length - index; // Обратный индекс
                  return ListTile(
                    title: Text("$reverseIndex расчет:"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Тип файла: ${calculation['fileType']}"),
                        Text(
                            "Размер: ${calculation['fileSizeInMB'].toStringAsFixed(2)} МБ"),
                      ],
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
