import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({super.key});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageMenu(context),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Menu",
                        style: TypographyStyles.bold(20, ColorStyles.black)),
                    const SizedBox(height: 6),
                    Text("Rp 50.000",
                        style:
                            TypographyStyles.semiBold(16, ColorStyles.black)),
                    const SizedBox(height: 12),
                    Text(
                      "Ini adalah deskripsi menu yang sangat enak dan sehat. Cocok untuk diet dan memenuhi kebutuhan nutrisi harian Anda.",
                      style: TypographyStyles.regular(16, ColorStyles.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 24,
                          color: ColorStyles.success,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Cocok untuk penderita diabetes.",
                          style:
                              TypographyStyles.regular(16, ColorStyles.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    notes(),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              const TabBar(
                labelColor: ColorStyles.primary,
                unselectedLabelColor: Colors.black,
                indicatorColor: ColorStyles.primary,
                tabs: [
                  Tab(text: "Nutrisi"),
                  Tab(text: "Ulasan"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Konten untuk Tab "Nutrisi"
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Informasi nutrisi untuk menu ini.",
                        style: TypographyStyles.regular(16, ColorStyles.black),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Ulasan pengguna untuk menu ini.",
                        style: TypographyStyles.regular(16, ColorStyles.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container notes() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Notes: ",
                      style: TypographyStyles.bold(16, ColorStyles.black),
                    ),
                    TextSpan(
                      text: "(Optional)",
                      style: TypographyStyles.regular(16, ColorStyles.black),
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppAssets.editIcon,
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Contoh: packing rapi, jangan pakai sambal, di pisah saus nya.",
            style: TypographyStyles.regular(14, const Color(0xFF7A7A7A)),
          )
        ],
      ),
    );
  }

  Stack imageMenu(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 330,
          child: Image.network(
            "https://picsum.photos/200/300",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppAssets.leftRoundedIcon,
              width: 40,
              height: 40,
            ),
          ),
        ),
      ],
    );
  }
}
