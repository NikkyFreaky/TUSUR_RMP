import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/news_cubit.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = context.read<NewsCubit>().selectedArticle;

    final Color primaryColor = const Color(0xFFF6F1EC);
    final Color blockColor = const Color(0xFFFFFFFF);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blockColor,
        title: const Text(
          'Детали новости',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article?.title ?? 'Без заголовка',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (article?.urlToImage != null)
                  Image.network(
                    article!.urlToImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 10),
                Text(
                  article?.description ?? 'Описание отсутствует.',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
