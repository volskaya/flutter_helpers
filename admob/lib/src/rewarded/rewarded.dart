import 'dart:async';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admob/src/helpers/memoizer.dart';

import '../../admob.dart';
import '../utils.dart';

part 'rewarded.freezed.dart';
part 'rewarded.g.dart';

/// The events a [RewardedAd] can receive. Listen
/// to the events using `rewardedAd.onEvent.listen((event) {})`.
///
/// Avaiable events:
///   - loading (When the ad starts loading)
///   - loaded (When the ad is loaded)
///   - loadFailed (When the ad failed to load)
///   - showed (When the ad is opened)
///   - failedToShow (When it failed to show the ad)
///   - showFailed (When the ad failed to show)
///   - earnedReward (When the user earns a reward)
enum RewardedAdEvent { loadFailed, loaded, loading, showed, showFailed, closed, earnedReward }

@freezed
abstract class RewardItem with _$RewardItem {
  const factory RewardItem({
    @required String type,
    @required int amount,
  }) = _RewardItem;

  factory RewardItem.fromJson(Map<String, dynamic> json) => _$RewardItemFromJson(json);
}

/// An InterstitialAd model to communicate with the model on the platform side.
/// It gives you methods to help in the implementation and event tracking.
///
/// For more info, see:
///   - https://developers.google.com/admob/android/rewarded-fullscreen
///   - https://developers.google.com/admob/ios/rewarded-ads
class RewardedAd extends AdMethodChannel<RewardedAdEvent> {
  RewardedAd({this.unitId});

  static String get testUnitId => MobileAds.rewardedAdTestUnitId;

  final String unitId;

  @override
  Stream<Map<RewardedAdEvent, dynamic>> get onEvent => super.onEvent as Stream<Map<RewardedAdEvent, dynamic>>;
  Memoizer<bool> _loaded;
  bool get isLoaded => _loaded?.value == true;

  @override
  Future init() async {
    channel.setMethodCallHandler(_handleMessages);
    await MobileAds.pluginChannel.invokeMethod('initRewardedAd', {'id': id});
  }

  @override
  void dispose() {
    super.dispose();
    MobileAds.pluginChannel.invokeMethod('disposeRewardedAd', {'id': id});
  }

  /// Handle the messages the channel sends
  Future<void> _handleMessages(MethodCall call) async {
    if (disposed) return;
    switch (call.method) {
      case 'loading':
        onEventController.add({RewardedAdEvent.loading: null});
        break;
      case 'onAdFailedToLoad':
        onEventController.add({
          RewardedAdEvent.loadFailed: AdError.fromJson(call.arguments as Map<String, dynamic>),
        });
        break;
      case 'onAdLoaded':
        onEventController.add({RewardedAdEvent.loaded: null});
        break;
      case 'onUserEarnedReward':
        onEventController
            .add({RewardedAdEvent.earnedReward: RewardItem.fromJson(call.arguments as Map<String, dynamic>)});
        break;
      case 'onAdShowedFullScreenContent':
        onEventController.add({RewardedAdEvent.showed: null});
        break;
      case 'onAdFailedToShowFullScreenContent':
        onEventController.add({
          RewardedAdEvent.showFailed: AdError.fromJson(call.arguments as Map<String, dynamic>),
        });
        break;
      case 'onAdDismissedFullScreenContent':
        onEventController.add({RewardedAdEvent.closed: null});
        break;
      default:
        break;
    }
  }

  Future<bool> _callLoadAd() => channel.invokeMethod<bool>('loadAd', {
        'unitId': unitId ?? MobileAds.rewardedAdUnitId ?? MobileAds.rewardedAdTestUnitId,
      });

  @override
  Future<bool> load() async {
    assert(MobileAds.isInitialized);
    assert(!disposed);
    return (_loaded ??= Memoizer<bool>(future: _callLoadAd)).future;
  }

  @override
  Future<bool> show() async {
    assert(MobileAds.isInitialized);
    assert(!disposed);
    if (await load()) return channel.invokeMethod<bool>('show');
    return false;
  }
}