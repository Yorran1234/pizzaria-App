import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/orders_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizzaria App',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/login', // Define a rota inicial como LoginScreen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/orders': (context) => OrdersScreen(),
      },
    );
  }
}
