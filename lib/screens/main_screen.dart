import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';
import 'cubit/main_screen_state.dart';
import '../styles/form_style.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Злобин Никита Сергеевич'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<MainScreenCubit, MainScreenState>(
            builder: (context, state) {
              final cubit = context.read<MainScreenCubit>();

              if (state is MainScreenResult) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Размер файла:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${state.fileSizeInBits.toStringAsFixed(2)} бит',
                          textAlign: TextAlign.center),
                      Text('${state.fileSizeInBytes.toStringAsFixed(2)} байт',
                          textAlign: TextAlign.center),
                      Text('${state.fileSizeInKB.toStringAsFixed(2)} КБ',
                          textAlign: TextAlign.center),
                      Text('${state.fileSizeInMB.toStringAsFixed(2)} МБ',
                          textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: cubit.resetForm,
                        child: const Text('Назад'),
                      ),
                    ],
                  ),
                );
              }

              String? discretizationError;
              String? bitDepthError;
              String? durationError;
              String? agreementError;

              if (state is MainScreenFieldError) {
                discretizationError = state.discretizationError;
                bitDepthError = state.bitDepthError;
                durationError = state.durationError;
                agreementError = state.agreementError;
              }

              return Form(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: TextFormFieldStyle.textFieldStyle(
                          labelTextStr: 'Тип файла'),
                      value: cubit.fileType,
                      onChanged: (newValue) => cubit.updateFileType(newValue),
                      items: ['WAV', 'MP3', 'FLAC', 'AAC'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: cubit.discretizationController,
                      decoration: TextFormFieldStyle.textFieldStyle(
                          labelTextStr: 'Частота дискретизации (Гц)'),
                      keyboardType: TextInputType.number,
                    ),
                    if (discretizationError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            discretizationError,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: cubit.bitDepthController,
                      decoration: TextFormFieldStyle.textFieldStyle(
                          labelTextStr: 'Глубина кодирования звука (бит)'),
                      keyboardType: TextInputType.number,
                    ),
                    if (bitDepthError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            bitDepthError,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: cubit.durationController,
                      decoration: TextFormFieldStyle.textFieldStyle(
                          labelTextStr: 'Длительность звуковой дорожки (сек)'),
                      keyboardType: TextInputType.number,
                    ),
                    if (durationError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            durationError,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    BlocBuilder<MainScreenCubit, MainScreenState>(
                      builder: (context, checkboxState) {
                        return CheckboxListTile(
                          title: const Text('Согласен на обработку данных'),
                          value: cubit.agreement,
                          onChanged: cubit.updateAgreement,
                        );
                      },
                    ),
                    if (agreementError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            agreementError,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: cubit.calculateFileSize,
                      child: const Text('Рассчитать'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
