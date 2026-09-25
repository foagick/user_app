import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/counter_bloc.dart';
import 'package:user_app/data/categories.dart';
import 'package:user_app/data/market_store.dart';
import 'package:user_app/models/product.dart';
import 'package:user_app/screens/productDetailScreen.dart';
import 'package:user_app/screens/productFormScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _openDetailScreen({required String productId}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Productdetailscreen(productId: productId),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Badge(label: Text('3'), child: Icon(Icons.shopping_cart)),
          ),
        ],
        title: Text('User App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: MarketStore.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (BuildContext context, int index) {
            final product = MarketStore.products[index];
            final productIcon = iconForCategory(product.category);
            final productColor = colorForCategory(product.category);

            return GestureDetector(
              onTap: () => _openDetailScreen(productId: product.id),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(
                            0,
                            142,
                            224,
                            224,
                          ).withValues(alpha: 0.5),
                        ),
                        child: Icon(
                          // iconForCategory(product.category),
                          productIcon,
                          size: 34,
                          // color: Colors.red,
                          // color: colorForCategory(product.category),
                          color: productColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight(700)),
                    ),
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight(700)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductFormScreen(productId: null),
            ),
          );
          if (mounted) setState(() {});
        },
      ),
    );
  }
}