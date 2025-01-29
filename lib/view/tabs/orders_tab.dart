import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/tabs/home_tab/search.dart';
import 'package:tever/view/widgets/tabs/deals_tab/trending.dart';
import 'package:tever/view/widgets/tabs/deals_tab/filter.dart';
import 'package:tever/view/widgets/tabs/orders_tab/cart_items.dart';
import 'package:tever/view/widgets/tabs/orders_tab/top_tab.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final CustomColors _customColor = const CustomColors();

  bool applyFilter = false;

  void _toggleShowFilter() {
    setState(() {
      applyFilter = !applyFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
      child: Column(
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TopTab(),
            ],
          ),
          const CartItems(),
          const SizedBox(height: 8),
          // CartSummary(),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: _customColor.customDCDCDC,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
