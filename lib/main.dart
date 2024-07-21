import 'lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.instance.initiatePreference();
  runApp(const MyApp());
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

/// Next thing is to handle error 
/// Finized for today.
/// And then add localization
/// And then add chat module