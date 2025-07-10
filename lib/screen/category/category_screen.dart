import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/provider/category_news_provider.dart';
import 'package:today_news/utils/loadingIndicator.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryName = "Business";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryNewsProvider>(
        context,
        listen: false,
      ).getCategoryNews(categoryName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List categoryList = [
      "Business",
      "Entertainment",
      "General",
      "Health",
      "Science",
      "Sports",
      "Technology",
    ];
    return Scaffold(
      backgroundColor: AllColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AllColors.splashColor,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [0.1, 0.9],
              tileMode: TileMode.clamp,
              transform: GradientRotation(90),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Category'),
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AllColors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryName = categoryList[index];
                      Provider.of<CategoryNewsProvider>(
                        context,
                        listen: false,
                      ).getCategoryNews(categoryName);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AllColors.floraWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AllColors.black),
                    ),
                    child: Text(
                      categoryList[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AllColors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<CategoryNewsProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  child: provider.isLoading
                      ? loadingIndicator()
                      : ListView.builder(
                          itemCount: provider.model.articles?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              clipBehavior: Clip
                                  .antiAlias, // important for rounded corners
                              child: Stack(
                                children: [
                                  // 🖼️ Background Image
                                  CachedNetworkImage(
                                    imageUrl:
                                        provider
                                            .model
                                            .articles?[index]
                                            .urlToImage ??
                                        "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                    placeholder: (ctx, url) =>
                                        loadingIndicator(),
                                    errorWidget: (ctx, url, error) =>
                                        Icon(Icons.error, color: AllColors.red),
                                  ),

                                  // 🌫️ Gradient overlay for text readability
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black87,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),

                                  // 📝 Text on top of image
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider
                                                  .model
                                                  .articles?[index]
                                                  .title ??
                                              "Not Available",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          provider
                                                  .model
                                                  .articles?[index]
                                                  .description ??
                                              "Not Available",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                            // return Card(
                            //   child: ListTile(
                            //     title: Text(
                            //       provider.model.articles?[index].title ?? "",
                            //       style: GoogleFonts.poppins(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     subtitle: Text(
                            //       provider.model.articles?[index].description ?? "",
                            //       maxLines: 2,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: GoogleFonts.poppins(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w400,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     leading: ClipRRect(
                            //       borderRadius: BorderRadius.circular(16),
                            //       child: CachedNetworkImage(
                            //         imageUrl:
                            //             provider.model.articles?[index].urlToImage ??
                            //             "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                            //         fit: BoxFit.cover,
                            //         // width: 150,
                            //         // height: 200,
                            //         placeholder: (ctx, url) => loadingIndicator(),
                            //         errorWidget: (ctx, url, error) =>
                            //             Icon(Icons.error, color: AllColors.red),
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
