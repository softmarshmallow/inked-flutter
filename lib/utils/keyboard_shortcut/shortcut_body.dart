import 'package:flutter/material.dart';
import 'package:inked/utils/keyboard_shortcut/keyboard_shortcut_handler.dart';

class ShortcutBody extends StatelessWidget{
  final List<ShortcutHandler> shortcutHandlers;
  final FocusNode _focusNode = FocusNode();
  final Widget body;
  ShortcutBody(this.body, {this.shortcutHandlers});

  BuildContext _context;

  requestFocus(){
    FocusScope.of(_context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    requestFocus();
    _context = context;
    return RawKeyboardListener(
      focusNode: _focusNode,
      child: body,
      onKey: (key) {
        if (key.runtimeType.toString() == 'RawKeyDownEvent') {
          String _keyCode = key.logicalKey.keyLabel;
          shortcutHandlers.forEach((element) {
            if(element.key == _keyCode){
              element.action.call();
            }
          });
        }
      },
    );
  }

}