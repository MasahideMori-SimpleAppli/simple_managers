import 'package:file_state_manager/file_state_manager.dart';

///
/// This package manages multiple indexes identified by name and supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2023-05-29 20:56:54
///
class IndexManager extends CloneableFile {
  static const String className = 'IndexManager';
  static const String version = '6';
  final Map<String, int?> _map = {};
  static const String _oldSaveKey = 'index_map';
  static const String _saveKey = 'map';

  /// Constructor
  IndexManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  IndexManager.fromDict(Map<String, dynamic> src) {
    if (src.containsKey(_oldSaveKey)) {
      for (String i in src[_oldSaveKey].keys) {
        getIndex(i,
            initialValue: src[_oldSaveKey][i] as int?,
            isAlwaysInitialize: true);
      }
    } else {
      for (String i in src[_saveKey].keys) {
        getIndex(i,
            initialValue: src[_saveKey][i] as int?, isAlwaysInitialize: true);
      }
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  @override
  IndexManager clone() {
    return IndexManager.fromDict(toDict());
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
    Map<String, int?> mMap = {};
    for (String i in _map.keys) {
      if (nonSaveKeys != null) {
        if (!nonSaveKeys.contains(i)) {
          mMap[i] = _map[i];
        }
      } else {
        mMap[i] = _map[i];
      }
    }
    d[_saveKey] = mMap;
    return d;
  }

  /// (en)Returns an index with the specified name if it has been generated,
  /// otherwise it is generated.
  ///
  /// (ja)指定名のインデックスが生成済みならばそれを、無ければ生成して返します。
  ///
  /// * [name] : A unique name assigned to the index.
  /// * [initialValue] : Initial value. Applies only when first created.
  /// * [isAlwaysInitialize] : If true, always set initialValue.
  int? getIndex(String name,
      {int? initialValue = 0, bool isAlwaysInitialize = false}) {
    if (_map.containsKey(name)) {
      if (isAlwaysInitialize) {
        _map[name] = initialValue;
      }
      return _map[name];
    } else {
      _map[name] = initialValue;
      return _map[name];
    }
  }

  /// (en) If an index variable with the specified name has already been created,
  /// value is assigned to it, otherwise value is assigned to a newly created variable.
  ///
  /// (ja)指定名のインデックス変数が生成済みならばそれに代入し、無ければ新規生成した変数に代入します。
  void setIndex(String name, int? value) {
    _map[name] = value;
  }

  /// (en)Returns a managed map.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, int?> getMap() {
    return _map;
  }
}
