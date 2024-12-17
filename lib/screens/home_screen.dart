import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/news_cubit.dart';
import '/models/news_model.dart';
import '/screens/news_detail_screen.dart';
import '/screens/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Articles> filteredArticles = [];

  final Color primaryColor = const Color(0xFFF6F1EC);
  final Color textColor = const Color(0xFF14181B);
  final Color dividerColor = const Color(0xFF2A6661);
  final Color blockColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: _buildAppBar(context),
      body: BlocBuilder<NewsCubit, List<Articles>>(
        builder: (context, articlesList) {
          if (articlesList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          filteredArticles = _filterArticles(articlesList);

          return Column(
            children: [
              _buildSearchField(),
              _buildArticlesList(),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'News',
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'Bazar',
              style: TextStyle(
                color: dividerColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.account_circle,
            color: textColor,
            size: 40,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfileWidget(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: blockColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.search, color: textColor),
            ),
            Expanded(
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Поиск',
                  hintStyle: TextStyle(color: textColor),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: textColor),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: blockColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            children: [
              _buildSectionTitle('Главные новости'),
              Divider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: dividerColor,
              ),
              ...filteredArticles.map((article) => _buildArticleCard(article)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildArticleCard(Articles article) {
    return GestureDetector(
      onTap: () {
        context.read<NewsCubit>().selectArticle(article);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: context.read<NewsCubit>(),
              child: const NewsDetailScreen(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Card(
          color: blockColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage ?? '',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    article.title ?? 'Без названия',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Articles> _filterArticles(List<Articles> articles) {
    final query = searchController.text.toLowerCase();
    return articles
        .where(
            (article) => article.title?.toLowerCase().contains(query) ?? false)
        .toList();
  }
}
