import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/data/models/cart_home_model.dart';
import 'package:santapan_fe/data/models/category_model.dart';
import 'package:santapan_fe/data/models/menu_model.dart';
import 'package:santapan_fe/data/urls.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/auth/signin_page.dart';
import 'package:santapan_fe/pages/beranda/detail_menu_page.dart';
import 'package:santapan_fe/pages/beranda/search_product_page.dart';
import 'package:santapan_fe/pages/berlangganan/langganan_bulanan_page.dart';
import 'package:santapan_fe/pages/berlangganan/langganan_mingguan_page.dart';
import 'package:santapan_fe/pages/categories/categories_page.dart';
import 'package:santapan_fe/pages/payment/payment_page.dart';
import 'package:santapan_fe/service/network.dart';
import 'package:santapan_fe/widget/button_custom.dart';
import 'package:santapan_fe/widget/carousel_card_beranda.dart';
import 'package:santapan_fe/widget/categories_food.dart';
import 'package:santapan_fe/widget/item_catalog.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategories();
      getMenu();
      getPersonalisasiMenu();
      getCart();
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  bool isLoadingRecommendation = false;
  bool isLoadingPersonalisasi = false;
  CategoryModel _categoryModel = CategoryModel();
  bool isLoading = false;

  int cartCount = 0;
  int cartAmount = 0;

  MenuModel _menuModel = MenuModel();
  MenuModel _menuPersonalisasiModel = MenuModel();

  Future<void> getCategories() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.categoriesURl + "?num=8");

    if (response.isSuccess) {
      _categoryModel = CategoryModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getMenu() async {
    if (mounted) {
      setState(() {
        isLoadingRecommendation = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest("${Urls.menuUrl}?num=10");
    if (response.isSuccess) {
      _menuModel = MenuModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load menu data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoadingRecommendation = false;
      });
    }
  }

  // Get Cart
  Future<void> getCart() async {
    if (mounted) {
      setState(() {
        isLoadingRecommendation = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cartUrl + "/home");
    if (response.isSuccess) {
      final CartHomeModel cartModel = CartHomeModel.fromJson(response.body!);
      if (cartModel.data != null) {
        setState(() {
          cartCount = cartModel.data!.totalQuantity ?? 0;
          cartAmount = cartModel.data!.totalAmount ?? 0;
        });
      }
    }
    if (response.statusCode == 401) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SigninPage(),
        ),
      );
    }
  }

  Future<void> getPersonalisasiMenu() async {
    if (mounted) {
      setState(() {
        isLoadingPersonalisasi = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest("${Urls.menuUrl}/recommendation?num=8");
    if (response.isSuccess) {
      print("MENU PERSONALISASI: ${response.body}");
      _menuPersonalisasiModel = MenuModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load menu data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoadingPersonalisasi = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final currencyFormatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 42,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: header(),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CarouselCardBeranda(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: searchField(),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Kategori",
                    style: TypographyStyles.bold(16, ColorStyles.black),
                  ),
                ),
                getCategoriesList(),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Paket Langganan",
                    style: TypographyStyles.bold(16, ColorStyles.black),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: langgananPaket(),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Personalisasi Untukmu",
                          style: TypographyStyles.bold(16, ColorStyles.black)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 0),
                  child: SizedBox(
                    height: 200,
                    child: _menuPersonalisasiModel.data?.menus?.isNotEmpty == true
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: _menuPersonalisasiModel.data!.menus!.map((menu) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ItemCatalog(
                                    name: menu.title ?? "Unknown",
                                    imageUrl: menu.image ?? "",
                                    price: (menu.price ?? 0).toDouble(),
                                    rating: 5.0,
                                    onPress: () async {
                                      final bool? isCartUpdated = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>  DetailMenuPage(
                                            id: menu.id ?? 0,
                                          ),
                                        ),
                                      );

                                      // If the cart was updated, refetch getCart()
                                      if (isCartUpdated == true) {
                                        getCart();
                                      }
                                    }),
                              );
                            }).toList(),
                          )
                        : const SizedBox(), // Don't display anything if menus are empty
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Katalog Lainnya",
                          style: TypographyStyles.bold(16, ColorStyles.black)),
                      Text("Lihat Semua",
                          style:
                              TypographyStyles.semiBold(14, ColorStyles.black)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 0),
                  child: SizedBox(
                    height: 200,
                    child: _menuModel.data?.menus?.isNotEmpty == true
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: _menuModel.data!.menus!.map((menu) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ItemCatalog(
                                    name: menu.title ?? "Unknown",
                                    imageUrl: menu.image ?? "",
                                    price: (menu.price ?? 0).toDouble(),
                                    rating: 5.0,
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailMenuPage(
                                            id: menu.id ?? 0,
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }).toList(),
                          )
                        : const SizedBox(), // Don't display anything if menus are empty
                  ),
                ),
                const SizedBox(
                  height: 250,
                ),
              ],
            ),
          ),
          if (cartCount > 0)
            Positioned(
                bottom: 110,
                left: 10,
                child: Container(
                  width: screenWidth - 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 80.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Harga",
                            style: TypographyStyles.semiBold(
                                12, ColorStyles.black),
                          ),
                          Text(
                            currencyFormatter.format(cartAmount),
                            style: TypographyStyles.bold(16, ColorStyles.black),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Better Button Not Button Custom
                      GestureDetector(
                        onTap: () async {
                          final bool? isCartUpdated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentPage(),
                            ),
                          );

                          // If the cart was updated, refetch getCart()
                          if (isCartUpdated == true) {
                            getCart();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: ColorStyles.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Lihat Pesanan",
                            style: TypographyStyles.bold(12, Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  Widget getCategoriesList() {
    if (_categoryModel.data == null ||
        _categoryModel.data!.categories == null ||
        _categoryModel.data!.categories!.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Number of columns
        crossAxisSpacing: 10.0, // Horizontal spacing
        mainAxisSpacing: 10.0, // Vertical spacing
      ),
      padding: const EdgeInsets.all(20), // Adding padding for clarity
      itemCount:
          _categoryModel.data!.categories!.length, // Total number of items
      itemBuilder: (context, index) {
        return CategoriesFood(
          image: _categoryModel.data!.categories![index].image ?? "",
          text: _categoryModel.data!.categories![index].title ?? "Loading..",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoriesPage(
                        id: (_categoryModel.data!.categories![index].id ?? 0)
                            .toString(),
                        title:
                            _categoryModel.data!.categories![index].title ?? "",
                      )),
            );
          },
        );
      },
    );
  }

  Container menuTitleHorizontal() {
    return Container(
      width: 156,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        AppAssets.katalogImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Row langgananPaket() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final bool? isCartUpdated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanggananMingguanPage(id: 1),
                ),
              );

              // If the cart was updated, refetch getCart()
              if (isCartUpdated == true) {
                getCart();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                AppAssets.langgananMingguan,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              final bool? isCartUpdated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanggananBulananPage(id: 2),
                ),
              );

              // If the cart was updated, refetch getCart()
              if (isCartUpdated == true) {
                getCart();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                AppAssets.langgananBulanan,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container searchField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchProductPage()),
          );
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari makanan kamu',
              hintStyle: TypographyStyles.medium(14, ColorStyles.black),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 12,
                ),
                child: Image.asset(
                  AppAssets.searchIcon,
                  width: 24,
                  height: 24,
                ),
              ),
              border: InputBorder.none,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppAssets.berandaLogo,
          width: 138,
          height: 45,
        ),
        Image.asset(
          AppAssets.notif,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
