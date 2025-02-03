import 'dart:async';
import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/article_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/artikel/detail_artikel_page.dart';
import 'package:santapan_fe/pages/artikel/search_artikel_page.dart';
import 'package:santapan_fe/service/network.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({super.key});

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  bool isLoading = false;
  ArticleModel? _articleModel;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getArticle();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getArticle(_searchController.text);
    });
  }

  Future<void> getArticle([String search = ""]) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final String url = search.isNotEmpty
        ? Urls.articleUrl + "?num=8&search=$search"
        : Urls.articleUrl + "?num=8&search=";

    final NetworkResponse response = await NetworkCaller().getRequest(url);

    if (response.isSuccess) {
      _articleModel = ArticleModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Artikel",
            style: TypographyStyles.semiBold(24, ColorStyles.black),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                searhField(),
                const SizedBox(height: 24),
                bannerArtikel(),
                const SizedBox(height: 20),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  _articleModel != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _articleModel?.articles?.length ?? 0,
                          itemBuilder: (context, index) {
                            final article = _articleModel!.articles![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailArtikelPage(
                                      title: article.title ?? '',
                                      date: article.createdAt?.toIso8601String() ?? "",
                                      imageUrl: article.imageUrl ?? '',
                                      content: article.content ?? '',
                                    ),
                                  ),
                                );
                              },
                              child: listArtikel(
                                context,
                                article.imageUrl ?? '',
                                article.title ?? '',
                                article.content ?? '',
                                article.createdAt?.toIso8601String() ?? '',
                              ),
                            );
                          },
                        )
                      : const Center(child: Text('No Articles Available')),
                const SizedBox(height: 140),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container listArtikel(
      BuildContext context, String image, String title, String content, String date) {
    final formattedDate = DateTime.parse(date).toLocal();
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TypographyStyles.semiBold(14, ColorStyles.black),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TypographyStyles.regular(12, ColorStyles.grey),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.date_range_outlined,
                        color: ColorStyles.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      formattedDate.toString().substring(0, 10),
                      style: TypographyStyles.regular(12, ColorStyles.grey),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container bannerArtikel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        AppAssets.bannerArtikel,
        fit: BoxFit.cover,
      ),
    );
  }

  Container searhField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari Artikel',
          hintStyle: TypographyStyles.medium(14, ColorStyles.black),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 12),
            child: Image.asset(
              AppAssets.searchIcon,
              width: 24,
              height: 24,
            ),
          ),
          border: InputBorder.none,
          prefixIconConstraints: const BoxConstraints(minWidth: 12, minHeight: 14),
        ),
      ),
    );
  }
}
