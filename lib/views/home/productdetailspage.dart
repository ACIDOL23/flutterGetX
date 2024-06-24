import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:shopx/controllers/productcontroller.dart';

import '../../controllers/logincontroller.dart';


class ProductDetails extends StatelessWidget {
  final LoginController loginController = Get.find();
  final ProductController productController = Get.find();

  ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text(
          "Product Details",
          style: GoogleFonts.balooBhai2(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                productController.product.imageLink,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                "Product Name: ",
                style: GoogleFonts.balooBhai2(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                productController.product.name,
                style: GoogleFonts.balooBhai2(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Product Description:",
                style: GoogleFonts.balooBhai2(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                productController.product.description.trim(),
                style: GoogleFonts.balooBhai2(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                "Product Rating:",
                style: GoogleFonts.balooBhai2(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RatingStars(
                    color: Colors.green,
                    rating: productController.product.rating ?? 2.3,
                    editable: false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your button functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add to Cart",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.balooBhai2(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}