import 'package:file_state_manager/file_state_manager.dart';

///
/// This package manages multiple flags identified by name and supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2023-06-19 20:33:27
///
class FlagManager extends CloneableFile {
  static const String className = 'FlagManager';
  static const String version = '3';
  final Map<String, bool> _map = {};
  static const String _saveKey = 'map';

  /// Constructor
  FlagManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  FlagManager.fromDict(Map<String, dynamic> src) {
    for (String i in src[_saveKey].keys) {
      setFlag(i, src[_saveKey][i] as bool);
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  @override
  FlagManager clone() {
    return FlagManager.fromDict(toDict());
  }

  /// (en)Convert the object to a dictionary.
  ///
  /// (ja)このクラスを辞書に変換します。
  ///
  /// * [nonSaveKeys] : If you specify a key that you don't want saved,
  /// that key and its contents will not be converted to a dictionary.
  @override
  Map<String, dynamic> toDict({List<String>? nonSaveKeys}) {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    Map<String, bool> mMap = {};
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
  /// * [initialValue] : Initial value. Applies only when first created.
  /// * [isAlwaysInitialize] : If true, always set initialValue.
  bool getFlag(String name,
      {bool initialValue = false, bool isAlwaysInitialize = false}) {
    if (_map.containsKey(name)) {
      if (isAlwaysInitialize) {
        _map[name] = initialValue;
      }
      return _map[name]!;
    } else {
      _map[name] = initialValue;
      return _map[name]!;
    }
  }

  /// (en) If an variable with the specified name has already been created,
  /// value is assigned to it, otherwise value is assigned to a newly created variable.
  ///
  /// (ja)指定名の変数が生成済みならばそれに代入し、無ければ新規生成した変数に代入します。
  void setFlag(String name, bool value) {
    _map[name] = value;
  }

  /// (en)Returns a managed map.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, bool> getMap() {
    return _map;
  }
}
