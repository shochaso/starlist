import 'package:flutter/material.dart';
import 'package:starlist/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          gradient: RadialGradient(
            colors: [Color(0x33D10FEE), AppTheme.backgroundColor],
            center: Alignment.topRight,
            radius: 0.7,
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeroSection(),
                      _buildFeaturesSection(),
                      _buildContentSection(),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        color: AppTheme.backgroundColor.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              GradientText(
                'Starlist',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('ログイン'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: Column(
        children: [
          GradientText(
            'スターの日常を、もっと身近に',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '動画編集の技術や時間がなくても、誰でも気軽に利用できるSNS',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.mutedForegroundColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen(isStar: true)),
                  );
                },
                icon: Icon(Icons.star_border),
                label: Text('スターとして登録'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen(isStar: false)),
                  );
                },
                child: Text('ファンとして登録'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.person_search_rounded,
        'color': Color(0xFF8C52FF), // 紫色に変更
        'title': 'スターをもっと深く知る',
        'description': '日常生活の共有から新たな魅力を発見できます',
      },
      {
        'icon': Icons.volunteer_activism,
        'color': Color(0xFF069668), // 音楽アイコンのカラー
        'title': 'スターのメンタルに配慮した設計',
        'description': '有料ファン限定コメント機能でスターのメンタルを保護',
      },
      {
        'icon': Icons.attach_money_rounded,
        'color': Color(0xFFFF9900), // ショッピングアイコンのカラー
        'title': '収益化の機会',
        'description': '商品レコメンドやアフィリエイトで新たな収入源を確保',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: Column(
        children: [
          GradientText(
            '主な機能',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            constraints: BoxConstraints(maxWidth: 900),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _navigateToPage(context, features[index]['title'] as String),
                  child: Container(
                    decoration: AppTheme.cardGradientDecoration,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          features[index]['icon'] as IconData,
                          color: features[index]['color'] as Color,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          features[index]['title'] as String,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          features[index]['description'] as String,
                          style: TextStyle(
                            color: AppTheme.mutedForegroundColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    final contents = [
      {
        'icon': Icons.video_library_rounded,
        'title': '動画',
        'color': Color(0xFFDC2625),
      },
      {
        'icon': Icons.library_music_rounded,
        'title': '音楽',
        'color': Color(0xFF069668),
      },
      {
        'icon': Icons.movie_rounded,
        'title': '映画・ドラマ',
        'color': Color(0xFFDC2625),
      },
      {
        'icon': Icons.sports_esports_rounded,
        'title': 'ゲーム',
        'color': Color(0xFF8C52FF),
      },
      {
        'icon': Icons.menu_book_rounded,
        'title': '書籍',
        'color': Color(0xFF4285F4),
      },
      {
        'icon': Icons.shopping_cart_rounded,
        'title': 'ショッピング',
        'color': Color(0xFFFF9900),
      },
      {
        'icon': Icons.restaurant_rounded,
        'title': '飲食情報',
        'color': Color(0xFFFF5252),
      },
      {
        'icon': Icons.phone_android_rounded,
        'title': 'スマホアプリ',
        'color': Color(0xFF0AB2CC),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: Column(
        children: [
          GradientText(
            '提供コンテンツ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            constraints: BoxConstraints(maxWidth: 900),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: contents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _navigateToPage(context, contents[index]['title'] as String),
                  child: Container(
                    decoration: AppTheme.cardGradientDecoration,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          contents[index]['icon'] as IconData,
                          color: contents[index]['color'] as Color,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          contents[index]['title'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, String pageName) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => DetailPage(title: pageName),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        color: AppTheme.backgroundColor.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                'Starlist',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () => _navigateToPage(context, '利用規約'),
                child: Text('利用規約'),
              ),
              TextButton(
                onPressed: () => _navigateToPage(context, 'プライバシーポリシー'),
                child: Text('プライバシーポリシー'),
              ),
              TextButton(
                onPressed: () => _navigateToPage(context, 'お問い合わせ'),
                child: Text('お問い合わせ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  
  const DetailPage({Key? key, required this.title}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          gradient: RadialGradient(
            colors: [Color(0x33D10FEE), AppTheme.backgroundColor],
            center: Alignment.topRight,
            radius: 0.7,
            stops: [0.0, 0.5],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getIconForPage(title),
                  size: 64.0,
                  color: _getColorForPage(title),
                ),
                SizedBox(height: 24),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${title}のページです。ここには${title}に関する情報が表示されます。',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('戻る'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  IconData _getIconForPage(String title) {
    switch (title) {
      case '利用規約':
        return Icons.description;
      case 'プライバシーポリシー':
        return Icons.privacy_tip;
      case 'お問い合わせ':
        return Icons.contact_support;
      case '動画':
        return Icons.video_library_rounded;
      case '音楽':
        return Icons.library_music_rounded;
      case 'ゲーム':
        return Icons.sports_esports_rounded;
      case 'スマホアプリ':
        return Icons.phone_android_rounded;
      case '映画・ドラマ':
        return Icons.movie_rounded;
      case '書籍':
        return Icons.menu_book_rounded;
      case 'ショッピング':
        return Icons.shopping_cart_rounded;
      case '飲食情報':
        return Icons.restaurant_rounded;
      case 'スターをもっと深く知る':
        return Icons.person_search_rounded;
      case 'スターのメンタルに配慮した設計':
        return Icons.volunteer_activism;
      case '収益化の機会':
        return Icons.attach_money_rounded;
      default:
        return Icons.info;
    }
  }
  
  Color _getColorForPage(String title) {
    switch (title) {
      case '動画':
        return Color(0xFFDC2625);
      case '音楽':
        return Color(0xFF069668);
      case 'ゲーム':
        return Color(0xFF8C52FF);
      case 'スマホアプリ':
        return Color(0xFF0AB2CC);
      case '映画・ドラマ':
        return Color(0xFFDC2625);
      case '書籍':
        return Color(0xFF4285F4);
      case 'ショッピング':
        return Color(0xFFFF9900);
      case '飲食情報':
        return Color(0xFFFF5252);
      case 'スターをもっと深く知る':
        return Color(0xFF8C52FF);
      case 'スターのメンタルに配慮した設計':
        return Color(0xFF069668);
      case '収益化の機会':
        return Color(0xFFFF9900);
      default:
        return AppTheme.primaryColor;
    }
  }
} 