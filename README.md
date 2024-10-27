# simple_managers

## Overview
A package containing multiple manager classes that support serialization.
It currently contains the following manager classes
* FlagManager: Manager of a single flag, such as a switch button.
* IndexManager: Manager for single index values such as drop-down lists.
* TagSelectionManager: Manager for single string tag values.
* MultiFlagManager: Manager of a multi flag, such as a checkbox.
* MultiIndexManager: Manager for multi index set such as segmented button.
* MultiTagSelectionManager: Manager for multi string tag set.
* TextFieldManager: Text-editing controller and focus manager.
* ValueManager: Manager of a single floating point number.
* StateManager: A manager class that has all the manager classes inside it. This is especially useful when using [SpWML](https://pub.dev/packages/simple_widget_markup).
* SingletonStateManager: A singleton class wrapping the StateManager that allows you to easily save and restore the state of your entire app, as long as you don't use duplicate keys anywhere in your app.

## Usage
This package contains several manager classes, but I will explain the text field manager, which has a slightly special usage.

```dart
TextFieldManager _tfm = TextFieldManager();

@override
void dispose() {
  _tfm.dispose();
  super.dispose();
}
```

Call getCtrl or getFocus method with name will internally create a new object if not yet created, or return the previously created one if already created.

```dart
TextField(
  focusNode: _tfm.getFocus("first"),
  controller: _tfm.getCtrl("first", initialText: "first"),
  onSubmitted: (String s) {
    _tfm.getFocus("second").requestFocus();
  }
)
```

## Serialization
Calling toDict will serialize all assigned data to a Map.
Additionally, information can be retrieved from maps created using fromDict.
In other words, the manager classes in this package make it easy to save input data to the server and restore it.

## Support
Basically no support.  
Please file an issue if you have any problems.  
This package is low priority, but may be fixed.

## About version control
The C part will be changed at the time of version upgrade.
- Changes such as adding variables, structure change that cause problems when reading previous files.
    - C.X.X
- Adding methods, etc.
    - X.C.X
- Minor changes and bug fixes.
    - X.X.C

If the version is less than 1, there may be major corrections and changes regardless of the above.

## License
This software is released under the MIT License, see LICENSE file.

## Copyright notice
The "Dart" name and "Flutter" name are trademarks of Google LLC.  
*The developer of this package is not Google LLC.