import 'lib.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(430, 932),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Flutter Node Ecommerce App',
            theme: AppTheme.baseTheme,
            debugShowCheckedModeBanner: false,
            binds: AppBinding.bindings,
            home: const LoginView(),
          );
        },
      ),
    );
  }
}
