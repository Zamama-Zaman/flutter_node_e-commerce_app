import '../../lib.dart';

class HomeController extends BaseController {
  static final instance = Get.find<HomeController>();

  final TextEditingController searchCtrl = TextEditingController();

  List<Product>? searchedProducts;
  void search() async {
    searchedProducts = null;
    String searchQuery = searchCtrl.text.trim();
    if (searchQuery.isNotEmpty) {
      searchedProducts =
          await HomeService.instance.searchProduct(search: searchQuery);
    }

    if (searchedProducts != null && searchedProducts!.isNotEmpty) {
      // Fluttertoast.showToast(msg: "Successfully fetched searchedProducts");
    } else if (searchedProducts != null && searchedProducts!.isEmpty) {
      Fluttertoast.showToast(msg: "No Product Found!");
    }
    update();
  }

  List<String> carsoulSliderImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  //******************* Category View Details ******************//
  List<Product>? productList;
  String category = '';
  Future<void> fetchCategoryProducts() async {
    productList =
        await HomeService.instance.getProductByCategory(category: category);
    update();
  }

  List<Product>? topRatedProductsList;
  void topRatedProductsFetch() async {
    topRatedProductsList = await HomeService.instance.topRatedProducts();
    update();
  }
}
