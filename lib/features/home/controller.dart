import '../../lib.dart';

class HomeController extends BaseController {
  static final instance = Get.find<HomeController>();

  final TextEditingController searchCtrl = TextEditingController();

  void search() {}

  List<String> carsoulSliderImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  //********** Product Detail View ************//

  double avgRating = 0;
  double myRating = 0;

  void initFunction() {
    double totalRating = 0;
    // for (int i = 0; i < product.rating!.length; i++) {
    //   totalRating += product.rating![i].rating;
    //   if (product.rating![i].userId ==
    //       Provider.of<UserProvider>(context, listen: false).user.id) {
    //     myRating = widget.product.rating![i].rating;
    //   }
    // }

    // if (totalRating != 0) {
    //   avgRating = totalRating / product.rating!.length;
    // }
  }

  void addToCart() {
    // productDetailsServices.addToCart(
    //   context: context,
    //   product: widget.product,
    // );
  }
}
