import 'package:flutter/material.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final TextEditingController nameController = TextEditingController();

  final Color primaryColor = const Color(0xFFF6F1EC);
  final Color dividerColor = const Color(0xFF2A6661);
  final Color textColor = const Color(0xFF14181B);
  final Color blockColor = const Color(0xFFFFFFFF);

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blockColor,
        title: Text(
          'Редактирование профиля',
          style: TextStyle(color: textColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.network(
                        'https://sun6-20.userapi.com/s/v1/ig2/i-Ft7pR1F6uDxymYanEY9F4N8QVB7FsbmUdzRQ3_0oasvhblI3voBFlcIgGnb0R11tI_-8X0uiZhphCr7UP1GX5y.jpg?size=1000x1000&quality=95&crop=0,0,1000,1000&ava=1',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.error,
                            color: dividerColor,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Ваше имя',
                    labelStyle: TextStyle(color: textColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: dividerColor, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: dividerColor, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    print('Name Saved: ${nameController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dividerColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(fontSize: 16, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
