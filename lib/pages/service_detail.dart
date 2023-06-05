import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:mobile_app/services/api_handler.dart';

class ServiceDetailPage extends StatefulWidget {
  const ServiceDetailPage({super.key, required this.serviceId});

  final int serviceId;

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetailPage> {
  late Future<Map> serviceDetail;

  @override
  void initState() {
    serviceDetail = ApiHandler().serviceDetailFetch(widget.serviceId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: FutureBuilder<Map>(
          future: serviceDetail,
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
                        Icons.troubleshoot_outlined,
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
                      ApiHandler()
                          .serviceBook(widget.serviceId, 1)
                          .then((value) => _showMyDialog(context));
                    },
                    child: const Text('Book'),
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
        title: const Text('Booking successful!'),
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
