import 'package:file_state_manager/file_state_manager.dart';
import 'package:collection/collection.dart';

///
/// This class manages multiple flag lists identified by name and
/// supports serialization and deserialization.
///
/// Author Masahide Mori
///
/// First edition creation date 2023-06-19 20:33:27
///
class MultiFlagManager extends CloneableFile {
  static const String className = 'MultiFlagManager';
  static const String version = '6';
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
  @override
  MultiFlagManager clone() {
    return MultiFlagManager.fromDict(toDict());
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

  /// (en)Returns the value corresponding to the given name.
  ///
  /// (ja)指定名に対応する値を返します。
  ///
  /// * [name] : Target name.
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

  /// (en) Overwrites the value managed by this class that
  /// corresponds to the specified name.
  /// If it does not exist, it will be added.
  ///
  /// (ja)このクラスで管理中の、指定の名前に対応する値を上書きします。
  /// 存在しない場合は管理対象が追加されます。
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

  @override
  bool operator ==(Object other) {
    // 1. 同一参照なら即座に終了
    if (identical(this, other)) return true;
    // 2. 基本的な型チェック
    if (other is! MultiFlagManager) return false;
    if (_map.length != other._map.length) {
      return false;
    }
    for (String key in _map.keys) {
      if (!other._map.containsKey(key) ||
          !const ListEquality().equals(_map[key], other._map[key])) {
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
