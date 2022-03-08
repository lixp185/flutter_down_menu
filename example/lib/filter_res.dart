/// code : 0
/// name : "不限"

/// 通用筛选项
class FilterRes {
  int? _code;
  String? _name;
  bool isSelect = false; // 是否选择
  bool isOpen = false; // 是否展开

  String? _scale;

  int? get code => _code;

  String? get name => _name;

  String? get scale => _scale;

  FilterRes({int? code, String? name, String? scale}) {
    _code = code;
    _name = name;
    _scale = scale;
  }

  FilterRes.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
    _scale = json['scale'] ?? "";
    isSelect = false;
    isOpen = false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['isSelect'] = isSelect;
    map['isOpen'] = isOpen;
    map['isSelect'] = isOpen;
    return map;
  }
}
