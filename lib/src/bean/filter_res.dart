/// code : 0
/// name : "不限"

/// 通用筛选项
class FilterBean {
  String? _id;
  String? _name;
  bool isSelect = false; // 是否选择
  bool isOpen = false; // 是否展开
  String? _scale;

  String? get id => _id;

  String? get name => _name;

  String? get scale => _scale;

  FilterBean({String? id, String? name, String? scale,this.isSelect = false}) {
    _id = id;
    _name = name;
    _scale = scale;
  }

  FilterBean.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _scale = json['scale'] ?? "";
    isSelect = false;
    isOpen = false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['isSelect'] = isSelect;
    map['isOpen'] = isOpen;
    map['isSelect'] = isOpen;
    return map;
  }
}
