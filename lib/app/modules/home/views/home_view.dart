import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/modules/canarylist/views/canarylist_view.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/views/chickslist_view.dart';
import 'package:royal_canary_farm_app/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo,",
                          style: GoogleFonts.roboto(
                            fontSize: size.width * 0.030,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            controller.profile.value.name,
                            style: GoogleFonts.roboto(
                              fontSize: size.width * 0.040,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PROFILE);
                      },
                      child: Obx(() {
                        return CircleAvatar(
                          radius: size.width * 0.090,
                          backgroundImage:
                              NetworkImage(controller.profile.value.photo),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    height: size.width * 9 / 16,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(
                      seconds: 5,
                    ),
                  ),
                  items: [
                    'assets/images/canary_farm_1.png',
                    'assets/images/canary_farm_2.png',
                    'assets/images/canary_farm_3.png'
                  ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: size.width,
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.birdParents.isEmpty) {
                    return Text("Tidak ada data Induk Burung");
                  }
                  return ItemList<BirdParent>(
                    size: MediaQuery.of(context).size,
                    titleParam: 'Induk Burung',
                    items: controller.birdParents,
                    onSeeAllPressed: () {
                      Get.to(() => CanarylistView());
                    },
                  );
                }),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.chickData.isEmpty) {
                    return Text("Tidak ada data anak burung");
                  }
                  return ItemList<Chicks>(
                    size: MediaQuery.of(context).size,
                    titleParam: 'Anak Burung',
                    items: controller.chickData,
                    onSeeAllPressed: () {
                      Get.to(() => ChickslistView());
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemList<T> extends StatelessWidget {
  const ItemList({
    Key? key,
    required this.size,
    required this.titleParam,
    required this.items,
    required this.onSeeAllPressed,
  }) : super(key: key);

  final Size size;
  final String titleParam;
  final List<T> items;
  final VoidCallback onSeeAllPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleParam,
              style: GoogleFonts.roboto(
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: onSeeAllPressed,
              child: Text(
                "Lihat Semua...",
                style: GoogleFonts.roboto(
                  fontSize: size.width * 0.035,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.width * 0.65, // Adjust height to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: Container(
                    width: size.width * 0.4, // Lebar setiap item dalam ListView
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.width *
                                0.3, // Menyesuaikan ketinggian container untuk gambar
                            color: Colors.grey[300],
                            child: item is BirdParent
                                ? Image.network(item.photo ?? '',
                                    fit: BoxFit.cover)
                                : item is Chicks
                                    ? Image.network(item.photo ?? '',
                                        fit: BoxFit.cover)
                                    : Center(
                                        child: Text(
                                          'No Image',
                                          style: GoogleFonts.roboto(
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                      ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item is BirdParent
                                ? item.ringNumber!
                                : item is Chicks
                                    ? item.ringNumber!
                                    : 'Unknown',
                            style: GoogleFonts.roboto(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item is BirdParent
                                ? 'Gender: ${item.gender}'
                                : item is Chicks
                                    ? 'Gender: ${item.gender}'
                                    : '',
                            style: GoogleFonts.roboto(
                              fontSize: size.width * 0.03,
                            ),
                          ),
                          Text(
                            item is BirdParent
                                ? 'Canary Type: ${item.canaryType}'
                                : item is Chicks
                                    ? 'Canary Type: ${item.canaryType}'
                                    : '',
                            style: GoogleFonts.roboto(
                              fontSize: size.width * 0.03,
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
        ),
      ],
    );
  }
}
