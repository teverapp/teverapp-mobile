import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';
import 'package:tever/model/common.dart';
import 'package:tever/view/widgets/general/common/logo_loader.dart';

class CustomDropDown extends StatefulWidget {
  final List<CommonType> dropdownItems;
  final void Function(
      {required String value,
      required String id,
      String? imageUrl})? selectItem;
  final String selectedItem;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? retry;
  final bool hasSelected;
  final bool? hideBulletPoint;
  final bool? addCustomItemToList;
  final Function? addMoreItemsToList;
  final double? dropDownHeight;
  final bool Function()? validateBeforeShowingList;

  const CustomDropDown(
      {super.key,
      required this.dropdownItems,
      required this.selectItem,
      required this.selectedItem,
      required this.hasSelected,
      this.validateBeforeShowingList,
      this.isLoading = false,
      this.addCustomItemToList = false,
      this.errorMessage,
      this.retry,
      this.hideBulletPoint,
      this.dropDownHeight = 96,
      this.addMoreItemsToList});

  @override
  State<CustomDropDown> createState() => _DropDownState();
}

class _DropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  final CustomColors _customColor = const CustomColors();

  OverlayEntry? _overlayEntry;

  bool _isDropdownVisible = false;

  bool _startAddingNewItemToList = false;

  final TextEditingController _addMoreItemsToListController =
      TextEditingController();

  //final ScrollController _addMoretemsToListController = ScrollController();

  // void _scrollToBottom() {
  //   _addMoretemsToListController.animateTo(
  //     _addMoretemsToListController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeOut,
  //   );
  // }

  void _showStartAddingNewItemToListHandler() {
    _startAddingNewItemToList = true;

    _showDropdown(checkValidation: false);
  }

  late AnimationController _animationController;

  late Animation<Offset> _slideAnimation;

  late bool _hideBulletPoint;

  @override
  void initState() {
    super.initState();
    _startAddingNewItemToList = false;
    _hideBulletPoint = widget.hideBulletPoint ?? true;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.07),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onTap({required bool checkValidation}) {
    if (_isDropdownVisible) {
      _removeDropdown();
    } else {
      _showDropdown(checkValidation: checkValidation);
    }
  }

  void _showDropdown({required bool checkValidation}) {
    if (widget.validateBeforeShowingList != null && checkValidation) {
      final bool value = widget.validateBeforeShowingList!();

      if (!value) {
        return;
      }
    }

    _removeDropdown(immediate: true);

    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    final Offset position = renderBox.localToGlobal(Offset.zero);

    final theme = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.06),
            dismissible: true,
            onDismiss: _removeDropdown,
          ),
          Positioned(
            left: position.dx,
            top: position.dy + renderBox.size.height + 8,
            width: renderBox.size.width,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: SlideTransition(
                position: _slideAnimation,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Container(
                    height: widget.dropDownHeight,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(-2, -2),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: widget.isLoading
                        ? const LogoLoader(height: 20, width: 20)
                        : widget.errorMessage != null
                            ? _buildErrorContent(theme)
                            : _buildDropdownList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
    setState(() {
      _isDropdownVisible = true;
    });
  }

  Widget _buildErrorContent(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Text(
              widget.errorMessage.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 30,
            width: 90,
            child: TextButton(
              onPressed: widget.retry,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                "Try again",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownList() {
    return Column(children: [
      Expanded(
          child: widget.dropdownItems.isEmpty
              ? const Center(
                  child: Text(
                    "No item found",
                    style: TextStyle(fontSize: 12),
                  ),
                )
              : ListView.builder(
                  //shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: widget.dropdownItems.length,
                  itemBuilder: (context, index) {
                    final isActive =
                        widget.dropdownItems[index].name == widget.selectedItem;

                    print("haaaaaaaaaaa1 ${_hideBulletPoint}");
                    return GestureDetector(
                      onTap: () {
                        _onTap(checkValidation: false);
                        if (widget.selectItem != null) {
                          widget.selectItem!(
                              value: widget.dropdownItems[index].name,
                              id: widget.dropdownItems[index].id.toString(),
                              imageUrl: widget.dropdownItems[index].imageUrl);
                        }
                      },
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: isActive
                            ? _customColor.customF9E8CC
                            : Colors.transparent,
                        child: Row(
                          children: [
                            if (_hideBulletPoint) ...[
                              Image.asset(
                                isActive
                                    ? "assets/icon/radio_active_circular.png"
                                    : "assets/icon/radio_inactive_circular.png",
                                height: 16,
                                width: 16,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              widget.dropdownItems[index].name.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: _customColor.custom242424,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
      if (widget.addCustomItemToList!) ...[
        if (!_startAddingNewItemToList)
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 38,
              child: GestureDetector(
                onTap: _showStartAddingNewItemToListHandler,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/add_circle_orange.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Add new",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _customColor.customE1781F,
                      ),
                    )
                  ],
                ),
              )),
        if (_startAddingNewItemToList)
          Container(
            height: 48,
            margin: const EdgeInsets.only(bottom: 7, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: _customColor.customDCDCDC,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: _addMoreItemsToListController,
                    style: TextStyle(
                      color: _customColor.custom242424,
                      fontSize: 14,
                      height: 1.4, // Adjust line height for better alignment
                    ),
                    textAlignVertical:
                        TextAlignVertical.center, // Ensures vertical centering
                    maxLines: 1, // Prevents unintended text overflow
                    decoration: InputDecoration(
                      isDense: true, // Reduces padding around the text
                      hintText: "Enter text",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 2, // Fine-tunes vertical alignment
                        horizontal: 4, // Adds slight horizontal padding
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _customColor.custom888888,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      if (_addMoreItemsToListController.text.isEmpty) return;

                      final stringId = widget.dropdownItems.last.id;

                      int numberId = int.parse(stringId.toString()) + 1;

                      String result = numberId.toString();

                      widget.addMoreItemsToList!(CommonType(
                          id: result,
                          name: _addMoreItemsToListController.text));

                      _addMoreItemsToListController.clear();
                    },
                    child: Image.asset(
                      "assets/icon/tick_circle.png",
                      height: 16,
                      width: 16,
                    ))
              ],
            ),
          ),
      ],
    ]);
  }

  void _removeDropdown({bool immediate = false}) {
    if (immediate) {
      // Skip animation and clean up immediately
      _animationController.stop();
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
      _isDropdownVisible = false;
    } else {
      _animationController.reverse();
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
      setState(() {
        _isDropdownVisible = false;
      });
      // });

      //To add animation on exit
      // _animationController.reverse().then((_) {
      //   if (_overlayEntry != null) {
      //     _overlayEntry!.remove();
      //     _overlayEntry = null;
      //   }
      //   setState(() {
      //     _isDropdownVisible = false;
      //   });
      // });
    }
  }

  @override
  void didUpdateWidget(covariant CustomDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading != oldWidget.isLoading) {
      if (_isDropdownVisible && mounted) {
        Future.delayed(const Duration(microseconds: 1), () {
          _showDropdown(checkValidation: false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("custom drop down build called now 1");

    return GestureDetector(
      onTap: () => _onTap(checkValidation: true),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _customColor.customEFEFEF,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedItem,
              style: TextStyle(
                color: !widget.hasSelected
                    ? _customColor.custom888888
                    : _customColor.custom242424,
                fontSize: 14,
              ),
            ),
            Image.asset(
              "assets/icon/drop_down.png",
              height: 16,
              width: 16,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isDropdownVisible && _overlayEntry != null) {
      _removeDropdown(immediate: true);
    }
    _addMoreItemsToListController.dispose();

    _animationController.dispose();
    super.dispose();
  }
}
