import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Map<String, dynamic>> history;

  HistoryLoaded(this.history);
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(List<Map<String, dynamic>> history) : super(HistoryInitial()) {
    loadHistory(history);
  }

  void loadHistory(List<Map<String, dynamic>> history) {
    emit(HistoryLoaded(history));
  }
}
