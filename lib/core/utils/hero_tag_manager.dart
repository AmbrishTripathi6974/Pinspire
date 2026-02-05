// Hero tag management system
// Centralized system for generating unique Hero tags to prevent conflicts
// Similar to how Pinterest handles Hero animations with context-aware tags

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Context for Hero tag generation
/// Determines the uniqueness scope for Hero animations
enum HeroTagContext {
  /// Home feed context
  homeFeed,
  
  /// Search results context
  searchResults,
  
  /// Related pins context (in pin viewer)
  relatedPins,
  
  /// Saved pins context
  savedPins,
  
  /// Board detail context
  boardDetail,
  
  /// Discover/trending context
  discover,
  
  /// Pin viewer (destination) - always uses base tag without context
  pinViewer,
}

/// Centralized Hero tag manager
/// 
/// Generates unique Hero tags based on:
/// - Pin ID
/// - Context (where the pin is displayed)
/// - Optional index/position (for when same pin appears multiple times)
/// 
/// This ensures:
/// 1. Same pin in different contexts gets different tags
/// 2. Same pin multiple times in same context gets unique tags
/// 3. Source and destination Hero widgets use matching tags
class HeroTagManager {
  HeroTagManager._();

  /// Generates a Hero tag for a pin in a specific context
  /// 
  /// [pinId] - The unique pin identifier
  /// [context] - The context where the pin is displayed
  /// [index] - Optional index/position (for uniqueness when same pin appears multiple times)
  /// 
  /// Returns a unique tag string
  static String generateTag({
    required String pinId,
    required HeroTagContext context,
    int? index,
  }) {
    final contextPrefix = _getContextPrefix(context);
    
    if (index != null) {
      return 'pin_${pinId}_${contextPrefix}_$index';
    }
    
    return 'pin_${pinId}_$contextPrefix';
  }

  /// Generates a Hero tag for pin viewer (destination)
  /// This should match the source tag when navigating from a feed
  /// 
  /// [pinId] - The unique pin identifier
  /// [sourceContext] - The context where the pin was tapped (source)
  /// [sourceIndex] - Optional index from source context
  static String generateViewerTag({
    required String pinId,
    required HeroTagContext sourceContext,
    int? sourceIndex,
  }) {
    // Viewer tag must match the source tag for Hero animation to work
    return generateTag(
      pinId: pinId,
      context: sourceContext,
      index: sourceIndex,
    );
  }

  /// Gets the context prefix for tag generation
  static String _getContextPrefix(HeroTagContext context) {
    switch (context) {
      case HeroTagContext.homeFeed:
        return 'feed';
      case HeroTagContext.searchResults:
        return 'search';
      case HeroTagContext.relatedPins:
        return 'related';
      case HeroTagContext.savedPins:
        return 'saved';
      case HeroTagContext.boardDetail:
        return 'board';
      case HeroTagContext.discover:
        return 'discover';
      case HeroTagContext.pinViewer:
        return 'viewer';
    }
  }

  /// Extracts pin ID and context from a Hero tag
  /// Useful for debugging and tag validation
  static ({String pinId, HeroTagContext? context, int? index})? parseTag(String tag) {
    if (!tag.startsWith('pin_')) {
      return null;
    }

    final parts = tag.split('_');
    if (parts.length < 2) {
      return null;
    }

    final pinId = parts[1];
    
    if (parts.length == 2) {
      // Legacy format: pin_<id>
      return (pinId: pinId, context: null, index: null);
    }

    if (parts.length == 3) {
      // Format: pin_<id>_<context>
      final context = _parseContext(parts[2]);
      return (pinId: pinId, context: context, index: null);
    }

    if (parts.length == 4) {
      // Format: pin_<id>_<context>_<index>
      final context = _parseContext(parts[2]);
      final index = int.tryParse(parts[3]);
      return (pinId: pinId, context: context, index: index);
    }

    return null;
  }

  /// Parses context string to enum
  static HeroTagContext? _parseContext(String contextStr) {
    switch (contextStr) {
      case 'feed':
        return HeroTagContext.homeFeed;
      case 'search':
        return HeroTagContext.searchResults;
      case 'related':
        return HeroTagContext.relatedPins;
      case 'saved':
        return HeroTagContext.savedPins;
      case 'board':
        return HeroTagContext.boardDetail;
      case 'discover':
        return HeroTagContext.discover;
      case 'viewer':
        return HeroTagContext.pinViewer;
      default:
        return null;
    }
  }
}

/// Extension to get Hero tag context from current route
extension HeroTagContextExtension on BuildContext {
  /// Gets the Hero tag context based on current route
  /// Falls back to homeFeed if route cannot be determined
  HeroTagContext getHeroTagContext() {
    final location = GoRouterState.of(this).uri.path;
    
    if (location.startsWith('/search')) {
      return HeroTagContext.searchResults;
    } else if (location.startsWith('/saved')) {
      return HeroTagContext.savedPins;
    } else if (location.startsWith('/board/')) {
      return HeroTagContext.boardDetail;
    } else if (location.startsWith('/pin/')) {
      return HeroTagContext.pinViewer;
    } else {
      return HeroTagContext.homeFeed;
    }
  }
}
