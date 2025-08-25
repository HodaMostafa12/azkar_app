import 'package:supabase_flutter/supabase_flutter.dart';
import 'model/auth-model.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<UserModel?> signUp(String email, String password, String username) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': username}, // Use 'display_name' to show up in the dashboard
    );

    if (response.user != null) {
      return UserModel(
        id: response.user!.id,
        email: response.user!.email ?? '',
        username: response.user!.userMetadata?['display_name'] ?? '', // Access using 'display_name'
      );
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return UserModel(
          id: response.user!.id,
          email: response.user!.email ?? '',
          username: response.user!.userMetadata?['display_name'] ?? '', // Access using 'display_name'
        );
      }
      return null;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع");
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  UserModel? getCurrentUser() {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      return UserModel(
        id: user.id,
        email: user.email ?? '',
        username: user.userMetadata?['display_name'] ?? '', // Access using 'display_name'
      );
    }
    return null;
  }
}
