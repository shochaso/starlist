import 'package:flutter/material.dart';
import '../models/star.dart';
import '../models/activity.dart';
import '../routes/app_routes.dart';
import '../widgets/star_card.dart';
import '../widgets/activity_card.dart';
import '../widgets/horizontal_section.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onThemeToggle;

  const HomeScreen({
    Key? key, 
    this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
    final accentColor = isDarkMode ? Colors.blue : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;
    final searchBarColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

    // モック用データ
    final List<Star> stars = [
      Star(
        id: '1',
        name: 'YOASOBI',
        category: 'ミュージシャン',
        rank: 'スーパー',
        followers: 1500000,
        imageUrl: 'https://example.com/yoasobi.jpg',
      ),
      Star(
        id: '2',
        name: 'King & Prince',
        category: 'アイドル',
        rank: 'プラチナ',
        followers: 850000,
        imageUrl: 'https://example.com/kingandprince.jpg',
      ),
      Star(
        id: '3',
        name: 'バスケットボールスタイル',
        category: 'YouTuber',
        rank: 'レギュラー',
        followers: 350000,
        imageUrl: 'https://example.com/basketballstyle.jpg',
      ),
    ];

    final List<Activity> activities = [
      Activity(
        id: '1',
        starId: '1',
        type: 'youtube',
        title: '新曲「祝福」MV公開',
        content: 'YOASOBIの新曲「祝福」ミュージックビデオがYouTubeで公開されました。',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        imageUrl: 'https://example.com/yoasobi_mv.jpg',
      ),
      Activity(
        id: '2',
        starId: '2',
        type: 'purchase',
        title: 'ニューアルバム「L&」発売',
        content: 'King & Princeのニューアルバム「L&」が発売されました。',
        timestamp: DateTime.now().subtract(Duration(days: 3)),
        imageUrl: 'https://example.com/kingandprince_album.jpg',
        price: 3300,
      ),
    ];

    final List<Map<String, dynamic>> categories = [
      {'name': 'YouTuber', 'icon': Icons.play_circle_filled, 'color': Colors.red.shade200},
      {'name': 'ミュージシャン', 'icon': Icons.music_note, 'color': Colors.blue.shade200},
      {'name': 'アーティスト', 'icon': Icons.palette, 'color': Colors.purple.shade200},
      {'name': 'モデル', 'icon': Icons.face, 'color': Colors.orange.shade200},
      {'name': 'ストリーマー', 'icon': Icons.stream, 'color': Colors.green.shade200},
      {'name': 'イラストレーター', 'icon': Icons.brush, 'color': Colors.yellow.shade200},
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // AppBarに相当する部分
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'スターリスト',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Row(
                          children: [
                            // テーマ切り替えボタン
                            IconButton(
                              icon: Icon(
                                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                                color: textColor,
                              ),
                              onPressed: onThemeToggle,
                            ),
                            SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                              child: Icon(
                                Icons.person,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // 検索バー
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: searchBarColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: secondaryTextColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'スター、カテゴリーなど',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.mic,
                            color: secondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // カテゴリーのタイトル
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'カテゴリー',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // すべて表示ボタンの処理
                      },
                      child: Text(
                        'すべて表示',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // カテゴリーグリッド
            SliverToBoxAdapter(
              child: Container(
                height: 250,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.category,
                          arguments: categories[index]['name'],
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: categories[index]['color'],
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isDarkMode ? [] : [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Text(
                                categories[index]['name'],
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Icon(
                                categories[index]['icon'],
                                color: isDarkMode ? Colors.white : Colors.black87,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // おすすめのスターのタイトル
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'あなたにおすすめのスター',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // すべて表示ボタンの処理
                      },
                      child: Text(
                        'すべて表示',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // スターリスト
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isDarkMode ? [] : [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 60,
                            height: 60,
                            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                            child: Image.network(
                              stars[index].imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    stars[index].name.substring(0, 1),
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        title: Text(
                          stars[index].name,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          stars[index].category,
                          style: TextStyle(
                            color: secondaryTextColor,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.starDetail,
                              arguments: stars[index],
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? Colors.grey.shade800 : accentColor,
                            foregroundColor: isDarkMode ? Colors.white : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text('入手'),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.starDetail,
                            arguments: stars[index],
                          );
                        },
                      ),
                    ),
                  );
                },
                childCount: stars.length,
              ),
            ),

            // 今日のアクティビティのタイトル
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '今日のアクティビティ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // すべて表示ボタンの処理
                      },
                      child: Text(
                        'すべて表示',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // アクティビティリスト
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: activities.map((activity) {
                      return Container(
                        width: 280,
                        margin: EdgeInsets.only(right: 16),
                        child: isDarkMode
                            ? ActivityCard(
                                activity: activity,
                                onTap: () {
                                  // アクティビティタップ時の処理
                                },
                              )
                            : Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // アクティビティ画像
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.network(
                                          activity.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey.shade300,
                                              child: Center(
                                                child: Icon(
                                                  _getActivityIcon(activity.type),
                                                  size: 40,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activity.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: textColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            activity.content,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: secondaryTextColor,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (activity.price != null)
                                            Padding(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Text(
                                                '¥${activity.price}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // 余白
            SliverToBoxAdapter(
              child: SizedBox(height: 80),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        selectedItemColor: accentColor,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_outlined),
            activeIcon: Icon(Icons.rocket),
            label: 'ゲーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            activeIcon: Icon(Icons.apps),
            label: 'アプリ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports_outlined),
            activeIcon: Icon(Icons.sports_esports),
            label: 'Arcade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: '検索',
          ),
        ],
        currentIndex: 0,
      ),
    );
  }
  
  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'youtube':
        return Icons.play_circle_outline;
      case 'purchase':
        return Icons.shopping_bag_outlined;
      case 'music':
        return Icons.music_note_outlined;
      default:
        return Icons.star_outline;
    }
  }
} 