import 'package:flutter/material.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/personalisasi_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/data/utils/auth_utils.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/navbar.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';

class PreferensiMakananPage extends StatefulWidget {
  final bool isEdit;
  final List<Map<String, dynamic>> penyakit;

  const PreferensiMakananPage({
    super.key,
    required this.isEdit,
    required this.penyakit,
  });

  @override
  State<PreferensiMakananPage> createState() => _PreferensiMakananPageState();
}

class _PreferensiMakananPageState extends State<PreferensiMakananPage> {
  final List<Map<String, dynamic>> preferences = [
    {'name': 'Rendah Karbohidrat', 'selected': false},
    {'name': 'Tinggi Protein', 'selected': false},
    {'name': 'Vegetarian', 'selected': false},
    {'name': 'Rendah Gula', 'selected': false},
    {'name': 'Rendah Kalori', 'selected': false},
  ];

  @override
  void initState() {
    super.initState();
    if (!widget.isEdit) {
      _setInitialPreferences();
    }
  }

  void _setInitialPreferences() {
    for (var penyakit in widget.penyakit) {
      if (penyakit['selected']) {
        if (penyakit['type'] == 'diabetes') {
          _setPreference('Rendah Gula', true);
          _setPreference('Rendah Kalori', true);
        }
        if (penyakit['type'] == 'kolestrol') {
          _setPreference('Rendah Karbohidrat', true);
          _setPreference('Rendah Kalori', true);
        }
      }
    }
  }

  void _setPreference(String preferenceName, bool selected) {
    for (var pref in preferences) {
      if (pref['name'] == preferenceName) {
        setState(() {
          pref['selected'] = selected;
        });
      }
    }
  }

  Future<void> savePreferences() async {
    String url = Urls.personalisasiURL;

    Personalisasi personalisasi = Personalisasi(
      diabetes: widget.penyakit.any(
          (penyakit) => penyakit['type'] == 'diabetes' && penyakit['selected']),
      lambung: widget.penyakit.any(
          (penyakit) => penyakit['type'] == 'lambung' && penyakit['selected']),
      jantung: widget.penyakit.any(
          (penyakit) => penyakit['type'] == 'jantung' && penyakit['selected']),
      obesitas: widget.penyakit.any(
          (penyakit) => penyakit['type'] == 'obesitas' && penyakit['selected']),
      rendahKarbohidrat: preferences.firstWhere(
          (pref) => pref['name'] == 'Rendah Karbohidrat')['selected'],
      tinggiProtein: preferences
          .firstWhere((pref) => pref['name'] == 'Tinggi Protein')['selected'],
      vegetarian: preferences
          .firstWhere((pref) => pref['name'] == 'Vegetarian')['selected'],
      rendahGula: preferences
          .firstWhere((pref) => pref['name'] == 'Rendah Gula')['selected'],
      rendahKalori: preferences
          .firstWhere((pref) => pref['name'] == 'Rendah Kalori')['selected'],
    );

    Map<String, dynamic> body = personalisasi.toJson();

    NetworkResponse response = await NetworkCaller().postRequest(url, body);

    if (response.isSuccess && response.body != null) {
      await AuthUtility.setUserPreferences(
          personalisasi); // Save preferences locally
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preferences saved successfully!'),
          backgroundColor: ColorStyles.success,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Navbar()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save preferences, try again.'),
          backgroundColor: ColorStyles.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(AppAssets.arrowLeft,
                          width: 24, height: 24)),
                  Text(
                    "Skip",
                    style: TypographyStyles.bold(16, ColorStyles.primary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Personalisasi Kesehatan Anda",
                style: TypographyStyles.bold(24, ColorStyles.black),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                  itemCount: preferences.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            preferences[index]['name'],
                            style:
                                TypographyStyles.medium(14, ColorStyles.black),
                          ),
                          Checkbox(
                            value: preferences[index]['selected'],
                            activeColor: Colors.white,
                            checkColor: ColorStyles.primary,
                            onChanged: (bool? value) {
                              setState(() {
                                preferences[index]['selected'] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              ButtonCustom(
                label: "Simpan dan Lanjutkan",
                onTap: savePreferences,
                isExpand: true,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ));
  }
}
