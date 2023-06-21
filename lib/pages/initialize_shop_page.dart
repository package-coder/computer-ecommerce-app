


import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/pages/orders_completed_tab.dart';
import 'package:mobile_app/pages/parts_tab.dart';
import 'package:mobile_app/pages/service_tab.dart';

import '../components/loader.dart';
import '../services/api_handler.dart';

class InitShopPage extends StatefulWidget {
  const InitShopPage({Key? key}) : super(key: key);

  @override
  State<InitShopPage> createState() => _InitShopPageState();
}

class _InitShopPageState extends State<InitShopPage> with TickerProviderStateMixin{

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();

  Future getImage() async {
    var img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() => _image = img);
  }

  @override
  void initState() {
    super.initState();
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final file = File(_image!.path);
    ApiHandler().createShop(FormData.fromMap(
        {
          'name': _name.text,
          'image': await MultipartFile.fromFile(
            file.path,
            filename: _image!.name,
            contentType: MediaType('application', getFileType(_image!.name) ?? 'jpeg')
          ),
        }
    )).then((value) => setState(() {}));
    return;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      builder: (context, snapshot) {
        final shop = snapshot.data;
        final shopNotFound = shop == null;

        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        return DefaultTabController(
            length: 3,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => context.router.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  title: Text(shopNotFound ? 'Create Shop' : 'Shop Management'),
                ),
                body: shopNotFound
                    ? Form(
                    key: _formKey,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: 32.0),
                            Container(
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade100,
                                  border: Border.all(
                                      color: Colors.grey.shade300
                                  )
                              ),
                              clipBehavior: Clip.hardEdge,
                              height: 150,
                              child: _image != null ? Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ) : null,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    child: Text(_image != null ? 'Change Photo' : 'Upload Photo')
                                ),
                              ],
                            ),
                            const SizedBox(height: 32.0),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      validator: (value) {
                                        if (!(value == null || value.isEmpty)) {
                                          return null;
                                        }
                                        return 'This field is required';
                                      },
                                      autofocus: true,
                                      keyboardType: TextInputType.name,
                                      controller: _name,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                    )
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            margin: const EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Image.network(
                                      '${ApiHandler.baseURl}public/images/${shop['image']['filename']}',
                                    ).image,
                                    fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(style: BorderStyle.solid, color: Colors.grey.shade300, width: 1)
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${shop['name']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                "Your shop can be manage in web",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.03),
                        child: const Column(
                          children: [
                            TabBar(
                              tabs: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text('Parts', style: TextStyle(color: Colors.black45)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text('Services', style: TextStyle(color: Colors.black45)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text('Orders', style: TextStyle(color: Colors.black45)),
                                ),
                              ],
                            ),
                            Expanded(
                                child: TabBarView(
                                  children: [
                                    PartsTab(view: 'list_view'),
                                    ServiceTab(view: 'list_view'),
                                    OrderTab(view: 'list_view')
                                  ],
                                )
                            )
                          ],
                        )
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: shopNotFound ? InkWell(
                    onTap: _onSubmit,
                    child:  Container(
                      color: Colors.blueGrey,
                      alignment: Alignment.center,
                      height: 50.0,
                      child: const Text(
                        'Create shop',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ) : null
            )
        );
      },
      initialData: [],
      future: ApiHandler().getShopDetail(),
    );
  }
}

String? getFileType(String filePath) {
  const pattern = r'\.([a-zA-Z0-9]+)$';
  final regex = RegExp(pattern);
  final matches = regex.allMatches(filePath);
  final match = matches.isNotEmpty ? matches.first : null;

  return match?.group(1);
}