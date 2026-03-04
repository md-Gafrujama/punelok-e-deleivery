class StoreModel {
  final String name;
  final String address;
  final String distance;
  final String bonus;
  final bool recommended;

  StoreModel({
    required this.name,
    required this.address,
    required this.distance,
    required this.bonus,
    this.recommended = false,
  });
}