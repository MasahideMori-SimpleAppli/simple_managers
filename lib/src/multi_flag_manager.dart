///
/// This package manages multiple flag lists identified by name and supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2023-06-19 20:33:27
///
class MultiFlagManager {
  String get className => 'MultiFlagManager';

  String get version => '2';
  final Map<String, List<bool>> _map = {};
  static const String _saveKey = 'map';

  /// Constructor
  MultiFlagManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  MultiFlagManager.fromDict(Map<String, dynamic> src) {
    for (String i in src[_saveKey].keys) {
      List<bool> flags = [];
      for (bool j in src[_saveKey][i]) {
        flags.add(j);
      }
      setFlags(i, flags);
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  MultiFlagManager copy() {
    return MultiFlagManager.fromDict(toDict());
  }

  /// (en)Convert the object to a dictionary.
  ///
  /// (ja)このクラスを辞書に変換します。
  ///
  /// * [nonSaveKeys] : If you specify a key that you don't want saved,
  /// that key and its contents will not be converted to a dictionary.
  Map<String, dynamic> toDict({List<String>? nonSaveKeys}) {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    Map<String, List<bool>> mMap = {};
    for (String i in _map.keys) {
      if (nonSaveKeys != null) {
        if (!nonSaveKeys.contains(i)) {
          mMap[i] = _map[i]!;
        }
      } else {
        mMap[i] = _map[i]!;
      }
    }
    d[_saveKey] = mMap;
    return d;
  }

  /// (en)Returns an flag with the specified name if it has been generated,
  /// otherwise it is generated.
  ///
  /// (ja)指定名のフラグが生成済みならばそれを、無ければ生成して返します。
  ///
  /// * [name] : A unique name assigned to the flag.
  /// * [initialValues] : Initial value. Applies only when first created.
  /// If null, auto insert empty list.
  /// * [isAlwaysInitialize] : If true, always set initialValue.
  List<bool> getFlags(String name,
      {List<bool>? initialValues, bool isAlwaysInitialize = false}) {
    if (_map.containsKey(name)) {
      if (isAlwaysInitialize) {
        _map[name] = initialValues ?? [];
      }
      return _map[name]!;
    } else {
      _map[name] = initialValues ?? [];
      return _map[name]!;
    }
  }

  /// (en) If an variable with the specified name has already been created,
  /// value is assigned to it, otherwise value is assigned to a newly created variable.
  ///
  /// (ja)指定名の変数が生成済みならばそれに代入し、無ければ新規生成した変数に代入します。
  void setFlags(String name, List<bool> values) {
    _map[name] = values;
  }

  /// (en)Returns a managed map.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, List<bool>> getMap() {
    return _map;
  }
}
