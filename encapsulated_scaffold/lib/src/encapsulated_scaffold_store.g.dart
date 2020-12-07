// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encapsulated_scaffold_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncapsulatedScaffoldStore on _EncapsulatedScaffoldStore, Store {
  Computed<EncapsulatedScaffoldState> _$capsuleComputed;

  @override
  EncapsulatedScaffoldState get capsule => (_$capsuleComputed ??=
          Computed<EncapsulatedScaffoldState>(() => super.capsule,
              name: '_EncapsulatedScaffoldStore.capsule'))
      .value;
  Computed<EncapsulatedNotificationItem> _$notificationComputed;

  @override
  EncapsulatedNotificationItem get notification => (_$notificationComputed ??=
          Computed<EncapsulatedNotificationItem>(() => super.notification,
              name: '_EncapsulatedScaffoldStore.notification'))
      .value;

  final _$_EncapsulatedScaffoldStoreActionController =
      ActionController(name: '_EncapsulatedScaffoldStore');

  @override
  void pushNotification(EncapsulatedNotificationItem item,
      [Set<String> _replacements = const <String>{}]) {
    final _$actionInfo = _$_EncapsulatedScaffoldStoreActionController
        .startAction(name: '_EncapsulatedScaffoldStore.pushNotification');
    try {
      return super.pushNotification(item, _replacements);
    } finally {
      _$_EncapsulatedScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dismissNotification(EncapsulatedNotificationItem item) {
    final _$actionInfo = _$_EncapsulatedScaffoldStoreActionController
        .startAction(name: '_EncapsulatedScaffoldStore.dismissNotification');
    try {
      return super.dismissNotification(item);
    } finally {
      _$_EncapsulatedScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dismissNotificationsWhere(
      bool Function(EncapsulatedNotificationItem) conditional,
      {bool includeImportant = true}) {
    final _$actionInfo =
        _$_EncapsulatedScaffoldStoreActionController.startAction(
            name: '_EncapsulatedScaffoldStore.dismissNotificationsWhere');
    try {
      return super.dismissNotificationsWhere(conditional,
          includeImportant: includeImportant);
    } finally {
      _$_EncapsulatedScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dismissAllNotifications({bool includingUndismissible = false}) {
    final _$actionInfo =
        _$_EncapsulatedScaffoldStoreActionController.startAction(
            name: '_EncapsulatedScaffoldStore.dismissAllNotifications');
    try {
      return super.dismissAllNotifications(
          includingUndismissible: includingUndismissible);
    } finally {
      _$_EncapsulatedScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
capsule: ${capsule},
notification: ${notification}
    ''';
  }
}
