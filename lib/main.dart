import 'lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreference.instance.initiatePreference();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            binds: AppBinding.bindings,
            home: AppPreference.instance.getUserModel.token.isNotEmpty
                ? AppPreference.instance.getUserModel.type == "admin"
                    ? const AdminView()
                    : const DefaultView()
                : const LoginView(),
          );
        },
      ),
    );
  }
}
 
/// Add localization for both front-end and back-end.
/// After localization add Unit test for both front-end and back-end
/// Please add a new stackholder of owner, 
/// which have CRUD Operation on Products.
/// And Admin will have Orders Module.
/// And then add chat module to add chat module with sockets!