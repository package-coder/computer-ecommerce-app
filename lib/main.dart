import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/providers/cart.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:provider/provider.dart';

final GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<AppRouter>(AppRouter());

  runApp(ChangeNotifierProvider(
    create: (context) => CartProvider(),
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Computer Ecommerce',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
