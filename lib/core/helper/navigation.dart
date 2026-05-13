import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  // تعديل: إضافة قيمة افتراضية للـ predicate لحذف كل ما سبق
  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    RoutePredicate? predicate,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false, // إذا لم نرسل شرط، سيحذف كل الشاشات
      arguments: arguments,
    );
  }

  void pop() => Navigator.of(this).pop();
}