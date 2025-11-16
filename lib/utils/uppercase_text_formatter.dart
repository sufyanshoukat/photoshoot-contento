import 'package:flutter/services.dart';

/// A reusable TextInputFormatter that converts input to uppercase while
/// preserving the cursor position as best as possible.
class UpperCaseTextFormatter extends TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.toUpperCase();

    // Preserve selection offsets, but clamp within newText length
    int baseOffset = newValue.selection.baseOffset;
    int extentOffset = newValue.selection.extentOffset;

    baseOffset = baseOffset.clamp(0, newText.length);
    extentOffset = extentOffset.clamp(0, newText.length);

    return TextEditingValue(
      text: newText,
      selection:
          TextSelection(baseOffset: baseOffset, extentOffset: extentOffset),
      composing: TextRange.empty,
    );
  }
}
