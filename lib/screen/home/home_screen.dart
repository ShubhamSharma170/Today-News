// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/helper/storage_helper/storage_helper.dart';
import 'package:today_news/helper/text_style_helper.dart/text_style.dart';
import 'package:today_news/provider/top-headline_provider.dart';
import 'package:today_news/provider/topic_news_provider.dart';
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
  TextEditingController topicController = TextEditingController();
  String newsChannel = "wired";
  String topic = "technology";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TopheadlineProvider>(
        context,
        listen: false,
      ).getTopHeadlineProvider(newsChannel);

      Provider.of<TopicNewsProvider>(
        context,
        listen: false,
      ).topicNewsProvider(topic);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // log("Checking user id.........${StorageHelper().getString()}");

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
            leading: IconButton(
              icon: Icon(Icons.menu, color: AllColors.black),
              onPressed: () =>
                  Navigator.pushNamed(context, RoutesName.category),
            ),
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
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * .55,
                  width: width,
                  child: provider.isLoading
                      ? loadingIndicator(color: AllColors.black)
                      : ListView.builder(
                          itemCount: provider.model.articles?.length ?? 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String date = Jiffy.parse(
                              provider.model.articles?[index].publishedAt ?? "",
                            ).format(pattern: "dd MMMM yyyy");
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.detail,
                                    arguments: {
                                      "author": provider
                                          .model
                                          .articles?[index]
                                          .author,
                                      "title":
                                          provider.model.articles?[index].title,
                                      "description": provider
                                          .model
                                          .articles?[index]
                                          .description,
                                      "url":
                                          provider.model.articles?[index].url,
                                      "urlToImage": provider
                                          .model
                                          .articles?[index]
                                          .urlToImage,
                                      "publishedAt": provider
                                          .model
                                          .articles?[index]
                                          .publishedAt,
                                      "content": provider
                                          .model
                                          .articles?[index]
                                          .content,
                                    },
                                  );
                                },
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
                              ),
                            );
                          },
                        ),
                ),

                Container(
                  height: height * 0.1,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: topicController,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter a topic...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: AllColors.orange0xFFFFF3B0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AllColors.orange0xFFFFF3B0,
                          ),
                        ),

                        onPressed: () {
                          // Add topic action
                          Future.microtask(
                            () => Provider.of<TopicNewsProvider>(
                              context,
                              listen: false,
                            ).topicNewsProvider(topicController.text.trim()),
                          );
                        },
                        child: Text(
                          'Search',
                          style: TextStyleHelper.textStyle(
                            color: AllColors.black,
                            size: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<TopicNewsProvider>(
                  builder: (ctx, provider, child) {
                    return SizedBox(
                      child:
                          provider.model.articles == null ||
                              provider.model.articles!.isEmpty
                          ? Center(
                              child: Text(
                                "No Data Found",
                                style: TextStyleHelper.textStyle(
                                  color: AllColors.black,
                                  size: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : provider.isLoading
                          ? loadingIndicator(color: AllColors.black)
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.model.articles?.length ?? 0,
                              itemBuilder: (ctx, index) => Card(
                                margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                clipBehavior: Clip
                                    .antiAlias, // important for rounded corners
                                child: InkWell(
                                  onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.detail,
                                    arguments: {
                                      "author": provider
                                          .model
                                          .articles?[index]
                                          .author,
                                      "title":
                                          provider.model.articles?[index].title,
                                      "description": provider
                                          .model
                                          .articles?[index]
                                          .description,
                                      "url":
                                          provider.model.articles?[index].url,
                                      "urlToImage": provider
                                          .model
                                          .articles?[index]
                                          .urlToImage,
                                      "publishedAt": provider
                                          .model
                                          .articles?[index]
                                          .publishedAt,
                                      "content": provider
                                          .model
                                          .articles?[index]
                                          .content,
                                    },
                                  );
                                },
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
                                        errorWidget: (ctx, url, error) => Icon(
                                          Icons.error,
                                          color: AllColors.red,
                                        ),
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
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
