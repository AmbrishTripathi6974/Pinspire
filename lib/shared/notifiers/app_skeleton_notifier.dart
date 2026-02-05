// Notifier for app-level skeleton overlay
// Show on cold start, app resume, first login/signup; hide when feed is ready + min duration

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest/shared/state/app_skeleton_state.dart';

class AppSkeletonNotifier extends StateNotifier<AppSkeletonState> {
  AppSkeletonNotifier() : super(const AppSkeletonState());

  void show() {
    state = AppSkeletonState(visible: true, shownAt: DateTime.now());
  }

  void hide() {
    state = const AppSkeletonState(visible: false, shownAt: null);
  }
}

final appSkeletonProvider =
    StateNotifierProvider<AppSkeletonNotifier, AppSkeletonState>((ref) {
  return AppSkeletonNotifier();
});
