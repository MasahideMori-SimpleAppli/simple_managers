import 'package:file_state_manager/file_state_manager.dart';

///
/// This class manages multiple indexes identified by name and
/// supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2023-05-29 20:56:54
///
class IndexManager extends CloneableFile {
  static const String className = 'IndexManager';
  static const String version = '9';
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

  /// (en)Returns the value corresponding to the given name.
  ///
  /// (ja)指定名に対応する値を返します。
  ///
  /// * [name] : Target name.
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

  /// (en) Overwrites the value managed by this class that
  /// corresponds to the specified name.
  /// If it does not exist, it will be added.
  ///
  /// (ja)このクラスで管理中の、指定の名前に対応する値を上書きします。
  /// 存在しない場合は管理対象が追加されます。
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

  @override
  bool operator ==(Object other) {
    // 1. 同一参照なら即座に終了
    if (identical(this, other)) return true;
    // 2. 基本的な型チェック
    if (other is! IndexManager) return false;
    if (_map.length != other._map.length) {
      return false;
    }
    for (String key in _map.keys) {
      if (!other._map.containsKey(key) || _map[key] != other._map[key]) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    List<Object> objects = [UtilObjectHash.calcMap(_map)];
    return Object.hashAll(objects);
  }
}
