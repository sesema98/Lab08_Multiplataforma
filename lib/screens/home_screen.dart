import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_theme.dart';
import '../models/product.dart';
import '../routes.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      showBack: false,
      title: 'Menu',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _UserHeader(username: username),
          const SizedBox(height: 22),
          _MenuCard(
            title: 'Registrar producto',
            subtitle: 'Nuevo producto',
            icon: Icons.add_box_outlined,
            color: PptTheme.accentOrange,
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.registerProduct),
          ),
          const SizedBox(height: 14),
          _MenuCard(
            title: 'Lista de productos',
            subtitle: 'Inventario',
            icon: Icons.list_alt_rounded,
            color: PptTheme.green,
            onTap: () => Navigator.pushNamed(context, AppRoutes.productList),
          ),
          const SizedBox(height: 14),
          _MenuCard(
            title: 'Perfil',
            subtitle: 'Datos personales',
            icon: Icons.person_outline_rounded,
            color: PptTheme.skyBlue,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.profile,
              arguments: username,
            ),
          ),
          const SizedBox(height: 14),
          _MenuCard(
            title: 'Salir',
            subtitle: 'Cerrar sesion',
            icon: Icons.logout_rounded,
            color: PptTheme.primaryBlue,
            onTap: () => Navigator.pushNamed(context, AppRoutes.logout),
          ),
        ],
      ),
    );
  }
}

class ProductRegisterScreen extends StatefulWidget {
  const ProductRegisterScreen({super.key, required this.onProductCreated});

  final ValueChanged<Product> onProductCreated;

  @override
  State<ProductRegisterScreen> createState() => _ProductRegisterScreenState();
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final product = Product(
      brand: _brandController.text.trim(),
      name: _nameController.text.trim(),
      category: _categoryController.text.trim(),
      price: double.parse(_priceController.text.replaceAll(',', '.')),
      stock: int.parse(_stockController.text),
    );

    widget.onProductCreated(product);
    Navigator.pushReplacementNamed(context, AppRoutes.productList);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Registro',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _PageIntro(
            icon: Icons.add_box_outlined,
            title: 'Registro de productos',
            color: PptTheme.accentOrange,
          ),
          const SizedBox(height: 18),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _ProductField(
                  controller: _brandController,
                  label: 'Marca',
                  icon: Icons.sell_outlined,
                  validator: _required('Ingrese la marca'),
                ),
                const SizedBox(height: 14),
                _ProductField(
                  controller: _nameController,
                  label: 'Nombre del producto',
                  icon: Icons.inventory_2_outlined,
                  validator: _required('Ingrese el nombre'),
                ),
                const SizedBox(height: 14),
                _ProductField(
                  controller: _categoryController,
                  label: 'Categoria',
                  icon: Icons.category_outlined,
                  validator: _required('Ingrese la categoria'),
                ),
                const SizedBox(height: 14),
                _ProductField(
                  controller: _priceController,
                  label: 'Precio',
                  icon: Icons.payments_outlined,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  validator: _priceValidator,
                ),
                const SizedBox(height: 14),
                _ProductField(
                  controller: _stockController,
                  label: 'Stock',
                  icon: Icons.numbers_rounded,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _stockValidator,
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saveProduct,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FormFieldValidator<String> _required(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    };
  }

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingrese el precio';
    }

    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return 'Precio invalido';
    }

    return null;
  }

  String? _stockValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingrese el stock';
    }

    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 0) {
      return 'Stock invalido';
    }

    return null;
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Productos',
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFEAF1FC),
                child: Text(
                  product.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: PptTheme.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                '${product.brand} - ${product.category} - Stock: ${product.stock}',
              ),
              trailing: Text(
                product.priceLabel,
                style: const TextStyle(
                  color: PptTheme.accentOrange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Perfil',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _PageIntro(
            icon: Icons.person_outline_rounded,
            title: 'Perfil',
            color: PptTheme.skyBlue,
          ),
          const SizedBox(height: 18),
          const _LabelValue(label: 'Nombres', value: 'Sergio Sebastian'),
          const SizedBox(height: 12),
          const _LabelValue(label: 'Apellidos', value: 'Torres Rivas'),
          const SizedBox(height: 12),
          const _LabelValue(label: 'Fecha de nacimiento', value: '15/08/2002'),
          const SizedBox(height: 12),
          _LabelValue(label: 'Email', value: username),
        ],
      ),
    );
  }
}

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Salir',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _PageIntro(
            icon: Icons.logout_rounded,
            title: 'Cerrar sesion',
            color: PptTheme.primaryBlue,
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Desea salir de la aplicacion?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => _logout(context),
                          child: const Text('Salir'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.title,
    required this.child,
    this.showBack = true,
  });

  final String title;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 20, 8),
              child: Row(
                children: [
                  if (showBack)
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PptTheme.primaryBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_rounded, color: PptTheme.primaryBlue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: color.withAlpha(28),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Color(0xFF657083)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageIntro extends StatelessWidget {
  const _PageIntro({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withAlpha(28),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _ProductField extends StatelessWidget {
  const _ProductField({
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    );
  }
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: PptTheme.primaryBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 17)),
          ],
        ),
      ),
    );
  }
}
