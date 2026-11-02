import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SdTranslationV5 extends Equatable {
  final List<Locale> supportedLocales;

  final String path;

  final Locale defaultLocale;

  final List<String> languageCodes;

  const SdTranslationV5({
    required this.supportedLocales,
    required this.path,
    required this.defaultLocale,
    required this.languageCodes,
  });

  @override
  List<Object?> get props => [
    supportedLocales,
    path,
    defaultLocale,
    languageCodes,
  ];
}
