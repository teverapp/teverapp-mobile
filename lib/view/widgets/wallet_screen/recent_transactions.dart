import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/empty_state.dart';
import 'package:tever/view/widgets/wallet_screen/receipt_bottom_sheet.dart';
import 'package:tever/view/widgets/wallet_screen/transaction_details_bottom_sheet.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  final CustomColors _customColor = const CustomColors();

  void _receiptBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const ReceiptBottomSheet();
      },
    );
  }

  void _transactionDetailstBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return const TransactionDetailsBottomSheet();
      },
    );
  }

  Widget _buildCard({
    required String icon,
    required ThemeData theme,
    required String title,
    required String subTitle,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: _customColor.customEFEFEF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: "₦ ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: _customColor.custom888888),
                    ),
                    TextSpan(
                      text: subTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: _customColor.custom242424),
                    ),
                  ],
                  style: TextStyle(
                      color: _customColor.custom4F4F4F,
                      fontSize: 14,
                      height: 1.3,
                      fontFamily: 'Inter')),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  "assets/icon/$icon",
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Since last month",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: _customColor.custom292929),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: _customColor.customEFEFEF))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "25/10/2024; 06:46pm",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _customColor.custom4F4F4F),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: _customColor.customD2F9E7,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "Successful",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _customColor.custom08745B),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment on {Gateway}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom4F4F4F),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "{Transaction ID}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom888888),
                  )
                ],
              ),
              Text(
                "₦7.50",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom4F4F4F),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "{Narration}",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _customColor.custom4F4F4F),
              ),
              GestureDetector(
                  onTap: () => _receiptBottomSheet(context),
                  child: Image.asset(
                    "assets/icon/angle_right_gray.png",
                    height: 20,
                    width: 20,
                  ))
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(children: [
      const SizedBox(height: 27),
      Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildCard(
              icon: "arrow_up_green.png",
              theme: theme,
              title: "Total transactions",
              subTitle: "100,000",
            ),
            const SizedBox(width: 8),
            _buildCard(
              icon: "arrow_down_red.png",
              theme: theme,
              title: "Total spend",
              subTitle: "20,000",
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: _customColor.customEFEFEF)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent transaction",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () => _transactionDetailstBottomSheet(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/icon/arrow_right_orange.png",
                        height: 16,
                        width: 16,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 22),
            //Show when recenent transaction is empty
            // const EmptyState()
            _buildRecentTransactionCard(context),
          ],
        ),
      )
    ]);
  }
}
