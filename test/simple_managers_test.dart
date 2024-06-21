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
}
