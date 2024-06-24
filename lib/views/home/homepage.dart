import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/authcontroller.dart';
import 'package:shopx/controllers/logincontroller.dart';
import 'package:shopx/controllers/productcontroller.dart';
import 'package:shopx/views/home/productcard.dart';
import 'package:shopx/views/home/productdetailspage.dart';
import 'package:shopx/views/home/userpostpage.dart';
import 'package:shopx/views/home/userprofilepage.dart';

class Homepage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: false,
        title: Text(
          "ShopX",
          style: GoogleFonts.balooBhai2(
            fontSize: 24,
          ),
        ),
        leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: authController.userModel.profilePic.isNotEmpty
                    ? NetworkImage(authController.userModel.profilePic ?? "")
                    : const AssetImage('assets/images/image1.png'),
                radius: 10,
              ),
            )),
        actions: [
          /*IconButton(
            onPressed: () {
              loginController.signOut();
              Get.off(LoginPage());
            },
            icon: const Icon(Icons.logout),
          ),*/
          IconButton(
            icon: const Icon(
              Icons.supervised_user_circle_sharp,
            ),
            onPressed: () {
              Get.to(UserPost());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {
              Get.to(UserDetailPage());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Welcome, ${authController.userModel.name}',
                      style: GoogleFonts.balooBhai2(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.view_list_rounded),
                    onPressed: () {
                      productController.changeViewMode(ViewMode.List);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.grid_view),
                    onPressed: () {
                      productController.changeViewMode(ViewMode.Grid);
                    },
                  ),
                ],
              ),
            ),
            Obx(
              () {
                if (productController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  if (productController.viewMode.value == ViewMode.Grid) {
                    return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: productController.productList.length,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            productController.product =
                                productController.productList[index];
                            Get.to(ProductDetails());
                          },
                          child: ProductTile(
                            productController.productList[index],
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productController.productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            productController.product =
                            productController.productList[index];
                            Get.to(ProductDetails());
                          },
                          child: ProductTile(
                            productController.productList[index],
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
