// GlobalKey for the Saved nav item so save-to-nav animation can target its position.
// Assigned in ScaffoldWithNav; read by SaveToNavAnimationOverlay.

import 'package:flutter/material.dart';

/// GlobalKey for the bottom nav "Saved" item. Used to compute fly-to-saved end position.
final GlobalKey savedNavItemKey = GlobalKey();
