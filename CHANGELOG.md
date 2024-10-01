## 6.0.1

* Fixed link of SpWML in README.

## 6.0.0

* Added SelectionManager and MultiSelectionManager.
* Added SelectionManager and MultiSelectionManager support to StateManager.
* The descriptions of some class have been improved.

## 5.0.0

* The equals operator has been overridden in all manager classes except SingletonStateManager.
* The hashCode getter has been overridden in all manager classes except SingletonStateManager.
* With the above changes, users can now take advantage of the new automatic diff checking feature in the [file_state_manager](https://pub.dev/packages/file_state_manager) package.

## 4.0.0

* All manager classes except SingletonStateManager extended [CloneableFile](https://github.com/MasahideMori-SimpleAppli/file_state_manager/blob/main/lib/src/cloneable_file.dart). This makes it possible to undo and redo using the [file_state_manager](https://pub.dev/packages/file_state_manager) package.
* Due to the above changes, the copy method has been removed. Please use the clone method instead.
* One thing to note about this change is that the manager does not preserve state regarding text focus. Only serialized information supports Undo and Redo.

## 3.1.0

* Added SingletonStateManager class.

## 3.0.0

* Added StateManager class. This class is a manager class that includes all the manager classes in this package and is easy to use.
* For IndexManager and TextFieldManager, the keys when saving have changed, and the data structure has been changed to be similar to other manager classes. Please be careful if you are dealing with these directly in the backend.
* Added setText and getText method to TextFieldManager.

## 2.0.0

* The fromDict method has been changed to a named constructor.
* Added copy method.

## 1.0.0

* The default value that can be obtained from ValueManager has been changed to null.

## 0.0.1

* Initial release.
* [TextfieldManager](https://pub.dev/packages/textfield_manager) and [IndexManager](https://pub.dev/packages/index_manager) have been merged into this package
* The getAllIndex method of IndexManager has been deleted and replaced with the getMap method.
