import 'package:simple_managers/simple_managers.dart';

///
/// (en) This is a class that contains StateManager and operates as a singleton.
///
/// (ja) シングルトンで動作する、StateManagerを内包したクラスです。
///
/// Author Masahide Mori
///
/// First edition creation date 2023-06-21 20:12:59
///
class SingletonStateManager {
  late StateManager _sm;

  static final SingletonStateManager _instance =
      SingletonStateManager._internal();

  factory SingletonStateManager() {
    return _instance;
  }

  SingletonStateManager._internal() {
    _sm = StateManager();
  }

  /// (en) Gets the StateManager managed by this class.
  ///
  /// (ja) このクラスで管理されているStateManagerを取得します。
  StateManager getSM() {
    return _sm;
  }

  /// (en)Restore StateManager from the dictionary.
  ///
  /// (ja)辞書からStateManagerを復元します。
  /// * [src] : A dictionary made with toDict of this class.
  SingletonStateManager fromDict(Map<String, dynamic> src) {
    _sm = StateManager.fromDict(src);
    return this;
  }

  /// (en)Converts the StateManager managed by this class into a dictionary.
  ///
  /// (ja)このクラスで管理されているStateManagerを辞書に変換します。
  ///
  /// * [nonSaveKeys] : If you specify a key that you don't want saved,
  /// that key and its contents will not be converted to a dictionary.
  Map<String, dynamic> toDict({List<String>? nonSaveKeys}) {
    return _sm.toDict(nonSaveKeys: nonSaveKeys);
  }
}
