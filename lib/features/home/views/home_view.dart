import '../../../lib.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.searchAppBar(
        controller: controller.searchCtrl,
        onTap: controller.search,
      );

  @override
  Widget? get body => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            AppGapVertical.sixteen,

            //* slider
            const CarouselImage(),

            //
            AppGapVertical.sixteen,

            //*categories item
            const CategoriesView(),

            //
            AppGapVertical.sixteen,

            //* Top category item
            const TopRatedView(),

            //
            AppGapVertical.fortyEight,
          ],
        ),
      );
}
