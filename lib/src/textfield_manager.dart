import 'package:flutter/material.dart';

///
/// This package makes it easier to manage the state of textfields.
///
/// Author Masahide Mori
///
/// First edition creation date 2022-11-05 23:49:27
///
class TextFieldManager {
  String get className => 'TextFieldManager';

  String get version => '5';
  final Map<String, TextEditingController> _ctrlMap = {};
  final Map<String, FocusNode> _focusMap = {};
  static const String _saveKey = 'text_map';

  /// Constructor
  TextFieldManager();

  /// (en)Restore this object from the dictionary.
  /// If data with the same key already exists, it will be overwritten.
  ///
  /// (ja)このクラスのtoDictで変換された辞書から、このクラスに設定されていた内容を復元します。
  /// * [src] : A dictionary made with toDict of this class.
  TextFieldManager.fromDict(Map<String, dynamic> src) {
    for (var i in src[_saveKey].keys) {
      getCtrl(i as String,
          initialText: src[_saveKey][i] as String, isAlwaysInitialize: true);
      getFocus(i);
    }
  }

  /// (en)Returns new manager that copied the contents of this manager.
  /// However, note that focus is not copied.
  ///
  /// (ja)このマネージャーの内容をコピーした新しいマネージャーを返します。
  /// ただし、フォーカスはコピーされないことに注意してください。
  TextFieldManager copy() {
    return TextFieldManager.fromDict(toDict());
  }

  /// (en)Convert the object to a dictionary.
  /// Be careful how you handle user data.
  ///
  /// (ja)このクラスを辞書に変換します。
  /// 簡単に変換できますが、変換されたユーザーデータの取り扱いには十分注意することをお勧めします。
  ///
  /// * [nonSaveKeys] : If you specify a key that you don't want saved,
  /// that key and its contents will not be converted to a dictionary.
  Map<String, dynamic> toDict({List<String>? nonSaveKeys}) {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    Map<String, String> textMap = {};
    for (String i in _ctrlMap.keys) {
      if (nonSaveKeys != null) {
        if (!nonSaveKeys.contains(i)) {
          textMap[i] = _ctrlMap[i]!.text;
        }
      } else {
        textMap[i] = _ctrlMap[i]!.text;
      }
    }
    d[_saveKey] = textMap;
    return d;
  }

  /// (en)Dispose all managed objects.
  /// Usually called inside the dispose of the widget.
  ///
  /// (ja)管理中の全てのオブジェクトを破棄します。
  /// 通常、ウィジェットのdispose内で呼び出します。
  void dispose() {
    for (TextEditingController i in _ctrlMap.values) {
      i.dispose();
    }
    for (FocusNode i in _focusMap.values) {
      i.dispose();
    }
    _ctrlMap.clear();
    _focusMap.clear();
  }

  /// (en)If the controller with the specified name has been created,
  /// return it, otherwise return newly created one.
  ///
  /// (ja)指定名のコントローラが生成済みならばそれを、無ければ生成して返します。
  ///
  /// * [name] : A unique name assigned to the TextEditingController.
  /// * [initialText] : Initial text for the controller.
  /// Applies only when first created.
  /// * [isAlwaysInitialize] : If true, always set initialText.
  /// If true and initialText is null, initialize by empty string.
  TextEditingController getCtrl(String name,
      {String? initialText, bool isAlwaysInitialize = false}) {
    if (_ctrlMap.containsKey(name)) {
      if (isAlwaysInitialize) {
        _ctrlMap[name]!.text = initialText ?? "";
      }
      return _ctrlMap[name]!;
    } else {
      TextEditingController r = TextEditingController(text: initialText);
      _ctrlMap[name] = r;
      return r;
    }
  }

  /// (en)If the FocusNode with the specified name has been created,
  /// return it, otherwise return newly created one.
  ///
  /// (ja)指定名のフォーカスノードが生成済みならばそれを、無ければ生成して返します。
  ///
  /// * [name] : A unique name assigned to the FocusNode.
  FocusNode getFocus(String name) {
    if (_focusMap.containsKey(name)) {
      return _focusMap[name]!;
    } else {
      FocusNode r = FocusNode();
      _focusMap[name] = r;
      return r;
    }
  }

  /// (en)Returns a map of managed controllers.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のコントローラのマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, TextEditingController> getAllCtrl() {
    return _ctrlMap;
  }

  /// (en)Returns a map of managed FocusNodes.
  /// Do not normally call this directly.
  ///
  /// (ja)管理中のフォーカスノードのマップを返します。
  /// 通常はこれを直接呼び出さないでください。
  Map<String, FocusNode> getALLFocus() {
    return _focusMap;
  }

  /// (en) Returns true if there is an empty string in the content of the controller under management,
  /// false if it does not exist.
  ///
  /// (ja) 管理中のコントローラの内容で空文字のものが存在するならtrue, 存在しない場合はfalseを返します。
  bool containsEmptyCtrl() {
    for (TextEditingController i in _ctrlMap.values) {
      if (i.text == "") {
        return true;
      }
    }
    return false;
  }
}
