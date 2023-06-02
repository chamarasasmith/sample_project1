import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screens/users_page.dart';
import 'package:badges/badges.dart' as badges;
import 'models/counter.dart';
import 'screens/products_page.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Counter()),
          ],
          child:const MyApp())
      );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
          title: Text(widget.title),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  icon: Icon(Icons.list,color: Colors.white,)
              ),
              Tab(
                  icon: Icon(Icons.supervisor_account,color: Colors.white,),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: badges.Badge(
                badgeContent: Consumer(
                  builder: (BuildContext context,Counter value,Widget? child){
                    return Text('${value.count}',style: const TextStyle(color: Colors.white),);
                  },
                ),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.black),
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart,color: Colors.white,)),
              ),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            ProductsPage(),
            UsersPage(),
          ],
        ),
      ),
    );
  }
}
