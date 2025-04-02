import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/app.dart';

class MypageScreen extends ConsumerWidget {
  final Function? onThemeToggle;

  const MypageScreen({
    Key? key,
    this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;
    final dividerColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;

    // テーマモードの取得
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'マイページ',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // プロフィールセクション
            Container(
              padding: const EdgeInsets.all(16),
              color: backgroundColor,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: cardColor,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ユーザー名',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'user@example.com',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildStatItem('10', 'スター', textColor, secondaryTextColor),
                            _buildStatItem('5', 'コレクション', textColor, secondaryTextColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 設定セクション
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '設定',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // 設定リスト
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // テーマ切り替え
                  ListTile(
                    leading: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: textColor,
                    ),
                    title: Text(
                      'テーマ設定',
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      isDarkMode ? 'ダークモード' : 'ライトモード',
                      style: TextStyle(color: secondaryTextColor),
                    ),
                    trailing: Switch(
                      value: isDarkMode,
                      activeColor: isDarkMode ? Colors.blue : Colors.black,
                      onChanged: (value) {
                        if (onThemeToggle != null) {
                          onThemeToggle!();
                        }
                      },
                    ),
                  ),
                  
                  Divider(color: dividerColor, height: 1),
                  
                  // 通知設定
                  ListTile(
                    leading: Icon(
                      Icons.notifications_outlined,
                      color: textColor,
                    ),
                    title: Text(
                      '通知設定',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: () {
                      // 通知設定画面へ
                    },
                  ),
                  
                  Divider(color: dividerColor, height: 1),
                  
                  // プライバシー設定
                  ListTile(
                    leading: Icon(
                      Icons.security_outlined,
                      color: textColor,
                    ),
                    title: Text(
                      'プライバシー設定',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: () {
                      // プライバシー設定画面へ
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // アカウントセクション
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'アカウント',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // アカウント関連リスト
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // プロフィール編集
                  ListTile(
                    leading: Icon(
                      Icons.edit_outlined,
                      color: textColor,
                    ),
                    title: Text(
                      'プロフィール編集',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: () {
                      // プロフィール編集画面へ
                    },
                  ),
                  
                  Divider(color: dividerColor, height: 1),
                  
                  // お支払い情報
                  ListTile(
                    leading: Icon(
                      Icons.payment_outlined,
                      color: textColor,
                    ),
                    title: Text(
                      'お支払い情報',
                      style: TextStyle(color: textColor),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: () {
                      // お支払い情報画面へ
                    },
                  ),
                  
                  Divider(color: dividerColor, height: 1),
                  
                  // ログアウト
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                    ),
                    title: Text(
                      'ログアウト',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      // ログアウト処理
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: cardColor,
                          title: Text(
                            'ログアウト確認',
                            style: TextStyle(color: textColor),
                          ),
                          content: Text(
                            'ログアウトしてもよろしいですか？',
                            style: TextStyle(color: textColor),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'キャンセル',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.blue : Colors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // ログアウト処理
                                Navigator.pop(context);
                              },
                              child: Text(
                                'ログアウト',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // バージョン情報
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Starlist v1.0.0',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String count, String label, Color textColor, Color secondaryColor) {
    return Expanded(
      child: Row(
        children: [
          Text(
            count,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
} 