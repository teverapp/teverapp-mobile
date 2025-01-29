import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/view/widgets/wallet_screen/card_added.dart';
import 'package:tever/view/widgets/wallet_screen/card_details.dart';
import 'package:tever/view/widgets/wallet_screen/mobile_money.dart';
import 'package:tever/view/widgets/wallet_screen/online_payment.dart';
import 'package:tever/view/widgets/wallet_screen/p2p_transfer.dart';
import 'package:tever/view/widgets/wallet_screen/processing_your_transaction.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with SingleTickerProviderStateMixin {
  final CustomColors _customColor = const CustomColors();

  final List<String> _paymentMethods = [
    "Debit/ credit card",
    "P2P transfer",
    "Bank transfer",
    "Mobile money",
    "Online payments",
    "Other payment options"
  ];

  String? _selectedPaymentMethod;

  bool _startAddingCardDetails = false;

  bool _showAddCardButton = false;

  bool _cardAdded = false;

  bool _isP2P = false;

  bool _p2pReqeustFunds = false;

  bool _isMobileMoney = false;

  bool _isOnlinePayment = false;

  final GlobalKey _dropdownKey = GlobalKey();

  OverlayEntry? _overlayEntry;

  bool _isMenuOpen = false;

  String? selectedItem;

  late AnimationController _animationController;

  late Animation<double> _animation;

  String? selectedValue;

  Widget _buildPaymentMethodCard({required String selectedPaymentMethod}) {
    final activeIcon = _selectedPaymentMethod == selectedPaymentMethod
        ? "radio_active_circular.png"
        : "radio_inactive_circular.png";

    final activeBgColor = _selectedPaymentMethod == selectedPaymentMethod
        ? _customColor.customF9E8CC
        : Colors.transparent;

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: activeBgColor,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Reset only the currently active state variables
            if (_isP2P) _isP2P = false;
            if (_p2pReqeustFunds) _p2pReqeustFunds = false;
            if (_showAddCardButton) _showAddCardButton = false;
            if (_startAddingCardDetails) _startAddingCardDetails = false;
            if (_isMobileMoney) _isMobileMoney = false;
            if (_isOnlinePayment) _isOnlinePayment = false;
            if (_cardAdded) _cardAdded = false;

            // Update state dynamically using the index in the _paymentMethods array
            final index = _paymentMethods.indexOf(selectedPaymentMethod);
            if (index == 0) {
              // "Debit/ credit card"
              _showAddCardButton = true;
            } else if (index == 1) {
              // "P2P transfer"
              _isP2P = true;
            } else if (index == 3) {
              // "Mobile money"
              _isMobileMoney = true;
            } else if (index == 4) {
              // "Online payments"
              _isOnlinePayment = true;
            }

            _selectedPaymentMethod = selectedPaymentMethod;
          });

          _closeMenu();
        },
        child: Row(
          children: [
            Image.asset(
              "assets/icon/$activeIcon",
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 8),
            Text(
              selectedPaymentMethod,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cardAddedHandler() {
    setState(() {
      _cardAdded = true;
      _startAddingCardDetails = false;
    });
  }

  void _toggleDropdown() {
    if (_isMenuOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5,
          width: size.width,
          child: Material(
            elevation: 0,
            child: FadeTransition(
              opacity: _animation,
              child: SizeTransition(
                sizeFactor: _animation,
                axisAlignment: -1.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 250, // Adjust max height for scrollable area
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _paymentMethods.map((paymentMethod) {
                          return _buildPaymentMethodCard(
                              selectedPaymentMethod: paymentMethod);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
    setState(() {
      _isMenuOpen = true;
    });
  }

  Future<void> _closeMenu() async {
    await _animationController.reverse();
    _overlayEntry?.remove();
    setState(() {
      _isMenuOpen = false;
    });
  }

  void cardAddedHander() {
    setState(() {
      _startAddingCardDetails = false;
      _cardAdded = true;
    });
  }

  Future<void> _closeMenuAndPop() async {
    if (_isMenuOpen) {
      await _closeMenu();
    }
    if (!mounted) return;

    // Check if it's a modal route before popping
    if (ModalRoute.of(context)?.isCurrent == true) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final height = mediaQuery.height * 0.92;

    return WillPopScope(
      onWillPop: () async {
        if (_isMenuOpen) {
          await _closeMenuAndPop();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onVerticalDragEnd: (_) async {
          await _closeMenuAndPop();
        },
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: height),
          padding: const EdgeInsets.only(top: 17),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Flexible(
                child:

                    // ProcessingYourTransaction()
                    SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amount to top up",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424),
                      ),
                      const SizedBox(height: 9),
                      TextFormField(
                        style: TextStyle(
                          color: _customColor.custom242424,
                          fontSize: 14,
                        ),
                        initialValue: "₦7,000",
                        decoration: InputDecoration(
                          hintText: "Enter amount",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _customColor.customEFEFEF,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _customColor.customEFEFEF,
                              width: 1,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _customColor.customEFEFEF,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(width: 1),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _customColor.custom242424,
                          ),
                        ),
                        onChanged: (value) async {},
                      ),
                      const SizedBox(height: 15),

                      Text(
                        "Payment method.",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _customColor.custom242424),
                      ),
                      const SizedBox(height: 9),
                      GestureDetector(
                        onTap: _toggleDropdown,
                        child: Container(
                          key: _dropdownKey,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _customColor.customEFEFEF,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedPaymentMethod ??
                                    "Choose a payment method",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedPaymentMethod == null
                                        ? _customColor.custom888888
                                        : _customColor.custom242424),
                              ),
                              Image.asset(
                                'assets/icon/drop_down.png', // Path to your custom icon
                                height: 16,
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Positioned(
                      //     right: 0,
                      //     left: 0,
                      //     bottom: 0,
                      //     child: ClipRRect(
                      //       borderRadius: const BorderRadius.only(
                      //           bottomLeft: Radius.circular(20),
                      //           bottomRight: Radius.circular(20)),
                      //       child: DecoratedBox(
                      //           decoration: const BoxDecoration(color: Colors.green),
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: _paymentMethods
                      //                 .map((paymentMethod) => _buildPaymentMethodCard(
                      //                     selectedPaymentMethod: paymentMethod))
                      //                 .toList(),
                      //           )),
                      //     )),

                      const SizedBox(
                        height: 24,
                      ),
                      if (_showAddCardButton)
                        Container(
                          height: 40,
                          width: 207,
                          decoration: BoxDecoration(
                              color: _customColor.customF9E8CC,
                              borderRadius: BorderRadius.circular(100)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0)),
                            onPressed: () {
                              setState(() {
                                _startAddingCardDetails = true;
                                _showAddCardButton = false;
                              });
                            },
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("assets/icon/add_gray.png",
                                      height: 20, width: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Add debit/ credit card",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: _customColor.custom242424),
                                  ),
                                ]),
                          ),
                        ),
                      if (_startAddingCardDetails) const SizedBox(height: 8),
                      if (_startAddingCardDetails)
                        CardDetails(cardAddedHandler: _cardAddedHandler),
                      if (_cardAdded) const SizedBox(height: 8),
                      if (_cardAdded) const CardAdded(),

                      if (_isP2P)
                        Container(
                          height: 40,
                          width: 129,
                          decoration: BoxDecoration(
                              color: _customColor.customF9E8CC,
                              borderRadius: BorderRadius.circular(100)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0)),
                            onPressed: () {
                              setState(() {
                                _isP2P = false;

                                _p2pReqeustFunds = true;
                              });
                            },
                            child: Text(
                              "Request funds",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _customColor.custom242424),
                            ),
                          ),
                        ),
                      if (_isP2P) const SizedBox(height: 4),
                      if (_isP2P)
                        Text(
                          "You can send a fund request to a Tever user",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _customColor.custom965CF6),
                        ),

                      if (_p2pReqeustFunds)
                        P2pTransfer(cardAddedHandler: () {}),
                      if (_isMobileMoney) MobileMoney(),
                      if (_isOnlinePayment) OnlinePayment(),

                      const SizedBox(height: 110),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: _customColor.custom242424,
                                      width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _customColor.custom242424,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                              child: SizedBox(
                            height: 56,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: _customColor.customD1D1D1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: const Text(
                                "Top up",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
