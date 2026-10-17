import 'package:equatable/equatable.dart';

class SdRouterV5 extends Equatable {
  const SdRouterV5({
    required this.name,
    required this.path,
    required this.fullPath,
  });

  /// The path segment for this route (e.g., 'login', 'home').

  final String path;

  /// A unique name for this route (e.g., 'loginRoute', 'homeRoute').
  final String name;

  /// The complete path to this route (e.g., '/auth/login', '/base/home').
  final String fullPath;

  @override
  List<Object?> get props => [path, name, fullPath];
}
