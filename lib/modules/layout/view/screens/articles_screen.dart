
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c20_online/modules/layout/view/cubit/cubit.dart';
import 'package:news_c20_online/modules/layout/view/cubit/states.dart';

import '../../../../core/theme/app_colors.dart';
import 'articles_details_screen.dart';

class ArticlesScreen extends StatefulWidget {
  ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  void showArticleBottomSheet(dynamic article) {
    final screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.65),
      isDismissible: true,
      enableDrag: true,
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.55,
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 20,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: article.urlToImage ?? "",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const SizedBox(
                            height: 200,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          article.title ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "By : ${article.author ?? ""}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              article.publishedAt != null &&
                                  article.publishedAt!.length >= 10
                                  ? article.publishedAt!.substring(0, 10)
                                  : "",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(bottomSheetContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetailsScreen(article: article),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    child: const Text("View Full Article"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LayoutCubit, LayoutState>(
          buildWhen: (previous, current) {
            return current is GetSourceErrorState ||
                current is GetSourceLoadingState ||
                current is GetSourceSuccessState;
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<LayoutCubit>(context);

            if (state is GetSourceSuccessState) {
              return DefaultTabController(
                length: cubit.sources.length,
                child: TabBar(
                  onTap: (value) {
                    cubit.onChangeSource(cubit.sources[value]);
                  },
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: AppColors.white,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.white,
                  tabs: cubit.sources.map((e) {
                    return Tab(text: e.name ?? "");
                  }).toList(),
                ),
              );
            } else if (state is GetSourceLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetSourceErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        BlocBuilder<LayoutCubit, LayoutState>(
          buildWhen: (previous, current) {
            return current is GetNewsSuccessState ||
                current is GetNewsLoadingState ||
                current is GetNewsErrorState;
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<LayoutCubit>(context);

            if (state is GetNewsSuccessState) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: cubit.articles.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    var article = cubit.articles[index];

                    return GestureDetector(
                      onTap: () {
                        showArticleBottomSheet(article);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.white),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: article.urlToImage ?? "",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                height: 180,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                              const SizedBox(
                                height: 180,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              article.title ?? "",
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "By : ${article.author ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  article.publishedAt != null &&
                                      article.publishedAt!.length >= 10
                                      ? article.publishedAt!.substring(0, 10)
                                      : "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is GetNewsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetNewsErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
