import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

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
                            fontSize: size * 0.025,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            controller.profile.value.name,
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.035,
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
                          radius: size * 0.080,
                          backgroundImage:
                              NetworkImage(controller.profile.value.photo),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  child: ItemList(
                    size: size,
                    titleParam: 'Anak Burung',
                    items: ['Burung 1', 'Burung 2', 'Burung 3', 'Burung 4'],
                  ),
                ),
                ItemList(
                  size: size,
                  titleParam: 'Induk Burung',
                  items: ['Induk 1', 'Induk 2'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.size,
    required this.titleParam,
    required this.items,
  });

  final double size;
  final String titleParam;
  final List<String> items;

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
                fontSize: size * 0.030,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Lihat Semua...",
                style: GoogleFonts.roboto(
                  fontSize: size * 0.030,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size * 0.6,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: size * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size * 0.3,
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                'Image',
                                style: GoogleFonts.roboto(
                                  fontSize: size * 0.04,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            items[index],
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Subtitle or description',
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.03,
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
