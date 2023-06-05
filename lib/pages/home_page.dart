import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/cart_page.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:mobile_app/pages/parts_tab.dart';
import 'package:mobile_app/pages/service_tab.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/cart.dart';
import '../services/api_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ApiHandler()
        .getSession()
        .onError((error, stackTrace) =>  context.router.navigate(const LoginRoute()));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Computer Parts and Services'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                context.router.push(const AccountRoute());
              },
              icon: const Icon(Icons.menu),
            ),
            actions: <Widget>[
              badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                position: badges.BadgePosition.custom(start: 30, bottom: 30),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
            bottom: const TabBar(
              tabs: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Parts'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Services'),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              PartsTab(),
              ServiceTab(),
            ],
          )),
    );
  }
}
