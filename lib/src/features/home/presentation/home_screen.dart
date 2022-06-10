import 'package:arms/src/features/authentication/presentation/account/account_page.dart';
import 'package:arms/src/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../cart/presentation/shopping_cart/shopping_cart_page.dart';

const pages = [
  HomePage(),
  ShoppingCartPage(),
  AccountPage(),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: _items(selectedIndex),
        onTap: (index) => setState(() => selectedIndex = index),
      ),
    );
  }
}

List<BottomNavigationBarItem> _items(int selectedIndex) {
  return List.generate(itemData.length, (index) {
    final icon = selectedIndex == index
        ? itemData[index]['fillIcon']
        : itemData[index]['icon'];
    final label = itemData[index]['label'];

    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  });
}

const itemData = <Map<String, dynamic>>[
  {
    'icon': XIcons.homeOutline,
    'fillIcon': XIcons.home,
    'label': 'Home',
  },
  {
    'icon': XIcons.cartOutline,
    'fillIcon': XIcons.cart,
    'label': 'Cart',
  },
  {
    'icon': XIcons.userOutline,
    'fillIcon': XIcons.user,
    'label': 'Account',
  },
];
