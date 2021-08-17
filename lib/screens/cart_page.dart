import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Start.dart';
import 'package:login_page/screens/home_page.dart';
import 'package:login_page/screens/product_page.dart';
import 'package:login_page/services/firebase_services.dart';
import 'package:login_page/tabs/home_tab.dart';
import 'package:login_page/widgets/custom_action_bar.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");
  // ignore: non_constant_identifier_names
  num price_total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 128.0,
                    bottom: 200.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productId: document.id,
                              ),
                            ));
                      },
                      child: FutureBuilder(
                        future: _firebaseServices.productsRef
                            .doc(document.id)
                            .get(),
                        builder: (context, productSnap) {
                          if (productSnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${productSnap.error}"),
                              ),
                            );
                          }

                          if (productSnap.connectionState ==
                              ConnectionState.done) {
                            Map _productMap =
                                (productSnap.data as dynamic).data();
                            price_total += _productMap['Price'];
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                child: Dismissible(
                                    key: Key(document.id),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "${_productMap['Image'][0]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${_productMap['Name']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                ),
                                                child: Text(
                                                  "\$${_productMap['Price']}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                "Size - ${(document.data() as dynamic)['Size']}",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    onDismissed: (DismissDirection direction) {
                                      setState(() {});
                                    }));
                          }

                          return Container(
                            child: Center(
                              child: Lottie.asset(
                                'assets/loading.json',
                                repeat: true,
                                reverse: true,
                                animate: true,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Container(
                alignment: Alignment.center,
                child: Lottie.asset(
                  'assets/loading.json',
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),
              );
            },
          ),
          StreamBuilder<Object>(
              stream: _usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Cart")
                  .snapshots(),
              builder: (context, snapshot) {
                int _totalItems = 0;

                if (snapshot.connectionState == ConnectionState.active) {
                  List _documents = (snapshot.data! as QuerySnapshot).docs;
                  _totalItems = _documents.length;
                }
                {
                  return Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 500, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.amber[100]),
                          height: 200,
                          width: 900,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              Text(
                                "Items :  $_totalItems",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                              ),
                              Text(
                                "Price : \$$price_total",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage(),
                                      ));
                                },
                                child: Text('Check Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                color: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
          CustomActionBar(
            hasBackArrrow: false,
            title: "Cart",
            hasTitle: true,
            hasBackground: true,
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePagee()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                child: Text("Thanks for Shopping with us !!",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))),
            Flexible(
              child: SizedBox(
                  height: 600,
                  width: 500,
                  child: Lottie.asset('assets/shop.json')),
            ),
          ],
        ),
      ),
    );
  }
}
