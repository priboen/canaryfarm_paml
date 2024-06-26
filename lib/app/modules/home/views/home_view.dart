import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                // ItemList(
                //   size: size,
                //   titleParam: 'Anak Burung',
                //   items: ['Burung 1', 'Burung 2', 'Burung 3', 'Burung 4'],
                // ),
                // const SizedBox(height: 20),
                // ItemList(
                //   size: size,
                //   titleParam: 'Induk Burung',
                //   items: ['Induk 1', 'Induk 2'],
                // ),
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
    Key? key,
    required this.size,
    required this.titleParam,
    required this.items,
  }) : super(key: key);

  final Size size;
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
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
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
          height: size.width *
              0.6, // Menyediakan ruang yang cukup untuk ListView horizontal
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width:
                          size.width * 0.4, // Lebar setiap item dalam ListView
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.width *
                                  0.3, // Menyesuaikan ketinggian container untuk gambar
                              color: Colors.grey[300],
                              child: Center(
                                child: Text(
                                  'Image',
                                  style: GoogleFonts.roboto(
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              items[index],
                              style: GoogleFonts.roboto(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
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
        ),
      ],
    );
  }
}
