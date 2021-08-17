import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_page/widgets/custom_action_bar.dart';
import 'package:login_page/widgets/product_cart.dart';
import 'package:lottie/lottie.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
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
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                        child: ProductCard(
                      title: (document.data() as dynamic)['Name'],
                      imageUrl: (document.data() as dynamic)['Image'][0],
                      price: "\$${(document.data() as dynamic)['Price']}",
                      productId: document.id,
                      onPressed: () {},
                    ));
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
          CustomActionBar(
            title: "Home",
            hasTitle: true,
            hasBackground: true,
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
