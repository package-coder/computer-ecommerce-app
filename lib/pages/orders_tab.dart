import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/loader.dart';
import '../providers/cart.dart';
import '../services/api_handler.dart';

class OrderTab extends StatefulWidget { const OrderTab({
  Key? key,
}) : super(key: key);

@override
State<OrderTab> createState() => _OrderTabState();
}
class _OrderTabState extends State<OrderTab> {

  String clipStatus(int index) {
    switch(index) {
      case 0: return 'CANCELLED';
      case 1: return 'COMPLETED';
      case 2: return 'PENDING';
      case 3: return 'TO_REVIEW';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {

    return  FutureBuilder<List>(
        future: ApiHandler().orderListFetch('PENDING'),
        builder: (context, snapshot) {
          final orders = snapshot.data ?? [];
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if(orders.isEmpty) {
            return const Center(
              child: Text('Order history is empty'),
            );
          }

          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: snapshot.data!.map((item) =>
                  ListTile(
                    title:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order ${item['orderId']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                        Text(clipStatus(item['status']), style: const TextStyle(
                            fontSize: 12, color: Colors.blueGrey
                        )),

                      ],
                    ),

                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('EEEE, MMMM d').format(DateTime.parse(item['createdAt'])), style: const TextStyle(fontSize: 12)),
                        Text('\$${item['totalPrice']}', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
              ),
            ).toList(),

          );
        },
      );
  }
}
