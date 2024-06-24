import 'package:get/get.dart';
import 'package:shopx/models/products.dart';
import 'package:shopx/services/base_controller.dart';
import 'package:shopx/services/remote_services.dart';

class ProductController extends GetxController with BaseController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  late Product product;
  Rx<ViewMode> viewMode = ViewMode.Grid.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void changeViewMode(ViewMode mode) {
    viewMode.value = mode;
  }

}

enum ViewMode { Grid, List }
