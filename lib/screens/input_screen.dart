import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../styles/text_form_field_style.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _discretization = TextEditingController();
  final _bitDepth = TextEditingController();
  final _duration = TextEditingController();

  bool _agreement = false;

  String _fileType = 'WAV';
  final List<String> _fileTypes = ['WAV', 'MP3', 'FLAC', 'AAC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Злобин Никита Сергеевич',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: TextFormFieldStyle.textFieldStyle(
                  labelTextStr: 'Тип файла',
                ),
                value: _fileType,
                onChanged: (String? newValue) {
                  setState(() {
                    _fileType = newValue!;
                  });
                },
                items: _fileTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                decoration: TextFormFieldStyle.textFieldStyle(
                  labelTextStr: 'Частота дискретизации (Гц)',
                ),
                controller: _discretization,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите частоту дискретизации';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Введите корректное число больше нуля';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                decoration: TextFormFieldStyle.textFieldStyle(
                  labelTextStr: 'Глубина кодирования звука (бит)',
                ),
                controller: _bitDepth,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите глубину кодирования';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Введите корректное число больше нуля';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                decoration: TextFormFieldStyle.textFieldStyle(
                  labelTextStr: 'Длительность звуковой дорожки (сек)',
                ),
                controller: _duration,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите длительность';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Введите корректное число больше нуля';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                value: _agreement,
                title: const Text(
                  'Согласен на обработку данных',
                  style: TextStyle(color: Colors.white),
                ),
                onChanged: (bool? value) => setState(() => _agreement = value!),
                subtitle: !_agreement
                    ? const Text(
                        'Необходимо ваше согласие',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(20, 20, 20, 1.0),
                  textStyle: const TextStyle(fontSize: 15),
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _agreement) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          fileType: _fileType,
                          discretization: int.parse(_discretization.text),
                          bitDepth: int.parse(_bitDepth.text),
                          duration: int.parse(_duration.text),
                        ),
                      ),
                    );
                  } else if (!_agreement) {
                    setState(() {});
                  }
                },
                child: Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
