import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_managers/simple_managers.dart';

void main() {
  group('FlagManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      FlagManager m = FlagManager();
      m.getFlag("first", initialValue: true, isAlwaysInitialize: true);
      m.getFlag("second", initialValue: false, isAlwaysInitialize: true);
      m.setFlag("third", true);
      expect(m.getFlag("first") == true, true);
      expect(m.getFlag("second") == false, true);
      Map<String, dynamic> mp = m.toDict(nonSaveKeys: ["second"]);
      m = FlagManager.fromDict(mp);
      expect((mp["map"] as Map).containsKey("first"), true);
      expect(!(mp["map"] as Map).containsKey("second"), true);
      expect((mp["map"] as Map)["first"] == true, true);
      // jsonEncode and jsonDecode
      String t = jsonEncode(m.toDict());
      final FlagManager imDecoded = FlagManager.fromDict(jsonDecode(t));
      Map<String, bool> decoded = imDecoded.getMap();
      expect(decoded["first"] == true, true);
      expect(decoded["third"] == true, true);
    });
  });
  group('IndexManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      IndexManager im = IndexManager();
      im.getIndex("first", initialValue: null, isAlwaysInitialize: true);
      im.getIndex("second", initialValue: 2, isAlwaysInitialize: true);
      im.setIndex("third", 3);
      expect(im.getIndex("first") == null, true);
      expect(im.getIndex("second") == 2, true);
      Map<String, dynamic> m = im.toDict(nonSaveKeys: ["second"]);
      im = IndexManager.fromDict(m);
      expect((m["map"] as Map).containsKey("first"), true);
      expect(!(m["map"] as Map).containsKey("second"), true);
      expect((m["map"] as Map)["first"] == null, true);

      // jsonEncode and jsonDecode
      String t = jsonEncode(im.toDict());
      final IndexManager imDecoded = IndexManager.fromDict(jsonDecode(t));
      Map<String, int?> decoded = imDecoded.getMap();
      expect(decoded["first"] == null, true);
      expect(decoded["third"] == 3, true);
    });
  });
  group('MultiFlagManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      MultiFlagManager m = MultiFlagManager();
      m.getFlags("first", isAlwaysInitialize: true);
      m.getFlags("second", initialValues: [false], isAlwaysInitialize: true);
      m.setFlags("third", [true]);
      expect(m.getFlags("first").isEmpty, true);
      expect(m.getFlags("second")[0] == false, true);
      Map<String, dynamic> mp = m.toDict(nonSaveKeys: ["second"]);
      m = MultiFlagManager.fromDict(mp);
      expect((mp["map"] as Map).containsKey("first"), true);
      expect(!(mp["map"] as Map).containsKey("second"), true);
      expect(((mp["map"] as Map)["first"] as List).isEmpty, true);
      // jsonEncode and jsonDecode
      String t = jsonEncode(m.toDict());
      final MultiFlagManager imDecoded =
          MultiFlagManager.fromDict(jsonDecode(t));
      Map<String, List<bool>> decoded = imDecoded.getMap();
      expect(decoded["first"]!.isEmpty, true);
      expect(decoded["third"]![0] == true, true);
    });
  });
  group('MultiIndexManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      MultiIndexManager im = MultiIndexManager();
      im.getIndexSet("first", isAlwaysInitialize: true);
      im.getIndexSet("second", initialValue: {2}, isAlwaysInitialize: true);
      im.setIndexSet("third", {3});
      expect(im.getIndexSet("first").isEmpty, true);
      expect(im.getIndexSet("second").contains(2), true);
      Map<String, dynamic> m = im.toDict(nonSaveKeys: ["second"]);
      im = MultiIndexManager.fromDict(m);
      expect((m["map"] as Map).containsKey("first"), true);
      expect(!(m["map"] as Map).containsKey("second"), true);
      expect(((m["map"] as Map)["first"] as List).isEmpty, true);
      // jsonEncode and jsonDecode
      String t = jsonEncode(im.toDict());
      final MultiIndexManager imDecoded =
          MultiIndexManager.fromDict(jsonDecode(t));
      Map<String, Set<int>> decoded = imDecoded.getMap();
      expect(decoded["first"]!.isEmpty, true);
      expect(decoded["third"]!.contains(3), true);
    });
  });
  group('TextFieldManager test', () {
    test('toDict and fromDict test', () {
      TextFieldManager tfm = TextFieldManager();
      tfm.getCtrl("first", initialText: "1", isAlwaysInitialize: true);
      tfm.getCtrl("second", initialText: "2", isAlwaysInitialize: true);
      Map<String, dynamic> map = tfm.toDict(nonSaveKeys: ["second"]);
      tfm.getCtrl("first").text = "first";
      tfm = TextFieldManager.fromDict(map);
      expect(tfm.getCtrl("first").text == "1", true);
      expect((map["map"] as Map).containsKey("first"), true);
      expect(!(map["map"] as Map).containsKey("second"), true);
      // function check
      tfm.getCtrl("first", initialText: "", isAlwaysInitialize: true);
      expect(tfm.containsEmptyCtrl(), true);
      tfm.getCtrl("first", initialText: "1", isAlwaysInitialize: true);
      expect(tfm.containsEmptyCtrl(), false);
    });
  });
  group('ValueManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      ValueManager m = ValueManager();
      m.getValue("first", initialValue: null, isAlwaysInitialize: true);
      m.getValue("second", initialValue: 2, isAlwaysInitialize: true);
      m.setValue("third", 3);
      expect(m.getValue("first") == null, true);
      expect(m.getValue("second") == 2, true);
      Map<String, dynamic> mp = m.toDict(nonSaveKeys: ["second"]);
      m = ValueManager.fromDict(mp);
      expect((mp["map"] as Map).containsKey("first"), true);
      expect(!(mp["map"] as Map).containsKey("second"), true);
      expect((mp["map"] as Map)["first"] == null, true);
      // jsonEncode and jsonDecode
      String t = jsonEncode(m.toDict());
      final ValueManager imDecoded = ValueManager.fromDict(jsonDecode(t));
      Map<String, double?> decoded = imDecoded.getMap();
      expect(decoded["first"] == null, true);
      expect(decoded["third"] == 3, true);
    });
  });

  group('StateManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      StateManager sm = StateManager();
      sm.fm.setFlag("a", true);
      sm.im.setIndex("a", 1);
      sm.mfm.setFlags("a", [true]);
      sm.mim.setIndexSet("a", {1});
      sm.tfm.setText("a", "b");
      sm.vm.setValue("a", 1.0);
      Map<String, dynamic> mp = sm.toDict();
      sm = StateManager.fromDict(mp);
      expect(sm.fm.getFlag("a") == true, true);
      expect(sm.im.getIndex("a") == 1, true);
      expect(sm.mfm.getFlags("a").first == true, true);
      expect(sm.mim.getIndexSet("a").first == 1, true);
      expect(sm.tfm.getText("a") == "b", true);
      expect(sm.vm.getValue("a") == 1.0, true);
    });
  });

  group('SingletonStateManager test', () {
    test('toDict and fromDict test', () {
      // normal test
      StateManager sm = SingletonStateManager().getSM();
      sm.fm.setFlag("a", true);
      sm.im.setIndex("a", 1);
      sm.mfm.setFlags("a", [true]);
      sm.mim.setIndexSet("a", {1});
      sm.tfm.setText("a", "b");
      sm.vm.setValue("a", 1.0);
      Map<String, dynamic> mp = SingletonStateManager().toDict();
      sm = SingletonStateManager().fromDict(mp).getSM();
      expect(sm.fm.getFlag("a") == true, true);
      expect(sm.im.getIndex("a") == 1, true);
      expect(sm.mfm.getFlags("a").first == true, true);
      expect(sm.mim.getIndexSet("a").first == 1, true);
      expect(sm.tfm.getText("a") == "b", true);
      expect(sm.vm.getValue("a") == 1.0, true);
    });
  });

  group('General test', () {
    test('equals test', () {
      // normal test
      StateManager sm = StateManager();
      sm.fm.setFlag("a", true);
      sm.im.setIndex("a", 1);
      sm.mfm.setFlags("a", [true]);
      sm.mim.setIndexSet("a", {1});
      sm.tfm.setText("a", "b");
      sm.vm.setValue("a", 1.0);
      StateManager sm2 = StateManager();
      sm2.fm.setFlag("a", true);
      sm2.im.setIndex("a", 1);
      sm2.mfm.setFlags("a", [true]);
      sm2.mim.setIndexSet("a", {1});
      sm2.tfm.setText("a", "b");
      sm2.vm.setValue("a", 1.0);
      StateManager sm3 = StateManager();
      sm3.fm.setFlag("a", false);
      sm3.im.setIndex("a", 2);
      sm3.mfm.setFlags("a", [false]);
      sm3.mim.setIndexSet("a", {2});
      sm3.tfm.setText("a", "c");
      sm3.vm.setValue("a", 2.0);
      StateManager sm4 = StateManager();
      sm4.mfm.setFlags("a", [true, false]);
      sm4.mim.setIndexSet("a", {1, 2});
      StateManager sm5 = StateManager();
      sm5.fm.setFlag("b", true);
      sm5.im.setIndex("b", 1);
      sm5.mfm.setFlags("b", [true]);
      sm5.mim.setIndexSet("b", {1});
      sm5.tfm.setText("b", "b");
      sm5.vm.setValue("b", 1.0);
      expect(sm.fm == sm2.fm, true);
      expect(sm.fm == sm3.fm, false);
      expect(sm.fm == sm5.fm, false);
      expect(sm.im == sm2.im, true);
      expect(sm.im == sm3.im, false);
      expect(sm.im == sm5.im, false);
      expect(sm.mfm == sm2.mfm, true);
      expect(sm.mfm == sm3.mfm, false);
      expect(sm.mfm == sm4.mfm, false);
      expect(sm.mfm == sm5.mfm, false);
      expect(sm.mim == sm2.mim, true);
      expect(sm.mim == sm3.mim, false);
      expect(sm.mim == sm4.mim, false);
      expect(sm.mim == sm5.mim, false);
      expect(sm.tfm == sm2.tfm, true);
      expect(sm.tfm == sm3.tfm, false);
      expect(sm.tfm == sm5.tfm, false);
      expect(sm.vm == sm2.vm, true);
      expect(sm.vm == sm3.vm, false);
      expect(sm.vm == sm5.vm, false);
    });

    test('hash code test', () {
      // normal test
      StateManager sm = StateManager();
      sm.fm.setFlag("a", true);
      sm.im.setIndex("a", 1);
      sm.mfm.setFlags("a", [true]);
      sm.mim.setIndexSet("a", {1});
      sm.tfm.setText("a", "b");
      sm.vm.setValue("a", 1.0);
      StateManager sm2 = StateManager();
      sm2.fm.setFlag("a", true);
      sm2.im.setIndex("a", 1);
      sm2.mfm.setFlags("a", [true]);
      sm2.mim.setIndexSet("a", {1});
      sm2.tfm.setText("a", "b");
      sm2.vm.setValue("a", 1.0);
      StateManager sm3 = StateManager();
      sm3.fm.setFlag("a", false);
      sm3.im.setIndex("a", 2);
      sm3.mfm.setFlags("a", [false]);
      sm3.mim.setIndexSet("a", {2});
      sm3.tfm.setText("a", "c");
      sm3.vm.setValue("a", 2.0);
      StateManager sm4 = StateManager();
      sm4.mfm.setFlags("a", [true, false]);
      sm4.mim.setIndexSet("a", {1, 2});
      StateManager sm5 = StateManager();
      sm5.fm.setFlag("b", true);
      sm5.im.setIndex("b", 1);
      sm5.mfm.setFlags("b", [true]);
      sm5.mim.setIndexSet("b", {1});
      sm5.tfm.setText("b", "b");
      sm5.vm.setValue("b", 1.0);
      expect(sm.fm.hashCode == sm2.fm.hashCode, true);
      expect(sm.fm.hashCode == sm3.fm.hashCode, false);
      expect(sm.fm.hashCode == sm5.fm.hashCode, false);
      expect(sm.im.hashCode == sm2.im.hashCode, true);
      expect(sm.im.hashCode == sm3.im.hashCode, false);
      expect(sm.im.hashCode == sm5.im.hashCode, false);
      expect(sm.mfm.hashCode == sm2.mfm.hashCode, true);
      expect(sm.mfm.hashCode == sm3.mfm.hashCode, false);
      expect(sm.mfm.hashCode == sm4.mfm.hashCode, false);
      expect(sm.mfm.hashCode == sm5.mfm.hashCode, false);
      expect(sm.mim.hashCode == sm2.mim.hashCode, true);
      expect(sm.mim.hashCode == sm3.mim.hashCode, false);
      expect(sm.mim.hashCode == sm4.mim.hashCode, false);
      expect(sm.mim.hashCode == sm5.mim.hashCode, false);
      expect(sm.tfm.hashCode == sm2.tfm.hashCode, true);
      expect(sm.tfm.hashCode == sm3.tfm.hashCode, false);
      expect(sm.tfm.hashCode == sm5.tfm.hashCode, false);
      expect(sm.vm.hashCode == sm2.vm.hashCode, true);
      expect(sm.vm.hashCode == sm3.vm.hashCode, false);
      expect(sm.vm.hashCode == sm5.vm.hashCode, false);
    });
  });
}
