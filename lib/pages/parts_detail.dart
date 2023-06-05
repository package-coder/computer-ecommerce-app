import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:mobile_app/services/api_handler.dart';

class PartsDetailPage extends StatefulWidget {
  const PartsDetailPage({super.key, required this.productId});

  final int productId;

  @override
  State<PartsDetailPage> createState() => _PartsDetailState();
}

class _PartsDetailState extends State<PartsDetailPage> {
  late Future<Map> productDetail;

  @override
  void initState() {
    productDetail = ApiHandler().productDetailFetch(widget.productId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: FutureBuilder<Map>(
          future: productDetail,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            var data = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const Icon(
                        Icons.question_mark_sharp,
                        size: 100,
                      ),
                      Text(
                        data['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(data['details']),
                    ],
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      ApiHandler().productOrder(widget.productId).then(
                            (value) => _showMyDialog(context),
                          );
                    },
                    child: const Text('Order'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Order successful!'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yay!'),
            onPressed: () {
              context.router.replace(const HomeRoute());
            },
          ),
        ],
      );
    },
  );
}
