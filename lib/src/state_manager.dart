import 'package:file_state_manager/file_state_manager.dart';

import 'package:simple_managers/simple_managers.dart';

///
/// This class is a manager class that includes all the manager classes in
/// this package and is easy to use.
///
/// Author Masahide Mori
///
/// First edition creation date 2024-04-14 13:28:35
///
class StateManager extends CloneableFile {
  static const className = 'StateManager';
  static const version = '7';
  static const String _saveKey = "map";

  FlagManager fm = FlagManager();
  IndexManager im = IndexManager();
  TagSelectionManager tsm = TagSelectionManager();
  MultiFlagManager mfm = MultiFlagManager();
  MultiIndexManager mim = MultiIndexManager();
  MultiTagSelectionManager mtsm = MultiTagSelectionManager();
  TextFieldManager tfm = TextFieldManager();
  ValueManager vm = ValueManager();

  /// Constructor
  StateManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  StateManager.fromDict(Map<String, dynamic> src) {
    for (String i in src[_saveKey].keys) {
      if (i == "flag_manager") {
        fm = FlagManager.fromDict(src[_saveKey]["flag_manager"]);
      } else if (i == "index_manager") {
        im = IndexManager.fromDict(src[_saveKey]["index_manager"]);
      } else if (i == "tag_selection_manager") {
        tsm = TagSelectionManager.fromDict(
            src[_saveKey]["tag_selection_manager"]);
      } else if (i == "multi_flag_manager") {
        mfm = MultiFlagManager.fromDict(src[_saveKey]["multi_flag_manager"]);
      } else if (i == "multi_index_manager") {
        mim = MultiIndexManager.fromDict(src[_saveKey]["multi_index_manager"]);
      } else if (i == "multi_tag_selection_manager") {
        mtsm = MultiTagSelectionManager.fromDict(
            src[_saveKey]["multi_tag_selection_manager"]);
      } else if (i == "textfield_manager") {
        tfm = TextFieldManager.fromDict(src[_saveKey]["textfield_manager"]);
      } else if (i == "value_manager") {
        vm = ValueManager.fromDict(src[_saveKey]["value_manager"]);
      }
      // old version (under v6.0.1)
      else if (i == "selection_manager") {
        tsm = TagSelectionManager.fromDict(src[_saveKey]["selection_manager"]);
      }
      // old version (under v7.0.0)
      else if (i == "multi_selection_manager") {
        mtsm = MultiTagSelectionManager.fromDict(
            src[_saveKey]["multi_selection_manager"]);
      }
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  /// However, note that focus of textfield is not copied.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  /// ただし、テキストフィールドのフォーカスはコピーされないことに注意してください。
  @override
  StateManager clone() {
    return StateManager.fromDict(toDict());
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
    Map<String, Map<String, dynamic>> mMap = {
      "flag_manager": fm.toDict(nonSaveKeys: nonSaveKeys),
      "index_manager": im.toDict(nonSaveKeys: nonSaveKeys),
      "tag_selection_manager": tsm.toDict(nonSaveKeys: nonSaveKeys),
      "multi_flag_manager": mfm.toDict(nonSaveKeys: nonSaveKeys),
      "multi_index_manager": mim.toDict(nonSaveKeys: nonSaveKeys),
      "multi_tag_selection_manager": mtsm.toDict(nonSaveKeys: nonSaveKeys),
      "textfield_manager": tfm.toDict(nonSaveKeys: nonSaveKeys),
      "value_manager": vm.toDict(nonSaveKeys: nonSaveKeys),
    };
    d[_saveKey] = mMap;
    return d;
  }

  /// (en)Dispose all managed objects.
  /// Usually called inside the dispose of the widget.
  /// This call only affects the internal TextFieldManager.
  ///
  /// (ja)管理中の全てのオブジェクトを破棄します。
  /// 通常、ウィジェットのdispose内で呼び出します。
  /// この呼び出しが影響するのは内部のTextFieldManagerのみです。
  void dispose() {
    tfm.dispose();
  }

  @override
  bool operator ==(Object other) {
    // 1. 同一参照なら即座に終了
    if (identical(this, other)) return true;
    // 2. 基本的な型チェック
    if (other is! StateManager) return false;
    if (fm != other.fm ||
        im != other.im ||
        tsm != other.tsm ||
        mfm != other.mfm ||
        mim != other.mim ||
        mtsm != other.mtsm ||
        tfm != other.tfm ||
        vm != other.vm) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    List<Object> objects = [fm, im, tsm, mfm, mim, mtsm, tfm, vm];
    return Object.hashAll(objects);
  }
}
