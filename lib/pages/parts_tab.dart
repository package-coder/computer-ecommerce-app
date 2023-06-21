import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_handler.dart';
import 'package:provider/provider.dart';

import '../components/loader.dart';
import '../providers/cart.dart';

class PartsTab extends StatefulWidget {
  final String? view;
  const PartsTab({super.key, this.view});

  @override
  State<PartsTab> createState() => _PartsTabState();
}

class _PartsTabState extends State<PartsTab> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return FutureBuilder<List>(
      future: widget.view == 'list_view'
          ? ApiHandler().productListFetch()
          : ApiHandler().shopProductListFetch(),
      builder: (context, snapshot) {
        final products =
            snapshot.data?.where((element) => element['enable']).toList() ?? [];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (products.isEmpty) {
          return const Center(
            child: Text('Product list is empty'),
          );
        }

        if (widget.view == 'list_view') {
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: snapshot.data!.map(
                (item) => ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['name']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(item['enable'] ? 'Available' : 'Not Available',
                          style: TextStyle(
                              fontSize: 12,
                              color: item['enable']
                                  ? Colors.blueGrey
                                  : Colors.redAccent)),
                    ],
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['description']}',
                          style: const TextStyle(fontSize: 12)),
                      Text('\$${item['price']}',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ).toList(),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final item = products[index];

            if (!item['enable']) {
              return null;
            }

            return Card(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: Image.network(
                        '${ApiHandler.baseURl}public/images/${item['image']['filename']}',
                      ).image,
                      fit: BoxFit.cover,
                    )),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item['name']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text('\$${item['price']}',
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item['description'],
                                  style: const TextStyle(fontSize: 12)),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('add'),
                                onPressed: () {
                                  cart.addItem(item, 'product');
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
