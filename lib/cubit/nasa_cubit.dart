import 'package:bloc/bloc.dart';
import '../models/nasa.dart';
import '../requests/api.dart';

abstract class NasaState {}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  Nasa data;
  NasaLoadedState({required this.data});
}

class NasaErrorState extends NasaState {}

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(NasaLoadingState());

  Future<void> loadData() async {
    try {
      Map<String, dynamic> apiData = await getNasaData();
      Nasa nasaData = Nasa.fromJson(apiData);
      emit(NasaLoadedState(data: nasaData));
      return;
    } catch (e) {
      emit(NasaErrorState());
      return;
    }
  }
}
