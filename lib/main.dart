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
 
/// Add Unit test for both front-end and from postman.
/// Add Unit test for back-end. Implementing plan
/// Please add a new stackholder of owner, 
/// which have CRUD Operation on Products.
/// And Admin will have Orders Module.
/// And then add chat module to add chat module with sockets!
/// 


/// Today's Report 08-10-24:
/// - Continue Learning Node JS Unit Testing.
///   - Implement for the sinlge function.
///   - Unit test Continue learning...

/// - Continue Learning Unit Testing in Postman.
///   - Complet video session from 2:10 to 2:46.
///   - Learn how to assert the unit test in postman script.
///   - Learn about Chaijs Library.