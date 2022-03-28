import 'package:flutoo/models/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// condition en fonction du role du userCurrent
/// pour afficher ou cacher la partie condition
final showCondition = StateProvider<bool?>((ref) {
  return ref.watch(userCurrent)?.role?['libelle'] == 'root';
});
