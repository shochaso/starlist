import 'package:flutter/material.dart';
import '../models/star.dart';
import '../models/activity.dart';
import '../widgets/activity_card.dart';

class StarDetailScreen extends StatelessWidget {
  final Star star;

  const StarDetailScreen({
    Key? key,
    required this.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
    final accentColor = isDarkMode ? Colors.blue : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;
    final dividerColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    
    // モック用アクティビティデータ
    final List<Activity> activities = [
      Activity(
        id: '1',
        starId: star.id,
        type: 'youtube',
        title: '新曲「祝福」MV公開',
        content: 'YOASOBIの新曲「祝福」ミュージックビデオがYouTubeで公開されました。',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        imageUrl: 'https://example.com/yoasobi_mv.jpg',
      ),
      Activity(
        id: '2',
        starId: star.id,
        type: 'music',
        title: 'デジタルシングル「祝福」配信開始',
        content: 'デジタルシングル「祝福」の配信が各音楽ストリーミングサービスで開始されました。',
        timestamp: DateTime.now().subtract(Duration(days: 2)),
        imageUrl: 'https://example.com/yoasobi_digital.jpg',
      ),
      Activity(
        id: '3',
        starId: star.id,
        type: 'purchase',
        title: '1stアルバム「THE BOOK」発売',
        content: 'YOASOBIの1stアルバム「THE BOOK」が発売されました。',
        timestamp: DateTime.now().subtract(Duration(days: 30)),
        imageUrl: 'https://example.com/yoasobi_album.jpg',
        price: 3300,
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // スライバーアップバー
          SliverAppBar(
            backgroundColor: isDarkMode ? Colors.black : Colors.transparent,
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                star.name,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  shadows: isDarkMode ? [] : [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // スター画像
                  Image.network(
                    star.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                        child: Center(
                          child: Text(
                            star.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // オーバーレイグラデーション
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDarkMode
                            ? [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ]
                            : [
                                Colors.transparent,
                                Colors.white.withOpacity(0.5),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  // シェア機能
                },
              ),
            ],
          ),
          
          // スター概要
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // アイコン
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      child: Image.network(
                        star.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              star.name.substring(0, 1),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // スター情報
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          star.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          star.category,
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // 入手ボタン
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDarkMode ? Colors.blue : Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: Text('入手'),
                            ),
                            SizedBox(width: 12),
                            IconButton(
                              onPressed: () {
                                // お気に入り機能
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // スクリーンショットスクロール
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                  child: Text(
                    '注目のアクティビティ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 320,
                        margin: EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            activities[index].imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                                child: Center(
                                  child: Icon(
                                    _getActivityIcon(activities[index].type),
                                    size: 50,
                                    color: isDarkMode ? Colors.white : Colors.grey[700],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 統計情報
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '情報',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  _infoRow(Icons.people, 'フォロワー', _formatFollowers(star.followers), textColor, secondaryTextColor),
                  Divider(color: dividerColor),
                  _infoRow(Icons.star, 'ランク', star.rank, textColor, secondaryTextColor),
                  Divider(color: dividerColor),
                  _infoRow(Icons.category, 'カテゴリ', star.category, textColor, secondaryTextColor),
                  Divider(color: dividerColor),
                  _infoRow(Icons.calendar_today, '登録日', '2023年4月1日', textColor, secondaryTextColor),
                ],
              ),
            ),
          ),
          
          // アクティビティ一覧のタイトル
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'すべてのアクティビティ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
          
          // アクティビティリスト
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
                      contentPadding: EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                          child: Image.network(
                            activities[index].imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                _getActivityIcon(activities[index].type),
                                color: isDarkMode ? Colors.white : Colors.grey[700],
                                size: 30,
                              );
                            },
                          ),
                        ),
                      ),
                      title: Text(
                        activities[index].title,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        activities[index].content,
                        style: TextStyle(
                          color: secondaryTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: activities[index].price != null
                          ? Text(
                              '¥${activities[index].price!.toInt()}',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              },
              childCount: activities.length,
            ),
          ),
          
          // 余白
          SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color textColor, Color secondaryColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: secondaryColor,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: secondaryColor,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ],
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