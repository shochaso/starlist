import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class FanMyPageScreen extends StatelessWidget {
  const FanMyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
    final accentColor = isDarkMode ? Colors.blue : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'マイページ',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: textColor),
            onPressed: () {
              // 設定画面へ遷移
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // プロフィールセクション
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: secondaryTextColor,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ファンネーム',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'fan@example.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryTextColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // プロフィール編集画面へ遷移
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('プロフィールを編集'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Divider(color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
            
            // フォロー中のスター
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'フォロー中のスター',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            
            Container(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16),
                itemCount: 5, // モック用。実際のデータを使用
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                          child: Icon(
                            Icons.star,
                            size: 30,
                            color: secondaryTextColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'スター${index + 1}',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            Divider(color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
            
            // アクティビティ履歴
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'アクティビティ履歴',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // モック用。実際のデータを使用
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      index % 2 == 0 ? Icons.favorite : Icons.comment,
                      color: accentColor,
                    ),
                  ),
                  title: Text(
                    index % 2 == 0 ? 'スターをいいねしました' : 'コメントしました',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    '${index + 1}日前',
                    style: TextStyle(
                      color: secondaryTextColor,
                    ),
                  ),
                );
              },
            ),
            
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
} 