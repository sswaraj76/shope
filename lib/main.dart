import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './provider/products.dart';
import './provider/cart_item.dart';
import './provider/orders.dart';
import './screen/product_overview_screen.dart';
import './screen/product_details_screen.dart';
import './screen/cart_screen.dart';
import './screen/orders_screen.dart';
import './screen/edit_product_screen.dart';
import './screen/user_product_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shope',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.latoTextTheme(),
          appBarTheme: const AppBarTheme(
            color: Color(0xff6A2C70),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xffB83B5E),
          ),
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routName: (context) =>
              const ProductDetailsScreen(),
          CartScreen.routName: (context) => const CartScreen(),
          OrdersScreen.routName: (context) => const OrdersScreen(),
          UserProductItem.routName: (context) => const UserProductItem(),
          EditProductScreen.routName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
