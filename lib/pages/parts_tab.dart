import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_handler.dart';
import 'package:provider/provider.dart';

import '../components/loader.dart';
import '../providers/cart.dart';

class PartsTab extends StatefulWidget {
  const PartsTab({super.key});

  @override
  State<PartsTab> createState() => _PartsTabState();
}

class _PartsTabState extends State<PartsTab> {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return FutureBuilder<List>(
      future: ApiHandler().productListFetch(),
      builder: (context, snapshot) {
        final products = snapshot.data?.where((element) => element['enable']).toList() ?? [];

        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if(products.isEmpty) {
          return const Center(
            child: Text('Product list is empty'),
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

            if(!item['enable']) {
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
                            )
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item['name']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            Text('\$${item['price']}', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Row(
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
                                  cart.addItem(item, 'product');
                                } ,
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
        // return ListView(
        //     children: ListTile.divideTiles(
        //       context: context,
        //       tiles: snapshot.data!.map((item) =>
        //         Card(
        //           child: ListTile(
        //             isThreeLine: true,
        //             dense: true,
        //             onTap: () { },
        //             leading: Image.network(
        //               fit: BoxFit.fill,
        //               '${ApiHandler.baseURl}public/images/${item['image']['filename']}',
        //             ),
        //             title: Text('${item['name']}',
        //                 style: const TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.bold,
        //                 )),
        //             subtitle: Container(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text('\$${item['price']}'),
        //                   Text(item['description'])
        //                 ],
        //               ),
        //             ),
        //             trailing: IconButton(
        //               icon: const Icon(Icons.add_shopping_cart),
        //               onPressed: () {  },
        //             ),
        //           ),
        //         )
        //       ),
        //     ).toList(),
        //     // children: snapshot.data!.map((item) {
        //     //   print('item $item');
        //     //
        //     //   return (
        //     //       SizedBox(
        //     //     height: 100,
        //     //     child: Row(
        //     //       children: [
        //     //         Container(
        //     //           width: 130,
        //     //           decoration: BoxDecoration(
        //     //               color: Colors.black12,
        //     //               image: DecorationImage(
        //     //                 image: Image.network(
        //     //                   fit: BoxFit.fill,
        //     //                   '${ApiHandler.baseURl}public/images/${item['image']['filename']}',
        //     //                 ).image,
        //     //               )
        //     //           ),
        //     //         ),
        //     //         Expanded(
        //     //             child: Container(
        //     //               color: Colors.black12,
        //     //               child: Padding(
        //     //                 padding: const EdgeInsets.all(16),
        //     //                 child: Column(
        //     //                   crossAxisAlignment: CrossAxisAlignment.start,
        //     //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     //                   children: [
        //     //                     Row(
        //     //                       crossAxisAlignment: CrossAxisAlignment.center,
        //     //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //                       children: [
        //     //                         Text('${item['name']}',
        //     //                             style: const TextStyle(
        //     //                               fontSize: 18,
        //     //                               fontWeight: FontWeight.bold,
        //     //                             )),
        //     //                         Text('\$${item['price']}'),
        //     //                       ],
        //     //                     ),
        //     //                     Text(item['description'])
        //     //                   ],
        //     //                 ),
        //     //               ),
        //     //             ))
        //     //       ],
        //     //     ),
        //     //   )
        //     //   );
        //     // }
        //
        //     );
      },
    );
  }
}
