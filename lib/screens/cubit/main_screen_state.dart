abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class MainScreenFieldError extends MainScreenState {
  final String? discretizationError;
  final String? bitDepthError;
  final String? durationError;
  final String? agreementError;

  MainScreenFieldError({
    this.discretizationError,
    this.bitDepthError,
    this.durationError,
    this.agreementError,
  });
}

class AgreementState extends MainScreenState {
  final bool agreement;

  AgreementState({required this.agreement});
}

class MainScreenResult extends MainScreenState {
  final double fileSizeInBits;
  final double fileSizeInBytes;
  final double fileSizeInKB;
  final double fileSizeInMB;

  MainScreenResult({
    required this.fileSizeInBits,
    required this.fileSizeInBytes,
    required this.fileSizeInKB,
    required this.fileSizeInMB,
  });
}

class MainScreenError extends MainScreenState {
  final String message;

  MainScreenError(this.message);
}
