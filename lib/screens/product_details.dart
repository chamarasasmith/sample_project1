
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/counter.dart';
import '../models/products.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(product.image),
                radius: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(product.title,style: const TextStyle(fontSize: 20),textWidthBasis: TextWidthBasis.longestLine,textAlign: TextAlign.center,),
              const SizedBox(
                height: 20,
              ),
              Text('Description : ${product.description}',textWidthBasis: TextWidthBasis.longestLine ,style: const TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              const SizedBox(
                height: 20,
              ),
              Text('Price : ${product.price}',textWidthBasis: TextWidthBasis.longestLine ,style: const TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              ElevatedButton(onPressed: (){
                context.read<Counter>().increment();
              }, child: const Text("Add to Cart"))
            ],
          ),
        ),
      ),
    );
  }
}
