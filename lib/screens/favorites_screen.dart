import 'package:flutter/material.dart';
import '../models/star.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;
    final dividerColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;

    // モック用のお気に入りデータ
    final List<Star> favoriteStars = [
      Star(
        id: '1',
        name: 'YOASOBI',
        category: 'ミュージック',
        rank: 'S',
        followers: 1500000,
        imageUrl: 'https://example.com/yoasobi.jpg',
      ),
      Star(
        id: '2',
        name: '米津玄師',
        category: 'ミュージック',
        rank: 'S',
        followers: 2000000,
        imageUrl: 'https://example.com/yonezu.jpg',
      ),
      Star(
        id: '3',
        name: '星野源',
        category: 'ミュージック',
        rank: 'A',
        followers: 1200000,
        imageUrl: 'https://example.com/hoshino.jpg',
      ),
      Star(
        id: '4',
        name: '宮崎駿',
        category: '映画',
        rank: 'S+',
        followers: 5000000,
        imageUrl: 'https://example.com/miyazaki.jpg',
      ),
      Star(
        id: '5',
        name: '佐藤健',
        category: '俳優',
        rank: 'A+',
        followers: 800000,
        imageUrl: 'https://example.com/sato.jpg',
      ),
    ];

    // コレクション
    final List<Map<String, dynamic>> collections = [
      {
        'name': 'お気に入りミュージシャン',
        'count': 3,
        'image': 'https://example.com/music_collection.jpg',
      },
      {
        'name': '2023年注目スター',
        'count': 5,
        'image': 'https://example.com/2023_stars.jpg',
      },
      {
        'name': '映画関連',
        'count': 2,
        'image': 'https://example.com/movie_collection.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'お気に入り',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: textColor,
            ),
            onPressed: () {
              // 検索機能
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // コレクションセクション
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'コレクション',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // コレクション管理画面へ
                    },
                    child: Text(
                      '管理',
                      style: TextStyle(
                        color: isDarkMode ? Colors.blue : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // コレクションリスト
            SizedBox(
              height: 160,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: collections.length + 1, // 追加ボタン用に+1
                itemBuilder: (context, index) {
                  if (index == collections.length) {
                    // 最後の要素は追加ボタン
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: isDarkMode ? Colors.blue : Colors.black,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '新規作成',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  
                  final collection = collections[index];
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(collection['image']),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                        onError: (exception, stackTrace) {
                          return;
                        },
                      ),
                    ),
                    child: Stack(
                      children: [
                        // グラデーション
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        // テキスト
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                collection['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${collection['count']}個のスター',
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // お気に入りスターセクション
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'お気に入りスター',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 並べ替え
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          size: 16,
                          color: isDarkMode ? Colors.blue : Colors.black,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '並べ替え',
                          style: TextStyle(
                            color: isDarkMode ? Colors.blue : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // お気に入りスターリスト
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: favoriteStars.length,
              itemBuilder: (context, index) {
                final star = favoriteStars[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isDarkMode
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            star.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                                child: Center(
                                  child: Text(
                                    star.name.substring(0, 1),
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      title: Text(
                        star.name,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            star.category,
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getRankColor(star.rank, isDarkMode),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  star.rank,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.people_outline,
                                size: 14,
                                color: secondaryTextColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                _formatFollowers(star.followers),
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // お気に入り解除
                        },
                      ),
                      onTap: () {
                        // スター詳細画面へ
                        Navigator.pushNamed(
                          context,
                          '/star_detail',
                          arguments: star,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            
            // 余白
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
  
  // ランクに応じた色を返す
  Color _getRankColor(String rank, bool isDarkMode) {
    switch (rank) {
      case 'S+':
        return Colors.purple;
      case 'S':
        return Colors.blue;
      case 'A+':
        return Colors.green;
      case 'A':
        return Colors.teal;
      case 'B+':
        return Colors.amber;
      case 'B':
        return Colors.orange;
      default:
        return isDarkMode ? Colors.grey.shade700 : Colors.grey.shade600;
    }
  }
  
  // フォロワー数のフォーマット
  String _formatFollowers(int followers) {
    if (followers >= 10000) {
      double man = followers / 10000;
      return '${man.toStringAsFixed(man.truncateToDouble() == man ? 0 : 1)}万';
    } else if (followers >= 1000) {
      double kilo = followers / 1000;
      return '${kilo.toStringAsFixed(kilo.truncateToDouble() == kilo ? 0 : 1)}千';
    } else {
      return '$followers';
    }
  }
} 