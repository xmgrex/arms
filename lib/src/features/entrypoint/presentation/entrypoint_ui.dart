import 'package:animations/animations.dart';
import 'package:arms/src/features/authentication/presentation/account/account_page.dart';
import 'package:arms/src/features/home/presentation/home_page.dart';
import 'package:arms/src/features/order/presentation/orders_list_page.dart';
import 'package:arms/src/utils/super_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../generated/l10n.dart';
import '../../../utils/size_config.dart';
import '../../cart/presentation/shopping_cart/shopping_cart_page.dart';
import '../../top_level_providers.dart';

List<Map<String, dynamic>> _itemData(BuildContext context) {
  return [
    {
      'icon': SuperIcons.home,
      'fillIcon': SuperBoldIcons.home,
      'label': S.of(context).home,
    },
    {
      'icon': XIcons.cartOutline,
      'fillIcon': XIcons.cart,
      'label': S.of(context).cart,
    },
    {
      'icon': SuperIcons.paper,
      'fillIcon': SuperBoldIcons.paper,
      'label': S.of(context).order,
    },
    {
      'icon': SuperIcons.profile,
      'fillIcon': SuperBoldIcons.profile,
      'label': S.of(context).account,
    },
  ];
}

class EntryPointUI extends ConsumerStatefulWidget {
  const EntryPointUI({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EntryPointUIState();
}

class _EntryPointUIState extends ConsumerState<EntryPointUI> {
  _handlePageSelection(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  int _currentPage = 0;

  final _pages = const <Widget>[
    HomePage(),
    ShoppingCartPage(),
    OrdersListPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final itemData = _itemData(context);
    return Scaffold(
      body: AnimatedIndexedStack(index: _currentPage, children: _pages),
      // IndexedStack(index: _currentPage, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        items: [
          ...List.generate(
            itemData.length,
            (index) {
              final icon = itemData[index]['icon'];
              final fillIcon = itemData[index]['fillIcon'];
              final label = itemData[index]['label'];
              return BottomNavigationBarItem(
                icon: Icon(index == _currentPage ? fillIcon : icon),
                label: label,
              );
            },
          ),
        ],
        onTap: _handlePageSelection,
      ),
    );
  }
}

class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const AnimatedIndexedStack({
    Key? key,
    required this.index,
    required this.children,
  }) : super(key: key);

  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _index;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _index = widget.index;
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != _index) {
      _controller.reverse().then((_) {
        setState(() => _index = widget.index);
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Transform.scale(
            scale: 1.015 - (_controller.value * 0.015),
            child: child,
          ),
        );
      },
      child: IndexedStack(
        index: _index,
        children: widget.children,
      ),
    );
  }
}
