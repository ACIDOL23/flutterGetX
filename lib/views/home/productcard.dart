import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/models/products.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    product.imageLink,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Obx(() => IconButton(
                    icon: product.isFavorite.value
                        ? const Icon(Icons.favorite_rounded, color: Colors.redAccent,)
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      product.isFavorite.toggle();
                    },
                  )),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              style: GoogleFonts.balooBhai2(fontWeight: FontWeight.normal, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (product.rating != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.rating.toString(),
                        style: GoogleFonts.balooBhai2(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(width: 4,),
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text('\$${product.price}',
              style: GoogleFonts.balooBhai2(fontWeight: FontWeight.normal, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}