import 'package:flutter/material.dart';
import 'package:user_app/data/categories.dart';
import 'package:user_app/data/market_store.dart';
import 'package:user_app/screens/productFormScreen.dart';

class Productdetailscreen extends StatefulWidget {
  final String productId;
  const Productdetailscreen({super.key, required this.productId});

  @override
  State<Productdetailscreen> createState() => _ProductdetailscreenState();
}

class _ProductdetailscreenState extends State<Productdetailscreen> {
  int quantity = 1;

  void _addToCart() {
    final product = MarketStore.findProduct(widget.productId);
    if (product == null) return;

    MarketStore.addToCart(product, quantity);
  }

  void _editProduct({required String productId}) async {
    // context.push('/product/${widget.productId}/edit');
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductFormScreen(productId: MarketStore.findProduct(productId)),
      ),
    );

    setState(() {
      
    });
  }

  Future<void> _deleteProduct() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete product?'),
        content: const Text('This product will be removed from the market.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;
    if (!mounted) return;

    MarketStore.deleteProduct(widget.productId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final product = MarketStore.findProduct(widget.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product!.title),
        actions: [
          IconButton(
            onPressed: () => _editProduct(productId: product.id),
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: _deleteProduct,
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              iconForCategory(product.category),
              size: 80,
              color: colorForCategory(product.category),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  product.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Text(
                  'Qty',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.remove, size: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text(
                      '$quantity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _addToCart();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Added to cart!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
