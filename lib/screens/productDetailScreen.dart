import 'package:flutter/material.dart';
import 'package:user_app/data/market_store.dart';

class Productdetailscreen extends StatefulWidget {
  String ProductId;
   new({super.key, required this.ProductId});

  @override
  State<Productdetailscreen> createState() => _ProductdetailscreenState();
}

class _ProductdetailscreenState extends State<Productdetailscreen> {


  _deleteProduct(BuildContext context, String productId) async{
   final  shouldDelete = await showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Delete, Product ?"),
      content: Text("This product will be remvoed"),
      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel")),
        TextButton(onPressed: (){Navigator.pop(context, true);}, child: Text("Delete")),
      ],
    ));
    if (shouldDelete != true) return;
    MarketStore.deleteProduct(productId);
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    // final product = MarketStore.findProduct(widget.ProductId);
    return Scaffold(
      appBar: AppBar(
        // title: Text(product.title),
        actions: [
          IconButton(onPressed: (){},icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete),),
        ],
      ),
    );
  }
}