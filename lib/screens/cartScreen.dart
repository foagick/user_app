import 'package:flutter/material.dart';
import 'package:user_app/data/categories.dart';
import 'package:user_app/data/market_store.dart';

class Cartscreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {

  void _removeItem (String productId) {
    setState(() {
      MarketStore.removeFromCart(productId);
    });
  }

  Future<void> _checkOut () async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Thank You !!!'),
        content: Text('Your Order of \$${MarketStore.cartTotal} was Placed.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), 
          child: Text('Ok'))
        ],
      ));

      if(!mounted) return;

      setState(() {
        MarketStore.clearCart();
      });
  }

  @override
  Widget build(BuildContext context) {
    final items = MarketStore.cart;
    final total = MarketStore.cartTotal;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart ${MarketStore.cartCount.toString()}', 
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        bottom: PreferredSize(preferredSize: Size.fromHeight(1), 
        child: Divider(height: 1,)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => Divider(height: 1,),
              itemBuilder: (context, index) {
                final item = items[index];
                final color = colorForCategory(item.product.category);
                final icon = iconForCategory(item.product.category);
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
                title: Text(item.product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                subtitle: Text('\$${item.product.price.toString()}', 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                trailing: FittedBox(
                  child: Row(
                    children: [
                    Text(item.quantity.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),),
                    SizedBox(width: 15,),
                      IconButton(
                        onPressed: () => _removeItem(item.product.id), 
                        icon: Icon(Icons.delete,color: Colors.grey,)),
                    ],
                  ),
                ),
              );
            },),
          ),
          Divider(height: 1,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 16, color: Colors.grey),),
                    Text("\$$total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 12,),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: OutlinedButton(onPressed: _checkOut, 
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                  ),
                  child: Text('Chechout',style: TextStyle(fontSize: 16),)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}