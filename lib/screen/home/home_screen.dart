// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/helper/storage_helper/storage_helper.dart';
import 'package:today_news/provider/top-headline_provider.dart';
import 'package:today_news/routes/routes_name.dart';
import 'package:today_news/utils/loadingIndicator.dart';

List filterNewsList = ["wired", "techradar", "cnn", "bbc-news"];
// enum FilterNewsList { wired, techradar, cnn }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String newsChannel = "wired";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TopheadlineProvider>(
        context,
        listen: false,
      ).getTopHeadlineProvider(newsChannel);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // log("Checking user id.........${StorageHelper().getString()}");

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
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AllColors.black,
            ),
            actions: [
              PopupMenuButton(
                tooltip: "Select News Channel",
                onSelected: (value) {
                  setState(() {
                    newsChannel = value.toString();
                  });
                  Future.microtask(() {
                    Provider.of<TopheadlineProvider>(
                      context,
                      listen: false,
                    ).getTopHeadlineProvider(newsChannel);
                  });
                },
                itemBuilder: (context) => filterNewsList
                    .map(
                      (channel) => PopupMenuItem(
                        value: channel,
                        child: Row(
                          children: [
                            Icon(
                              Icons.radio_button_checked,
                              size: 16,
                              color: channel == newsChannel
                                  ? AllColors.splashColor[0]
                                  : Colors.transparent,
                            ),
                            const SizedBox(width: 8),
                            Text(channel.toUpperCase()),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  StorageHelper().clean();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.login,
                    (_) => false,
                  );
                },
                icon: Icon(
                  Icons.logout_rounded,
                  size: 35,
                  color: AllColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<TopheadlineProvider>(
        builder: (ctx, provider, child) {
          return provider.isLoading
              ? loadingIndicator(color: AllColors.white)
              : Column(
                  children: [
                    SizedBox(
                      height: height * .55,
                      width: width,
                      child:
                          //  provider.isLoading
                          //     ? loadingIndicator(color: AllColors.white)
                          //     :
                          ListView.builder(
                            itemCount: provider.model.articles?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              String date = Jiffy.parse(
                                provider.model.articles?[index].publishedAt ??
                                    "",
                              ).format(pattern: "dd MMMM yyyy");
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
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
                                              Icon(
                                                Icons.error,
                                                color: AllColors.red,
                                              ),
                                        ),
                                      ),

                                      // 🌫️ Overlay Gradient
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
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
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey[800],
                                                    ),
                                                  ),
                                                  Text(
                                                    date,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                    ),
                    Expanded(child: Container(color: AllColors.deepPurple)),
                  ],
                );
        },
      ),
    );
  }
}
