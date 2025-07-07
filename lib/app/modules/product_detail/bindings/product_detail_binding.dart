import 'package:get/get.dart';
import '../../shop/controllers/shop_controller.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController(), fenix: true);
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
    );
  }
}
