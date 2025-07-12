import 'package:flutter/material.dart';

/// 花山瑞樹（YouTuber）のモックユーザーデータ
class HanayamaMizukiData {
  static const String userId = 'hanayama_mizuki_official';
  
  // プロフィール情報
  static const Map<String, dynamic> profile = {
    'id': userId,
    'name': '花山瑞樹',
    'displayName': 'みずき',
    'accountType': 'star', // YouTuber = スター
    'category': '日常Blog・ファッション',
    'verified': true,
    'avatar': 'HM', // アバター初期文字
    'bio': '🌸日常を綴るYouTuber\n👗ファッション・コーデ紹介\n🛍️お気に入りアイテム共有\n📍東京在住',
    'website': 'https://youtube.com/@hanayamamizuki',
    'joinDate': '2023-03-15',
    'followers': 127000,
    'following': 89,
    'totalViews': 2840000,
    'gradientColors': [Color(0xFFFFB6C1), Color(0xFFFFC0CB)], // ピンク系
    'primaryColor': Color(0xFFFFB6C1),
    'secondaryColor': Color(0xFFFFC0CB),
    
    // YouTuber統計
    'statistics': {
      'totalVideos': 156,
      'totalSubscribers': 127000,
      'averageViews': 18200,
      'totalWatchTime': '45,200時間',
      'uploadFrequency': '週3回',
      'mainGenres': ['日常Vlog', 'ファッション', 'お買い物記録'],
    },
    
    // SNSリンク
    'socialLinks': {
      'youtube': '@hanayamamizuki',
      'instagram': '@mizuki_hanayama',
      'twitter': '@hanayama_mizuki',
      'tiktok': '@mizuki.hanayama',
    },
  };

  // 最近の動画投稿
  static final List<Map<String, dynamic>> recentVideos = [
    {
      'id': 'video_001',
      'title': '【2024年冬】最新コート購入品紹介！ZARA、ユニクロ、GUで見つけたお気に入り💕',
      'description': '今年の冬に向けて購入したコートを詳しく紹介します！プチプラから少し高めまで、様々な価格帯のアイテムをレビューしました🧥',
      'thumbnail': 'https://example.com/thumbnails/winter_coat_2024.jpg',
      'duration': '12:34',
      'publishedAt': '2024-07-10T15:30:00Z',
      'views': 24500,
      'likes': 1820,
      'comments': 156,
      'tags': ['ファッション', 'コート', 'ZARA', 'ユニクロ', 'GU', '購入品紹介'],
      'category': 'ファッション',
    },
    {
      'id': 'video_002', 
      'title': '【日常Vlog】カフェ巡り＆お気に入りスキンケア購入｜のんびり休日の過ごし方🌸',
      'description': '久しぶりのゆったり休日！新しくオープンしたカフェに行って、ずっと気になっていたスキンケアアイテムもお迎えしました☕',
      'thumbnail': 'https://example.com/thumbnails/weekend_vlog_cafe.jpg',
      'duration': '15:42',
      'publishedAt': '2024-07-08T12:00:00Z',
      'views': 18700,
      'likes': 1340,
      'comments': 89,
      'tags': ['日常Vlog', 'カフェ', 'スキンケア', '休日', 'のんびり'],
      'category': '日常Blog',
    },
    {
      'id': 'video_003',
      'title': '【購入品】無印良品で見つけた生活を豊かにするアイテム7選📝✨',
      'description': '無印良品で購入した日用品を紹介！どれも実用的で、生活の質を上げてくれるアイテムばかりです🏠',
      'thumbnail': 'https://example.com/thumbnails/muji_haul_2024.jpg',
      'duration': '10:15',
      'publishedAt': '2024-07-05T18:00:00Z',
      'views': 31200,
      'likes': 2150,
      'comments': 203,
      'tags': ['購入品', '無印良品', '日用品', 'ライフスタイル', 'インテリア'],
      'category': '日用品',
    },
  ];

