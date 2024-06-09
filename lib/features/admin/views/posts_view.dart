import '../../../lib.dart';

class PostsView extends BaseWidget<AdminController> {
  const PostsView({super.key});

  @override
  Widget get child => const Center(
        child: Text('Posts View'),
      );
}
