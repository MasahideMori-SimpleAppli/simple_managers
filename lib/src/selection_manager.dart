import 'package:file_state_manager/file_state_manager.dart';

///
/// This class manages for single string values and
/// supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2024-08-31 22:14:24
///
class SelectionManager extends CloneableFile {
  static const String className = 'SelectionManager';
  static const String version = '1';
  final Map<String, String?> _map = {};
  static const String _saveKey = 'map';

  /// Constructor
  SelectionManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  SelectionManager.fromDict(Map<String, dynamic> src) {
    for (String i in src[_saveKey].keys) {
      getSelection(i,
          initialValue: src[_saveKey][i] as String?, isAlwaysInitialize: true);
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  @override
  SelectionManager clone() {
    return SelectionManager.fromDict(toDict());
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
    Map<String, String?> mMap = {};
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
  String? getSelection(String name,
      {String? initialValue, bool isAlwaysInitialize = false}) {
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
  void setSelection(String name, String? value) {
    _map[name] = value;
  }

  /// (en)Returns a managed map.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, String?> getMap() {
    return _map;
  }

  @override
  bool operator ==(Object other) {
    if (other is SelectionManager) {
      if (_map.length != other._map.length) {
        return false;
      }
      for (String key in _map.keys) {
        if (!other._map.containsKey(key) || _map[key] != other._map[key]) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    List<Object> objects = [UtilObjectHash.calcMap(_map)];
    return Object.hashAll(objects);
  }
}
