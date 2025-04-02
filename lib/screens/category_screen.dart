import 'package:flutter/material.dart';
import '../models/star.dart';
import '../routes/app_routes.dart';
import '../widgets/star_card.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({
    Key? key,
    required this.category,
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
    
    // モック用データ（カテゴリーに基づいたスター）
    final List<Star> categoryStars = [
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
      Star(
        id: '4',
        name: 'BUMP OF CHICKEN',
        category: 'ミュージシャン',
        rank: 'スーパー',
        followers: 1200000,
        imageUrl: 'https://example.com/bump.jpg',
      ),
      Star(
        id: '5',
        name: 'Snow Man',
        category: 'アイドル',
        rank: 'プラチナ',
        followers: 780000,
        imageUrl: 'https://example.com/snowman.jpg',
      ),
    ];

    // 選択されたカテゴリーに基づいてフィルタリング
    final filteredStars = category == 'おすすめ' || category == 'ランキング'
        ? categoryStars
        : categoryStars.where((star) => star.category == category).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          category,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 検索バー
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
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
                    '$categoryで検索',
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
          ),

          // カテゴリータイトル
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '$categoryの人気スター',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),

          // スターリスト
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredStars.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
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
                          filteredStars[index].imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                filteredStars[index].name.substring(0, 1),
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
                      filteredStars[index].name,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          filteredStars[index].category,
                          style: TextStyle(
                            color: secondaryTextColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            filteredStars[index].rank,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.starDetail,
                          arguments: filteredStars[index],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? Colors.grey.shade800 : accentColor,
                        foregroundColor: Colors.white,
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
                        arguments: filteredStars[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 