import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'models/product.dart';
import 'routes.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const InventoryApp());
}

class InventoryApp extends StatefulWidget {
  const InventoryApp({super.key});

  @override
  State<InventoryApp> createState() => _InventoryAppState();
}

class _InventoryAppState extends State<InventoryApp> {
  final List<Product> _products = [
    const Product(
      brand: 'Lenovo',
      name: 'Laptop',
      category: 'Tecnologia',
      price: 2450,
      stock: 7,
    ),
    const Product(
      brand: 'Logitech',
      name: 'Mouse',
      category: 'Accesorios',
      price: 65.9,
      stock: 18,
    ),
    const Product(
      brand: 'Norma',
      name: 'Agenda',
      category: 'Oficina',
      price: 32.5,
      stock: 11,
    ),
  ];

  void _addProduct(Product product) {
    setState(() {
      _products.insert(0, product);
    });
  }

  String _usernameFrom(Object? value) {
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return 'Usuario';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario',
      debugShowCheckedModeBanner: false,
      theme: PptTheme.buildTheme(),
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.menu:
            return MaterialPageRoute<void>(
              builder: (_) =>
                  MenuScreen(username: _usernameFrom(settings.arguments)),
            );
          case AppRoutes.registerProduct:
            return MaterialPageRoute<void>(
              builder: (_) =>
                  ProductRegisterScreen(onProductCreated: _addProduct),
            );
          case AppRoutes.productList:
            return MaterialPageRoute<void>(
              builder: (_) => ProductListScreen(products: _products),
            );
          case AppRoutes.profile:
            return MaterialPageRoute<void>(
              builder: (_) =>
                  ProfileScreen(username: _usernameFrom(settings.arguments)),
            );
          case AppRoutes.logout:
            return MaterialPageRoute<void>(
              builder: (_) => const LogoutScreen(),
            );
          case AppRoutes.login:
          default:
            return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}
