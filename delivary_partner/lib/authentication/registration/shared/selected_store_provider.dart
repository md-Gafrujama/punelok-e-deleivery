
import 'package:delivary_partner/authentication/registration/domain/store_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

final selectedStoreProvider = StateProvider<int>((ref) => -1);

final storeListProvider = Provider<List<StoreModel>>((ref) {
  return [
    StoreModel(
      name: "Super Store Pune Undri ES118",
      address: "S.No.16/13B, Holewasti, Undri, Pune",
      distance: "2 km",
      bonus: "₹3,000 Joining Bonus",
      recommended: true,
    ),
    StoreModel(
      name: "Super Store Pune Pisoli ES143",
      address: "S.No.12/1, Pisoli, Haveli, Pune",
      distance: "3 km",
      bonus: "₹1,500 Joining Bonus",
      recommended: true,
    ),
     StoreModel(
      name: "Super Store Pune Pisoli ES143",
      address: "S.No.12/1, Pisoli, Haveli, Pune",
      distance: "3 km",
      bonus: "₹1,500 Joining Bonus",
      recommended: true,
    ),
     StoreModel(
      name: "Super Store Pune Pisoli ES143",
      address: "S.No.12/1, Pisoli, Haveli, Pune",
      distance: "3 km",
      bonus: "₹1,500 Joining Bonus",
      recommended: true,
    ),
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredStoreProvider = Provider<List<StoreModel>>((ref) {
  final stores = ref.watch(storeListProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return stores;

  return stores.where((store) {
    return store.name.toLowerCase().contains(query) ||
        store.address.toLowerCase().contains(query);
  }).toList();
});