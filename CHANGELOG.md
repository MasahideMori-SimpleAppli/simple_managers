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
