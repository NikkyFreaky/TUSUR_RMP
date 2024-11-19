import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nasa_cubit.dart';
import '../requests/api.dart';

class NasaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NasaCubit(ApiService())..loadPhotos(),
      child: Scaffold(
        appBar: AppBar(title: Text("Фотографии Марса")),
        body: BlocBuilder<NasaCubit, NasaState>(
          builder: (context, state) {
            if (state is NasaLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NasaLoadedState) {
              final photos = state.photos;
              return ListView.builder(
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return ListTile(
                    leading: Image.network(photo.imgSrc ?? ''),
                    title: Text("Ровер: ${photo.rover?.name ?? 'Неизвестно'}"),
                    subtitle: Text("Дата: ${photo.earthDate ?? 'Неизвестно'}"),
                  );
                },
              );
            } else if (state is NasaErrorState) {
              return Center(child: Text("Ошибка: ${state.errorMessage}"));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
