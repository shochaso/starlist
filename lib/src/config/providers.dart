import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabaseクライアントプロバイダー
final supabaseClientProvider = riverpod.Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
}); 