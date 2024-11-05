import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen_state.dart';
import '../../services/database_service.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial()) {
    discretizationController.addListener(_validateDiscretization);
    bitDepthController.addListener(_validateBitDepth);
    durationController.addListener(_validateDuration);
  }

  final TextEditingController discretizationController =
      TextEditingController();
  final TextEditingController bitDepthController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  String fileType = 'WAV';
  bool agreement = false;

  void updateFileType(String? newValue) {
    fileType = newValue!;
    emit(MainScreenInitial());
  }

  void updateAgreement(bool? value) {
    agreement = value ?? false;
    _validateForm();
  }

  void _validateDiscretization() {
    final text = discretizationController.text;
    String? error;
    if (text.isEmpty) {
      error = 'Введите частоту дискретизации';
    } else {
      final value = double.tryParse(text);
      if (value == null || value <= 0) {
        error = 'Введите корректное число больше нуля';
      }
    }
    emit(MainScreenFieldError(
      discretizationError: error,
      bitDepthError: state is MainScreenFieldError
          ? (state as MainScreenFieldError).bitDepthError
          : null,
      durationError: state is MainScreenFieldError
          ? (state as MainScreenFieldError).durationError
          : null,
      agreementError:
          !agreement ? 'Пожалуйста, дайте согласие на обработку данных' : null,
    ));
  }

  void _validateBitDepth() {
    final text = bitDepthController.text;
    String? error;
    if (text.isEmpty) {
      error = 'Введите глубину кодирования звука';
    } else {
      final value = double.tryParse(text);
      if (value == null || value <= 0) {
        error = 'Введите корректное число больше нуля';
      }
    }
    emit(MainScreenFieldError(
      discretizationError: state is MainScreenFieldError
          ? (state as MainScreenFieldError).discretizationError
          : null,
      bitDepthError: error,
      durationError: state is MainScreenFieldError
          ? (state as MainScreenFieldError).durationError
          : null,
      agreementError:
          !agreement ? 'Пожалуйста, дайте согласие на обработку данных' : null,
    ));
  }

  void _validateDuration() {
    final text = durationController.text;
    String? error;
    if (text.isEmpty) {
      error = 'Введите длительность звуковой дорожки';
    } else {
      final value = double.tryParse(text);
      if (value == null || value <= 0) {
        error = 'Введите корректное число больше нуля';
      }
    }
    emit(MainScreenFieldError(
      discretizationError: state is MainScreenFieldError
          ? (state as MainScreenFieldError).discretizationError
          : null,
      bitDepthError: state is MainScreenFieldError
          ? (state as MainScreenFieldError).bitDepthError
          : null,
      durationError: error,
      agreementError:
          !agreement ? 'Пожалуйста, дайте согласие на обработку данных' : null,
    ));
  }

  void _validateForm() {
    emit(MainScreenFieldError(
      discretizationError: (state is MainScreenFieldError)
          ? (state as MainScreenFieldError).discretizationError
          : null,
      bitDepthError: (state is MainScreenFieldError)
          ? (state as MainScreenFieldError).bitDepthError
          : null,
      durationError: (state is MainScreenFieldError)
          ? (state as MainScreenFieldError).durationError
          : null,
      agreementError:
          !agreement ? 'Пожалуйста, дайте согласие на обработку данных' : null,
    ));
  }

  void calculateFileSize() {
    if (!agreement) {
      emit(MainScreenFieldError(
        discretizationError: (state is MainScreenFieldError)
            ? (state as MainScreenFieldError).discretizationError
            : null,
        bitDepthError: (state is MainScreenFieldError)
            ? (state as MainScreenFieldError).bitDepthError
            : null,
        durationError: (state is MainScreenFieldError)
            ? (state as MainScreenFieldError).durationError
            : null,
        agreementError: 'Пожалуйста, дайте согласие на обработку данных',
      ));
      return;
    }

    if (discretizationController.text.isEmpty ||
        bitDepthController.text.isEmpty ||
        durationController.text.isEmpty ||
        double.tryParse(discretizationController.text) == null ||
        double.tryParse(discretizationController.text)! <= 0 ||
        double.tryParse(bitDepthController.text) == null ||
        double.tryParse(bitDepthController.text)! <= 0 ||
        double.tryParse(durationController.text) == null ||
        double.tryParse(durationController.text)! <= 0) {
      _validateDiscretization();
      _validateBitDepth();
      _validateDuration();
      return;
    }

    try {
      int channels = _getChannels(fileType);
      double discretization = double.parse(discretizationController.text);
      double bitDepth = double.parse(bitDepthController.text);
      double duration = double.parse(durationController.text);

      double fileSizeInBits = discretization * bitDepth * duration * channels;
      double fileSizeInBytes = fileSizeInBits / 8;
      double fileSizeInKB = fileSizeInBytes / 1024;
      double fileSizeInMB = fileSizeInKB / 1024;

      saveCalculation(
        fileType: fileType,
        discretization: discretization,
        bitDepth: bitDepth,
        duration: duration,
        fileSizeInBits: fileSizeInBits,
        fileSizeInBytes: fileSizeInBytes,
        fileSizeInKB: fileSizeInKB,
        fileSizeInMB: fileSizeInMB,
      );

      emit(MainScreenResult(
        fileSizeInBits: fileSizeInBits,
        fileSizeInBytes: fileSizeInBytes,
        fileSizeInKB: fileSizeInKB,
        fileSizeInMB: fileSizeInMB,
      ));
    } catch (e) {
      emit(MainScreenError('Ошибка при расчете: ${e.toString()}'));
    }
  }

  int _getChannels(String fileType) {
    switch (fileType) {
      case 'WAV':
      case 'FLAC':
        return 2;
      case 'MP3':
      case 'AAC':
      default:
        return 1;
    }
  }

  void resetForm() {
    discretizationController.clear();
    bitDepthController.clear();
    durationController.clear();
    fileType = 'WAV';
    agreement = false;
    emit(MainScreenInitial());
  }

  void saveCalculation({
    required String fileType,
    required double discretization,
    required double bitDepth,
    required double duration,
    required double fileSizeInBits,
    required double fileSizeInBytes,
    required double fileSizeInKB,
    required double fileSizeInMB,
  }) async {
    final data = {
      'fileType': fileType,
      'discretization': discretization,
      'bitDepth': bitDepth,
      'duration': duration,
      'fileSizeInBits': fileSizeInBits,
      'fileSizeInBytes': fileSizeInBytes,
      'fileSizeInKB': fileSizeInKB,
      'fileSizeInMB': fileSizeInMB,
    };
    await DatabaseService().insertCalculation(data);
  }
}
