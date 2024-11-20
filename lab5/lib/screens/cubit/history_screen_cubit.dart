import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/database_service.dart';

abstract class HistoryScreenState {}

class HistoryScreenLoading extends HistoryScreenState {}

class HistoryScreenLoaded extends HistoryScreenState {
  final List<Map<String, dynamic>> calculations;

  HistoryScreenLoaded(this.calculations);
}

class HistoryScreenCubit extends Cubit<HistoryScreenState> {
  HistoryScreenCubit() : super(HistoryScreenLoading());

  void loadCalculations() async {
    emit(HistoryScreenLoading());
    final calculations = await DatabaseService().getCalculations();
    emit(HistoryScreenLoaded(calculations));
  }
}
