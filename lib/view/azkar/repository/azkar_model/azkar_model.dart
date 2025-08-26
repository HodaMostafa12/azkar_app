// لا يوجد تغيير هنا
class AzkarModel {
  AzkarModel({
    required this.id,
    required this.category,
    required this.audio,
    required this.filename,
    required this.array,
    this.userId, // ✨ إضافة user_id
  });

  final int? id;
  final String? category;
  final String? audio;
  final String? filename;
  final List<Array> array;
  final String? userId; // ✨ إضافة user_id

  factory AzkarModel.fromJson(Map<String, dynamic> json){
    return AzkarModel(
      id: json["id"],
      category: json["category"],
      audio: json["audio"],
      filename: json["filename"],
      array: json["array"] == null ? [] : List<Array>.from(json["array"]!.map((x) => Array.fromJson(x))),
      userId: json["user_id"], // ✨ إضافة user_id
    );
  }
}
// لا يوجد تغيير هنا
class Array {
  Array({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  final int? id;
  final String? text;
  final int? count;
  final String? audio;
  final String? filename;

  factory Array.fromJson(Map<String, dynamic> json){
    return Array(
      id: json["id"],
      text: json["text"],
      count: json["count"],
      audio: json["audio"],
      filename: json["filename"],
    );
  }
}