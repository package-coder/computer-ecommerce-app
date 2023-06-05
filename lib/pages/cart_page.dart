import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../services/api_handler.dart';

class CartScreen extends StatefulWidget { const CartScreen({
  Key? key,
}) : super(key: key);

@override
State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Catalog Cart'),
      ),
      body: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
                if (provider.items.isEmpty) {
                  return const Center(
                      child: Text(
                        'Your Cart is Empty',
                      ));
                } else {
                  return ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: provider.items.map((item) =>
                          ListTile(
                            onTap: () {
                              cart.removeItem(item);
                              setState(() {});
                            },
                            leading: Image.network(
                              fit: BoxFit.fill,
                              '${ApiHandler.baseURl}public/images/${item['item']['image']['filename']}',
                            ),
                            title:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item['item']['name']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                                item['type'] == 'service'
                                    ? Text('\$${item['item']['fee']}', style: const TextStyle(fontSize: 12))
                                    : Text('\$${item['item']['price']}', style: const TextStyle(fontSize: 12)),
                      ],
                            ),

                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item['type'], style: const TextStyle(fontSize: 12)),
                                Text('qty: ${item['quantity']}', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                      ),
                    ).toList(),

                  );
                }
              },
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ApiHandler()
              .createOrder(cart.format())
              .then((value) {
                  context.router.navigate(const AccountRoute());
                  cart.reset();
                });


          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Payment Successful'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
        },
        child: Consumer<CartProvider>(
          builder: (BuildContext context, provider, widget) {
            if(provider.items.isEmpty) return Container(height: 10);
            return Container(
              color: Colors.blueGrey,
              alignment: Alignment.center,
              height: 50.0,
              child: Text(
                'Proceed to Pay: \$${cart.getTotal()}',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        )
      ),
    );
  }
}
