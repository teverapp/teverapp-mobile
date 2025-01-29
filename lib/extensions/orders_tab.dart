enum OrdersTabStatus {
  myCart,
  ongoing,
  complete,
}

extension OrdersTabStatusExtension on OrdersTabStatus {
  String get value {
    switch (this) {
      case OrdersTabStatus.myCart:
        return 'My cart';
      case OrdersTabStatus.ongoing:
        return 'Ongoing';
      case OrdersTabStatus.complete:
        return 'Complete';
      default:
        return '';
    }
  }
}
