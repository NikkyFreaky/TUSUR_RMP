import 'package:bloc/bloc.dart';
import '../models/photos.dart';
import '../requests/api.dart';

abstract class NasaState {}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  final List<Photos> photos;
  NasaLoadedState(this.photos);
}

class NasaErrorState extends NasaState {
  final String errorMessage;
  NasaErrorState(this.errorMessage);
}

class NasaCubit extends Cubit<NasaState> {
  final ApiService apiService;

  NasaCubit(this.apiService) : super(NasaLoadingState());

  Future<void> loadPhotos() async {
    emit(NasaLoadingState());
    try {
      final photos = await apiService.getNasaData();
      emit(NasaLoadedState(photos));
    } catch (e) {
      emit(NasaErrorState(e.toString()));
    }
  }
}
