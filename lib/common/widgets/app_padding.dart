import '../../lib.dart';

class AppPaddings {
  static get bottomPadding => EdgeInsetsDirectional.only(bottom: 16.h);
  static final commonHorizontalPadding =
      EdgeInsetsDirectional.symmetric(horizontal: 16.w);
  static final largeHorizontalPadding =
      EdgeInsetsDirectional.symmetric(horizontal: 24.w);
  static final largeVerticalPadding =
      EdgeInsetsDirectional.symmetric(vertical: 24.w);
  static final commonVerticalPadding =
      EdgeInsetsDirectional.symmetric(vertical: 16.w);
  static final commonAllSidePadding = EdgeInsetsDirectional.all(16.w);
}
