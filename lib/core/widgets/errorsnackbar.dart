import 'package:flutter/material.dart';

showErrorSnackBar(context, String msg) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Error: $msg")));
}
