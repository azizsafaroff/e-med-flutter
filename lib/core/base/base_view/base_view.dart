import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emed/core/widgets/emed_text.dart';
import 'package:flutter/material.dart';

class BaseView<T> extends StatefulWidget {
  final T? viewModal;
  final Widget Function(BuildContext context, T value)? onPageBuilder;
  final Function(T model)? onModelReady;
  final VoidCallback? onDispose;
  const BaseView({
    Key? key,
    required this.viewModal,
    required this.onPageBuilder,
    this.onModelReady,
    this.onDispose,
  }) : super(key: key);
  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  StreamSubscription? subscription;
  var internetStatus;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        internetStatus = result;
      });
    });
    if (widget.onModelReady != null) widget.onModelReady!(widget.viewModal);
  }

  @override
  Widget build(BuildContext context) {
    return internetStatus == ConnectivityResult.none
        ? Scaffold(
            body: Center(
                child: EmedText(
              text: 'NO INTERNET',
            )),
          )
        : widget.onPageBuilder!(context, widget.viewModal);
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
    if (widget.onDispose != null) widget.onDispose!();
  }
}
