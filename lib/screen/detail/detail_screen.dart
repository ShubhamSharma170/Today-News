import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:today_news/constant/colors.dart';
// import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const DetailScreen({
    super.key,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  // void _launchURL(String url) async {
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
            backgroundColor: AllColors.transparent,
            title: const Text('Detail'),
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AllColors.black,
            ),
          ),
        ),
      ),
      backgroundColor: AllColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 🖼️ Top Image
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      urlToImage ??
                      'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),

            // 📰 Content Below Image
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📝 Title
                    Text(
                      title ?? "No Title",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AllColors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 🧑 Author & Date
                    Row(
                      children: [
                        if (author != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AllColors.white70,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: AllColors.black12,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  author!,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        if (publishedAt != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AllColors.white70,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: AllColors.black12,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  publishedAt!.split('T').first,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 📄 Description
                    if (description != null && description!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),

                    // 📘 Content
                    if (content != null && content!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Content",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            content!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),

                    // 🔗 Read Full Article Button
                    // if (url != null && url!.isNotEmpty)
                    //   Center(
                    //     child: ElevatedButton.icon(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: AllColors.orangeFF8C42,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //         ),
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 24,
                    //           vertical: 12,
                    //         ),
                    //       ),
                    //       onPressed: () => _launchURL(url!),
                    //       icon: Icon(Icons.open_in_new, color: AllColors.black),
                    //       label: Text(
                    //         "Read Full Article",
                    //         style: TextStyleHelper.textStyle(
                    //           color: AllColors.black,
                    //           size: 16,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
