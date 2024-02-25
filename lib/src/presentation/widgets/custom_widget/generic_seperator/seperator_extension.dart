import 'package:flutter/material.dart';

extension IterableExt on Iterable<Widget> {
  Iterable<Widget> toAddSeparator({
    required Widget separator,
  }) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield separator;
        yield iterator.current;
      }
    }
  }
}
