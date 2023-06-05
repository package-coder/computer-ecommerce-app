import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:mobile_app/services/api_handler.dart';
import 'package:provider/provider.dart';

import '../components/loader.dart';
import '../providers/cart.dart';

class ServiceTab extends StatefulWidget {
  const ServiceTab({super.key});

  @override
  State<ServiceTab> createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return FutureBuilder<List>(
      future: ApiHandler().serviceListFetch(),
      builder: (context, snapshot) {
        final services = snapshot.data?.where((element) => element['enable']).toList() ?? [];

        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        if(services.isEmpty) {
          return const Center(
            child: Text('Service list is empty'),
          );
        }

        return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final item = services[index];
              if(!item['enable']) {
                return null;
              }
              return Card(
                child: ListTile(
                  leading: Image.network(
                    fit: BoxFit.fill,
                    '${ApiHandler.baseURl}public/images/${item['image']['filename']}',
                  ),
                  title:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['name']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      Text('\$${item['fee']}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),

                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['description'], style: const TextStyle(fontSize: 12)),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('add'),
                        onPressed: () {
                          cart.addItem(item, 'service');
                        } ,
                      )
                    ],
                  ),
                ),
              );
            },
            );
      },
    );
  }
}
