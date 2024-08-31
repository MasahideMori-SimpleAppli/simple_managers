import 'package:collection/collection.dart';
import 'package:file_state_manager/file_state_manager.dart';

///
/// This class manages multiple index set identified by name and
/// supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2023-06-19 21:06:43
///
class MultiIndexManager extends CloneableFile {
  static const String className = 'MultiIndexManager';
  static const String version = '5';
  final Map<String, Set<int>> _map = {};
  static const String _saveKey = 'map';

  /// Constructor
  MultiIndexManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  MultiIndexManager.fromDict(Map<String, dynamic> src) {
    for (String i in src[_saveKey].keys) {
      Set<int> values = {};
      for (int j in src[_saveKey][i]) {
        values.add(j);
      }
      setIndexSet(i, values);
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  @override
  MultiIndexManager clone() {
    return MultiIndexManager.fromDict(toDict());
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
    Map<String, List<int>> mMap = {};
    for (String i in _map.keys) {
      if (nonSaveKeys != null) {
        if (!nonSaveKeys.contains(i)) {
          mMap[i] = List.from(_map[i]!);
        }
      } else {
        mMap[i] = List.from(_map[i]!);
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
  /// If null, auto insert empty set.
  /// * [isAlwaysInitialize] : If true, always set initialValue.
  Set<int> getIndexSet(String name,
      {Set<int>? initialValue, bool isAlwaysInitialize = false}) {
    if (_map.containsKey(name)) {
      if (isAlwaysInitialize) {
        _map[name] = initialValue ?? {};
      }
      return _map[name]!;
    } else {
      _map[name] = initialValue ?? {};
      return _map[name]!;
    }
  }

  /// (en) Overwrites the value managed by this class that
  /// corresponds to the specified name.
  /// If it does not exist, it will be added.
  ///
  /// (ja)このクラスで管理中の、指定の名前に対応する値を上書きします。
  /// 存在しない場合は管理対象が追加されます。
  void setIndexSet(String name, Set<int> value) {
    _map[name] = value;
  }

  /// (en)Returns a managed map.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, Set<int>> getMap() {
    return _map;
  }

  @override
  bool operator ==(Object other) {
    if (other is MultiIndexManager) {
      if (_map.length != other._map.length) {
        return false;
      }
      for (String key in _map.keys) {
        if (!other._map.containsKey(key) ||
            !const SetEquality().equals(_map[key], other._map[key])) {
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
