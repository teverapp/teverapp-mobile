import 'package:flutter/material.dart';
import 'package:tever/helpers/custom_colors.dart';

class Filter extends StatefulWidget {
  final VoidCallback toggleShowFilter;
  const Filter({super.key, required this.toggleShowFilter});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final CustomColors _customColor = const CustomColors();

  final List<Map<String, String>> _filterSources = [
    {"label": "Direct", "key": "Direct"},
    {"label": "3rd platforms", "key": "3rdplatforms"},
  ];
  final List<Map<String, String>> _filterDeals = [
    {"label": "Discounts", "key": "discounts"},
    {"label": "Free item(s)", "key": "freeitems"},
    {"label": "Flash sales", "key": "flashsales"},
  ];
  final List<Map<String, String>> _filterTeverPick = [
    {"label": "Top deals", "key": "topdeals"},
    {"label": "Top sellers", "key": "topsellers"},
    {"label": "Top brands", "key": "topbrands"},
  ];
  final List<Map<String, String>> _filterPrice = [
    {"label": "Any price", "key": "anyprice"},
    {"label": "Under ₦10,000", "key": "under₦10,000"},
    {"label": "₦10,000 to ₦50,000", "key": "₦10,000to₦50,000 "},
    {"label": "₦50,000 to ₦100,000", "key": "₦50,000to₦100,000 "},
    {"label": "Over to ₦100,000", "key": "Overto₦100,000"},
    {"label": "Custom", "key": "custom"},
  ];

  final List<Map<String, String>> _filterDispatch = [
    {"label": "Same day", "key": "sameday"},
    {"label": "3 - 5 days", "key": "3-5days"}
  ];

  final List<String> _filterCategories = [
    "Category",
    "Category",
    "Category",
    "Category"
  ];

  late String _selectedSources;
  late String _selectedDeals;
  late String _selectedTeverPick;
  late String _selectedPrice;
  late String _selectedDispatch;

  void _selectSources(String key) {
    setState(() {
      _selectedSources = key;
    });
  }

  void _selectDeals(String key) {
    setState(() {
      _selectedDeals = key;
    });
  }

  void _selectTeverPick(String key) {
    setState(() {
      _selectedTeverPick = key;
    });
  }

  void _selectPrice(String key) {
    setState(() {
      _selectedPrice = key;
    });
  }

  void _selectDispatch(String key) {
    setState(() {
      _selectedDispatch = key;
    });
  }

  Widget _buildFilter(
      {required List<Map<String, String>> filterList,
      required String title,
      required Function onTap,
      required String selectedFilter}) {
    return Container(
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
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
              children: filterList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => onTap(entry.value["key"]),
              child: Container(
                margin: EdgeInsets.only(
                    bottom: filterList.length - 1 == entry.key ? 0 : 8),
                child: Row(
                  children: [
                    Image.asset(
                      selectedFilter == entry.value["key"]
                          ? "assets/icon/radio_active.png"
                          : "assets/icon/radio_inactive.png",
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      entry.value["label"].toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _customColor.custom5D5D5D),
                    )
                  ],
                ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }

  Widget _buildSelection({required String title, required Function onTap}) {
    return Container(
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
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _customColor.custom242424),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () => onTap(),
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(width: 1, color: _customColor.customEFEFEF)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/icon/ng_flag.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Nigeria (₦)",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: _customColor.custom5D5D5D),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/icon/drop_down.png",
                    height: 16,
                    width: 16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedSources = _filterSources[0]["key"].toString();
    _selectedDeals = _filterDeals[0]["key"].toString();
    _selectedTeverPick = _filterTeverPick[0]["key"].toString();
    _selectedPrice = _filterPrice[0]["key"].toString();
    _selectedDispatch = _filterDispatch[0]["key"].toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary),
              ),
              GestureDetector(
                onTap: widget.toggleShowFilter,
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icon/close_circle_darker.png",
                    height: 16,
                    width: 16,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 28,
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: _customColor.customEDB25C,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 28,
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: _customColor.custom93C6E6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                _buildFilter(
                    filterList: _filterSources,
                    title: "Source",
                    onTap: _selectSources,
                    selectedFilter: _selectedSources),
                const SizedBox(height: 8),
                _buildFilter(
                    filterList: _filterDeals,
                    title: "Deals",
                    onTap: _selectDeals,
                    selectedFilter: _selectedDeals),
                const SizedBox(height: 8),
                _buildFilter(
                    filterList: _filterTeverPick,
                    title: "Tever's Pick",
                    onTap: _selectTeverPick,
                    selectedFilter: _selectedTeverPick),
                const SizedBox(height: 8),
                _buildSelection(onTap: () {}, title: "Location"),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(width: 1, color: _customColor.customEFEFEF),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _customColor.custom242424),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: _filterCategories
                            .asMap()
                            .entries
                            .map((entry) => Container(
                                  height: 16,
                                  margin: EdgeInsets.only(
                                      bottom: _filterCategories.length - 1 ==
                                              entry.key
                                          ? 0
                                          : 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        entry.value,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: _customColor.custom5D5D5D),
                                      ),
                                      const SizedBox(width: 30),
                                      Image.asset(
                                        "assets/icon/angle_right.png",
                                        height: 15,
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildFilter(
                    filterList: _filterPrice,
                    title: "Price",
                    onTap: _selectPrice,
                    selectedFilter: _selectedPrice),
                const SizedBox(height: 8),
                _buildFilter(
                    filterList: _filterDispatch,
                    title: "Shipping",
                    onTap: _selectDispatch,
                    selectedFilter: _selectedDispatch),
                const SizedBox(height: 8),
                _buildSelection(onTap: () {}, title: "Ship to"),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
