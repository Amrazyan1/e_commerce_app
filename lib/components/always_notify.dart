import 'package:flutter/material.dart';

class AlwaysNotifyValueNotifier<T> extends ValueNotifier<T> {
  AlwaysNotifyValueNotifier(T value) : super(value);

  @override
  set value(T newValue) {
    super.value = newValue;
    notifyListeners(); // Always notify listeners, even if the value doesn't change
  }
}
