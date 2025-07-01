// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/network_manager/rest_client.dart';
import 'package:today_news/provider/top-headline_provider.dart';
import 'package:today_news/utils/loadingIndicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AllColors.floraWhite,
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
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () async {
                  await RestClient.getTopHeadlineNewsFromSource("cnn");
                },
                icon: const Icon(Icons.category_rounded, size: 35),
              ),
            ],
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) =>
            TopheadlineProvider()..getTopHeadlineProvider("cnn"),
        child: Consumer<TopheadlineProvider>(
          builder: (ctx, provider, child) {
            return SizedBox(
              height: height * .55,
              width: width,
              child: provider.isLoading
                  ? loadingIndicator(color: AllColors.white)
                  : ListView.builder(
                      itemCount: provider.model.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String date = Jiffy.parse(
                          provider.model.articles?[index].publishedAt ?? "",
                        ).format(pattern: "dd MMMM yyyy");
                        // return SizedBox(
                        //   child: Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: width * .01,
                        //           vertical: height * .007,
                        //         ),
                        //         width: width,
                        //         height: height * .55,
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadiusGeometry.circular(
                        //             12,
                        //           ),
                        //           child: CachedNetworkImage(
                        //             imageUrl:
                        //                 provider
                        //                     .model
                        //                     .articles?[index]
                        //                     .urlToImage! ??
                        //                 "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                        //             fit: BoxFit.fill,
                        //             placeholder: (ctx, url) =>
                        //                 loadingIndicator(),
                        //             errorWidget: (ctx, url, error) => Icon(
                        //               Icons.error_outline,
                        //               color: AllColors.red,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         bottom: 20,
                        //         child: Card(
                        //           color: AllColors.white,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(12),
                        //           ),
                        //           child: Padding(
                        //             padding: EdgeInsets.symmetric(
                        //               horizontal: 5,
                        //             ),
                        //             child: Container(
                        //               alignment: Alignment.bottomCenter,
                        //               height: height * .2,
                        //               child: Column(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   SizedBox(
                        //                     width: width * .85,
                        //                     child: Text(
                        //                       provider
                        //                               .model
                        //                               .articles?[index]
                        //                               .title ??
                        //                           "Null",
                        //                       style: GoogleFonts.poppins(
                        //                         fontSize: 17,
                        //                         fontWeight: FontWeight.w700,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Container(
                        //                     width: width * .85,

                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Text(
                        //                           provider
                        //                                   .model
                        //                                   .articles?[index]
                        //                                   .source
                        //                                   ?.name ??
                        //                               "Null",
                        //                           style: GoogleFonts.poppins(
                        //                             fontSize: 15,
                        //                             fontWeight: FontWeight.w600,
                        //                           ),
                        //                         ),
                        //                         Text(
                        //                           date,
                        //                           style: GoogleFonts.poppins(
                        //                             fontSize: 15,
                        //                             fontWeight: FontWeight.w600,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // 🖼️ Background Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        provider
                                            .model
                                            .articles?[index]
                                            .urlToImage ??
                                        "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: height * 0.55,
                                    placeholder: (ctx, url) =>
                                        loadingIndicator(),
                                    errorWidget: (ctx, url, error) =>
                                        Icon(Icons.error, color: AllColors.red),
                                  ),
                                ),

                                // 🌫️ Overlay Gradient
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black54,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // 📄 Text Info Card
                                Positioned(
                                  bottom: 20,
                                  left: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider
                                                  .model
                                                  .articles?[index]
                                                  .title ??
                                              "No Title",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              provider
                                                      .model
                                                      .articles?[index]
                                                      .source
                                                      ?.name ??
                                                  "Source",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                            Text(
                                              date,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
