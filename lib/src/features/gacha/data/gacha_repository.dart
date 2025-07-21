import 'dart:math';
import '../models/gacha_models_simple.dart';
import 'package:flutter/material.dart';

/// ガチャのデータアクセス層抽象クラス
abstract class GachaRepository {
  Future<GachaResult> drawGacha();
}

/// ガチャリポジトリの実装クラス
class GachaRepositoryImpl implements GachaRepository {
  final Random _random = Random();

  @override
  Future<GachaResult> drawGacha() async {
    // 意図的な遅延でアニメーション時間を確保
    await Future.delayed(const Duration(seconds: 2));

    // 確率による抽選処理
    final randomValue = _random.nextDouble() * 100; // 0-100の範囲

    if (randomValue < 50.0) {
      // 10ポイント (50%)
      return const PointResult(amount: 10);
    } else if (randomValue < 85.0) {
      // 30ポイント (35%)
      return const PointResult(amount: 30);
    } else if (randomValue < 95.0) {
      // 50ポイント (10%)
      return const PointResult(amount: 50);
    } else if (randomValue < 98.5) {
      // 100ポイント (3.5%)
      return const PointResult(amount: 100);
    } else if (randomValue < 99.5) {
      // シルバーチケット (1%)
      return const TicketResult(
        ticketType: 'silver',
        displayName: 'シルバーチケット',
        color: Colors.grey,
      );
    } else {
      // ゴールドチケット (0.5%)
      return const TicketResult(
        ticketType: 'gold',
        displayName: 'ゴールドチケット',
        color: Colors.amber,
      );
    }
  }
}