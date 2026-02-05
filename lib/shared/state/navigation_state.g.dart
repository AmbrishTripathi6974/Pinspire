// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NavigationStateImpl _$$NavigationStateImplFromJson(
  Map<String, dynamic> json,
) => _$NavigationStateImpl(
  selectedTab:
      $enumDecodeNullable(_$AppTabEnumMap, json['selectedTab']) ?? AppTab.home,
  previousTab: $enumDecodeNullable(_$AppTabEnumMap, json['previousTab']),
  isBottomNavVisible: json['isBottomNavVisible'] as bool? ?? true,
  isInitialized: json['isInitialized'] as bool? ?? false,
  deepLinkPath: json['deepLinkPath'] as String?,
);

Map<String, dynamic> _$$NavigationStateImplToJson(
  _$NavigationStateImpl instance,
) => <String, dynamic>{
  'selectedTab': _$AppTabEnumMap[instance.selectedTab]!,
  'previousTab': _$AppTabEnumMap[instance.previousTab],
  'isBottomNavVisible': instance.isBottomNavVisible,
  'isInitialized': instance.isInitialized,
  'deepLinkPath': instance.deepLinkPath,
};

const _$AppTabEnumMap = {
  AppTab.home: 'home',
  AppTab.search: 'search',
  AppTab.create: 'create',
  AppTab.notifications: 'notifications',
  AppTab.profile: 'profile',
};
