import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/orders_tab.dart';
import 'package:mobile_app/routes/router.gr.dart';
import 'package:mobile_app/services/api_handler.dart';

import '../components/loader.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: ApiHandler().getSession(),
        builder: (context, snapshot) {
          final session = snapshot.data?['user'];
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          return DefaultTabController(
              length: 3,
              child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(right: 14),
                              child: const CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${session['firstName']} ${session['lastName']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${session['email']}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: Container(
                          color: Colors.black.withOpacity(0.01),
                          child: const Column(
                            children: [
                              // TabBar(
                              //   tabs: <Widget>[
                              //     Padding(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text('Pending', style: TextStyle(color: Colors.blue)),
                              //     ),
                              //     Padding(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text('To Review', style: TextStyle(color: Colors.blue)),
                              //     ),
                              //     Padding(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text('Completed', style: TextStyle(color: Colors.blue)),
                              //     ),
                              //   ],
                              // ),
                              Divider(height: 1),
                              Expanded(child: OrderTab())

                              // Expanded(child: TabBarView(children: [
                              //   OrderTab(),
                              //   OrderTab(),
                              //   OrderTab(),
                              // ])),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              )
          );
        },
      ),
      bottomNavigationBar: InkWell(
          onTap: () {
            ApiHandler()
                .logout()
                .then((value){
                  if(value) {
                    context.router.navigate(const LoginRoute());
                  }
                });
          },
          child: Container(
            color: Colors.blueGrey,
            alignment: Alignment.center,
            height: 50.0,
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          )
      );
  }
}

class CustomerDetailCard extends StatelessWidget {
  const CustomerDetailCard(
      {super.key, required this.attribute, required this.data});

  final String attribute;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.black,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              attribute,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(data),
          ],
        ),
      ),
    );
  }
}
