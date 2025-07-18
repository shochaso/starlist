import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../src/providers/theme_provider_enhanced.dart';
import '../../../providers/user_provider.dart';
import '../../subscription/screens/fan_subscription_screen.dart';
import '../../star/screens/star_dashboard_screen.dart';
import '../../data_integration/screens/data_import_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // 設定状態
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _analytics = true;
  String _language = 'ja';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _pushNotifications = prefs.getBool('push_notifications') ?? true;
        _emailNotifications = prefs.getBool('email_notifications') ?? true;
        _analytics = prefs.getBool('analytics') ?? true;
        _language = prefs.getString('language') ?? 'ja';
      });
    } catch (e) {
      debugPrint('設定の読み込みに失敗しました: $e');
    }
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is String) {
        await prefs.setString(key, value);
      }
    } catch (e) {
      debugPrint('設定の保存に失敗しました: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          '設定',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () => _navigateToHome(),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ユーザープロフィール
              _buildUserProfile(),
              const SizedBox(height: 24),
              
              _buildAccountSettings(),
              const SizedBox(height: 24),
              _buildPrivacySettings(),
              const SizedBox(height: 24),
              _buildNotificationSettings(),
              const SizedBox(height: 24),
              _buildAppSettings(),
              const SizedBox(height: 24),
              _buildSupportSettings(),
              const SizedBox(height: 24),
              _buildDangerZone(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.9),
            blurRadius: 0,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'スターユーザー',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'star@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'プレミアム',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => _editProfile(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return _buildSettingsSection(
      'アカウント',
      [
        _buildSettingsItem(
          Icons.person_outline,
          'プロフィール編集',
          'プロフィール情報を変更',
          () => _editProfile(),
        ),
        _buildSettingsItem(
          Icons.lock_outline,
          'パスワード変更',
          'パスワードを変更',
          () => _changePassword(),
        ),
        _buildSettingsItem(
          Icons.link,
          'SNS連携',
          'ソーシャルメディアアカウントの管理',
          () => _manageSocialLinks(),
        ),
        _buildSettingsItem(
          Icons.verified_user_outlined,
          '二段階認証',
          'アカウントのセキュリティを強化',
          () => _setupTwoFactor(),
        ),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return _buildSettingsSection(
      'プライバシー',
      [
        _buildSwitchItem(
          Icons.visibility_outlined,
          'プロフィール公開',
          'プロフィールを他のユーザーに公開',
          true,
          (value) => {},
        ),
        _buildSwitchItem(
          Icons.analytics_outlined,
          'データ分析',
          'アプリの改善のためのデータ収集',
          _analytics,
          (value) {
            setState(() => _analytics = value);
            _saveSetting('analytics', value);
            HapticFeedback.lightImpact();
          },
        ),
        _buildSettingsItem(
          Icons.shield_outlined,
          'データ管理',
          '個人データの管理と削除',
          () => _manageData(),
        ),
        _buildSettingsItem(
          Icons.policy_outlined,
          'プライバシーポリシー',
          'プライバシーポリシーを確認',
          () => _showPrivacyPolicy(),
        ),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return _buildSettingsSection(
      '通知',
      [
        _buildSwitchItem(
          Icons.notifications_outlined,
          'プッシュ通知',
          'アプリからの通知を受け取る',
          _pushNotifications,
          (value) {
            setState(() => _pushNotifications = value);
            _saveSetting('push_notifications', value);
            HapticFeedback.lightImpact();
          },
        ),
        _buildSwitchItem(
          Icons.email_outlined,
          'メール通知',
          '重要な更新をメールで受け取る',
          _emailNotifications,
          (value) {
            setState(() => _emailNotifications = value);
            _saveSetting('email_notifications', value);
            HapticFeedback.lightImpact();
          },
        ),
        _buildSettingsItem(
          Icons.tune,
          '通知設定の詳細',
          '通知の種類と頻度を設定',
          () => _configureNotifications(),
        ),
      ],
    );
  }

  Widget _buildAppSettings() {
    final themeState = ref.watch(themeProviderEnhanced);
    final themeActions = ref.read(themeActionProvider);
    
    return _buildSettingsSection(
      'アプリ',
      [
        _buildSwitchItem(
          Icons.dark_mode_outlined,
          'ダークモード',
          'ダークテーマを使用',
          themeState.themeMode == AppThemeMode.dark,
          (value) async {
            HapticFeedback.lightImpact();
            if (value) {
              await themeActions.setDark();
            } else {
              await themeActions.setLight();
            }
          },
        ),
        _buildCustomItem(
          Icons.brightness_6,
          'テーマ設定',
          '現在: ${themeState.themeMode.displayName}',
          () => _showThemeDialog(),
        ),
        _buildDropdownItem(
          Icons.language,
          '言語',
          'アプリの表示言語',
          _language,
          {
            'ja': '日本語',
            'en': 'English',
            'ko': '한국어',
            'zh': '中文',
          },
          (value) {
            setState(() => _language = value!);
            _saveSetting('language', value!);
          },
        ),
        _buildSettingsItem(
          Icons.storage_outlined,
          'キャッシュクリア',
          'アプリのキャッシュを削除',
          () => _clearCache(),
        ),
        _buildSettingsItem(
          Icons.info_outline,
          'アプリ情報',
          'バージョン情報とライセンス',
          () => _showAppInfo(),
        ),
      ],
    );
  }

  Widget _buildSupportSettings() {
    return _buildSettingsSection(
      'サポート',
      [
        _buildSettingsItem(
          Icons.help_outline,
          'ヘルプセンター',
          'よくある質問と使い方',
          () => _showHelp(),
        ),
        _buildSettingsItem(
          Icons.feedback_outlined,
          'フィードバック',
          'アプリの改善提案',
          () => _sendFeedback(),
        ),
        _buildSettingsItem(
          Icons.bug_report_outlined,
          'バグ報告',
          '問題を報告',
          () => _reportBug(),
        ),
        _buildSettingsItem(
          Icons.contact_support_outlined,
          'お問い合わせ',
          'サポートチームに連絡',
          () => _contactSupport(),
        ),
      ],
    );
  }

  Widget _buildDangerZone() {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2A2A2A), Color(0xFF1F1F1F)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFFEF2F2)],
              ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFF6B6B).withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B6B).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.9),
            blurRadius: 0,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning, color: Color(0xFFFF6B6B), size: 20),
              SizedBox(width: 8),
              Text(
                '危険な操作',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF6B6B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDangerItem(
            Icons.logout,
            'ログアウト',
            'アカウントからログアウト',
            () => _logout(),
          ),
          _buildDangerItem(
            Icons.delete_forever,
            'アカウント削除',
            'アカウントを完全に削除',
            () => _deleteAccount(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A2A2A), Color(0xFF1F1F1F)],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Color(0xFFFAFBFC)],
                  ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark 
                  ? const Color(0xFF404040).withValues(alpha: 0.3)
                  : const Color(0xFFE2E8F0).withValues(alpha: 0.6),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.9),
                blurRadius: 0,
                offset: const Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF888888)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF4ECDC4),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    IconData icon,
    String title,
    String subtitle,
    String value,
    Map<String, String> options,
    Function(String?) onChanged,
  ) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            underline: Container(),
            items: options.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFFF6B6B), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF6B6B),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFFF6B6B), size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF888888)),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeDialog() {
    final themeState = ref.read(themeProviderEnhanced);
    final themeActions = ref.read(themeActionProvider);
    final isDark = themeState.isDarkMode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A2A2A), Color(0xFF1F1F1F)],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Color(0xFFFAFBFC)],
                  ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'テーマ設定',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ...AppThemeMode.values.map((mode) {
                  final isSelected = themeState.themeMode == mode;
                  return RadioListTile<AppThemeMode>(
                    title: Text(
                      mode.displayName,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    ),
                    value: mode,
                    groupValue: themeState.themeMode,
                    activeColor: const Color(0xFF4ECDC4),
                    onChanged: (value) async {
                      if (value != null) {
                        await themeActions.setThemeMode(value);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'キャンセル',
                        style: TextStyle(color: Color(0xFF4ECDC4)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // アクションメソッド
  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('プロフィール編集画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('パスワード変更画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _manageSocialLinks() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SNS連携管理画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _setupTwoFactor() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('二段階認証設定画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _manageData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('データ管理画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _showPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('プライバシーポリシーを表示します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _configureNotifications() {
    final themeState = ref.read(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        title: Text(
          '通知設定',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text(
                'スターの新着投稿',
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              ),
              value: true,
              onChanged: (value) {},
              activeColor: const Color(0xFF4ECDC4),
            ),
            CheckboxListTile(
              title: Text(
                'ランキング更新',
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              ),
              value: false,
              onChanged: (value) {},
              activeColor: const Color(0xFF4ECDC4),
            ),
            CheckboxListTile(
              title: Text(
                '新機能のお知らせ',
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              ),
              value: true,
              onChanged: (value) {},
              activeColor: const Color(0xFF4ECDC4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '保存',
              style: TextStyle(color: Color(0xFF4ECDC4)),
            ),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
    final themeState = ref.read(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        title: Text(
          'キャッシュクリア',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        ),
        content: Text(
          'アプリのキャッシュを削除しますか？\nこの操作は元に戻せません。',
          style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'キャンセル',
              style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('キャッシュを削除しました'),
                  backgroundColor: Color(0xFF4ECDC4),
                ),
              );
            },
            child: const Text(
              '削除',
              style: TextStyle(color: Color(0xFFFF6B6B)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAppInfo() {
    final themeState = ref.read(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        title: Text(
          'アプリ情報',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Starlist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'バージョン: 1.0.0',
              style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
            ),
            Text(
              'ビルド: 100',
              style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
            ),
            const SizedBox(height: 16),
            Text(
              '© 2024 Starlist Inc.',
              style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF4ECDC4)),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ヘルプセンターに移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _sendFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('フィードバック画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _reportBug() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('バグ報告画面に移動します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('サポートに連絡します'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _logout() {
    final themeState = ref.read(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        title: Text(
          'ログアウト',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        ),
        content: Text(
          'ログアウトしますか？',
          style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'キャンセル',
              style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ログアウトしました'),
                  backgroundColor: Color(0xFF4ECDC4),
                ),
              );
            },
            child: const Text(
              'ログアウト',
              style: TextStyle(color: Color(0xFFFF6B6B)),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() {
    final themeState = ref.read(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        title: const Text(
          'アカウント削除',
          style: TextStyle(color: Color(0xFFFF6B6B)),
        ),
        content: Text(
          'アカウントを削除すると、すべてのデータが永久に失われます。\nこの操作は元に戻せません。\n\n本当に削除しますか？',
          style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'キャンセル',
              style: TextStyle(color: isDark ? const Color(0xFF888888) : Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('アカウント削除処理を開始しました'),
                  backgroundColor: Color(0xFFFF6B6B),
                ),
              );
            },
            child: const Text(
              '削除',
              style: TextStyle(color: Color(0xFFFF6B6B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    final currentUser = ref.watch(currentUserProvider);
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Drawer(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      child: Column(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4ECDC4),
                    Color(0xFF44A08D),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Starlist',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          currentUser.isStar ? 'スター' : 'ファン',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildDrawerItem(Icons.home, 'ホーム', () => _navigateToHome()),
                _buildDrawerItem(Icons.search, '検索', () => _navigateToSearch()),
                _buildDrawerItem(Icons.star, 'マイリスト', () => _navigateToMylist()),
                // スターのみ表示
                if (currentUser.isStar) ...[
                  _buildDrawerItem(Icons.camera_alt, 'データ取込み', () => _navigateToDataImport()),
                  _buildDrawerItem(Icons.analytics, 'スターダッシュボード', () => _navigateToStarDashboard()),
                  _buildDrawerItem(Icons.workspace_premium, 'プランを管理', () => _navigateToPlanManagement()),
                ],
                _buildDrawerItem(Icons.person, 'マイページ', () => _navigateToProfile()),
                // ファンのみ課金プラン表示
                if (currentUser.isFan) ...[
                  _buildDrawerItem(Icons.credit_card, '課金プラン', () => _navigateToPlanManagement()),
                ],
                _buildDrawerItem(Icons.settings, '設定', null, isActive: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback? onTap, {bool isActive = false}) {
    final themeState = ref.watch(themeProviderEnhanced);
    final isDark = themeState.isDarkMode;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? const Color(0xFF4ECDC4).withValues(alpha: 0.15) : null,
        border: isActive ? Border.all(
          color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
          width: 1,
        ) : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive 
              ? const Color(0xFF4ECDC4)
              : (isDark ? Colors.white10 : Colors.grey.shade100),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isActive 
              ? Colors.white
              : (isDark ? Colors.white54 : Colors.grey.shade600),
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive 
              ? const Color(0xFF4ECDC4) 
              : (isDark ? Colors.white : Colors.grey.shade800),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: isActive ? const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF4ECDC4),
          size: 14,
        ) : null,
        onTap: onTap != null ? () {
          Navigator.of(context).pop();
          onTap();
        } : null,
      ),
    );
  }

  void _navigateToHome() {
    // すべてのルートをクリアしてホーム画面に戻る
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  void _navigateToSearch() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _navigateToMylist() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _navigateToDataImport() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DataImportScreen()),
    );
  }

  void _navigateToStarDashboard() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const StarDashboardScreen()),
    );
  }

  void _navigateToPlanManagement() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const FanSubscriptionScreen()),
    );
  }

  void _navigateToProfile() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
} 