  // 購入履歴（最近の投稿）
  static final List<Map<String, dynamic>> recentPurchases = [
    {
      'id': 'purchase_001',
      'date': '2024-07-10',
      'store': 'ZARA',
      'category': 'ファッション',
      'items': [
        {
          'name': 'オーバーサイズウールコート',
          'price': 9990,
          'color': 'ベージュ',
          'size': 'M',
          'rating': 4.5,
          'review': 'シルエットが綺麗で、どんなコーデにも合わせやすい！生地もしっかりしていて長く使えそうです🧥',
        },
        {
          'name': 'ニットセーター',
          'price': 4990,
          'color': 'アイボリー',
          'size': 'S',
          'rating': 4.0,
          'review': '肌触りが良くて着心地抜群。コートのインナーにぴったりでした💕',
        },
      ],
      'totalAmount': 14980,
      'videoLinked': 'video_001',
    },
    {
      'id': 'purchase_002',
      'date': '2024-07-08',
      'store': 'コスメキッチン',
      'category': 'スキンケア',
      'items': [
        {
          'name': 'ナチュラル美容液',
          'price': 3800,
          'brand': 'エトヴォス',
          'rating': 5.0,
          'review': 'ずっと気になっていたアイテム！使用感がとても良くて、肌がもちもちになります✨',
        },
        {
          'name': 'フェイシャルミスト',
          'price': 2200,
          'brand': 'アクセーヌ', 
          'rating': 4.0,
          'review': '保湿力が高くて、メイクの上からでもシュッと使えて便利です',
        },
      ],
      'totalAmount': 6000,
      'videoLinked': 'video_002',
    },
    {
      'id': 'purchase_003',
      'date': '2024-07-05',
      'store': '無印良品',
      'category': '日用品',
      'items': [
        {
          'name': 'アロマディフューザー',
          'price': 6990,
          'rating': 4.5,
          'review': 'デザインがシンプルで部屋に馴染みます。香りの拡散力も申し分なし！',
        },
        {
          'name': 'オーガニックコットンタオル',
          'price': 1990,
          'color': 'ナチュラル',
          'rating': 4.0,
          'review': '肌に優しくて吸水性も良い。毎日使うものだからこだわりたいアイテム',
        },
        {
          'name': '収納ボックス（3個セット）',
          'price': 2990,
          'rating': 5.0,
          'review': 'クローゼットの整理に大活躍！サイズ感も絶妙で使いやすいです📦',
        },
      ],
      'totalAmount': 11970,
      'videoLinked': 'video_003',
    },
  ];

  // 投稿予定・企画案
  static final List<Map<String, dynamic>> upcomingContent = [
    {
      'title': '【2024年冬】プチプラ＆デパコス混合！本当に使えるコスメ紹介',
      'scheduledDate': '2024-07-15',
      'category': 'コスメ',
      'status': '編集中',
    },
    {
      'title': '【ルームツアー】一人暮らしの6畳1K、収納アイデアもご紹介',
      'scheduledDate': '2024-07-18',
      'category': 'ライフスタイル',
      'status': '撮影完了',
    },
    {
      'title': '【Q&A】質問コーナー！ファッションやライフスタイルについて答えます',
      'scheduledDate': '2024-07-22',
      'category': '日常Blog',
      'status': '企画段階',
    },
  ];

  // フォロワー層分析
  static const Map<String, dynamic> audienceAnalytics = {
    'ageGroups': {
      '18-24': 35,
      '25-34': 42,
      '35-44': 18,
      '45+': 5,
    },
    'gender': {
      'female': 87,
      'male': 11,
      'other': 2,
    },
    'topInterests': [
      'ファッション',
      'コスメ・美容',
      'ライフスタイル',
      'カフェ',
      '一人暮らし',
    ],
    'engagementRate': 8.4, // %
    'averageWatchTime': '6分42秒',
  };
}