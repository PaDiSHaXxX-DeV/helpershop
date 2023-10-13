const String tableName = "SalesHelper";

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    id, code, count
  ];
  static const String id = "_id";
  static const String code = "code";
  static const String count = "count";
}

class ProductModel {
  ProductModel({required this.code, required this.count, this.id});
  int? id;
  String code;
  String count;

  ProductModel copyWith({
    int? id,
    String? code,
    String? count,
  }) =>
      ProductModel(
        id: id ?? this.id,
        code: code ?? this.code,
        count: count ?? this.count,
      );
  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      code: jsonData['code'] as String? ?? '',
      count: jsonData['count'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['count'] = count;
    return map;
  }
}
