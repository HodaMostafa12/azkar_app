import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repository/azkar_model/azkar_model.dart';
import '../repository/azkar_repo.dart';

class AzkarViewModel extends ChangeNotifier {
  final AzkarRepository _repository = AzkarRepository();
  final SupabaseClient _supabase = Supabase.instance.client;

  List<AzkarModel> _azkar = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AzkarModel> get azkar => _azkar;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🟢 جلب البيانات من الريبو
  Future<void> getAzkar() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _azkar = await _repository.fetchAzkar();

      // ✨ جلب أذكار المستخدم من Supabase
      // ⚠️ يجب التأكد من وجود مستخدم مسجل الدخول قبل الاستعلام
      final userId = _supabase.auth.currentUser?.id;
      if (userId != null) {
        final userAzkar = await _supabase
            .from("azkar")
            .select()
            .eq('user_id', userId) // 👈 إضافة شرط لجلب أذكار المستخدم فقط
            .order('id', ascending: false);

        final List<AzkarModel> userAzkarList = userAzkar.map((e) => AzkarModel.fromJson(e)).toList();
        _azkar.insertAll(0, userAzkarList);
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 🟢 إضافة ذكر جديد إلى Supabase
  Future<void> addAzkar(String title, int count) async {
    try {
      // ⚠️ تأكد من وجود مستخدم مسجل الدخول
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        _errorMessage = "User not logged in.";
        notifyListeners();
        return;
      }

      final newItem = {
        "category": title,
        "audio": null,
        "filename": null,
        "array": [
          {
            "id": 1,
            "text": title,
            "count": count,
            "audio": null,
            "filename": null,
          }
        ],
        "user_id": userId, // ✨ ربط الذكر بالمستخدم
      };

      // ✨ إدخال في جدول azkar
      final response = await _supabase.from("azkar").insert(newItem).select();

      if (response.isNotEmpty) {
        // ✅ حوّل البيانات المضافة لموديل وادخلها في الليستة
        final model = AzkarModel.fromJson(response.first);
        _azkar.insert(0, model);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      print(e.toString());
      notifyListeners();
    }
  }

  /// 🟢 حذف ذكر من Supabase
  Future<void> deleteAzkar(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _supabase
          .from("azkar")
          .delete()
          .eq("id", id);

      // ✅ حذف العنصر من الليستة المحلية
      _azkar.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      print(e.toString());
    } finally {
      _isLoading = false;
    }
  }
}