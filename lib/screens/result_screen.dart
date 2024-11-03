import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String fileType;
  final int discretization;
  final int bitDepth;
  final int duration;

  const ResultScreen({
    Key? key,
    required this.fileType,
    required this.discretization,
    required this.bitDepth,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int channels = _getChannels(fileType);
    int fileSizeInBits = discretization * bitDepth * duration * channels;
    double fileSizeInBytes = fileSizeInBits / 8;
    double fileSizeInKB = fileSizeInBytes / 1024;
    double fileSizeInMB = fileSizeInKB / 1024;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты расчета'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Тип файла: $fileType',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Частота дискретизации: $discretization Гц',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Глубина кодирования: $bitDepth бит',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Длительность: $duration сек',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Число каналов: $channels',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Объем звукового файла:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${fileSizeInBits.toStringAsFixed(2)} бит',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${fileSizeInBytes.toStringAsFixed(2)} байт',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${fileSizeInKB.toStringAsFixed(2)} КБ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${fileSizeInMB.toStringAsFixed(2)} МБ',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
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
}
