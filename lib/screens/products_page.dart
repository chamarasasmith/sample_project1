import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sample_project1/models/counter.dart';
import 'package:sample_project1/models/products.dart';
import 'package:sample_project1/screens/product_details.dart';

import '../models/users.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  Future<List<Product>> getProducts() async{
    var url=Uri.parse("https://fakestoreapi.com/products");
    List<Product> productList=[];
    try{
      var response=await http.get(url);
      if(response.statusCode==200){
        List products=jsonDecode(response.body);

        for(var item in products){

          int id=item['id'];
          String title=item['title'];
          double? price= double.tryParse(item['price']!.toString());
          String image= item['image'];
          String description= item['description'];

          Product product=Product(id,title,price,image,description);
          productList.add(product);
        }
      }else{
        return Future.error("Something went wrong..!");
      }
    }catch(e)
    {
      return Future.error(e.toString());
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getProducts(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index].image),
                    ),
                    title: Text(snapshot.data[index].title),
                    subtitle: Text('${snapshot.data[index].price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: (){
                        context.read<Counter>().increment();
                      },
                    ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>ProductDetails(snapshot.data[index]))
                      );
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
