import 'package:flutter_test/flutter_test.dart';
import 'package:system_design/common.dart';

/// **What reaches the crash reporter, and as which kind.**
///
/// A breadcrumb carries the flow and the message and never the data, because
/// a release build sends it; an uncaught error is fatal and a caught one is
/// not, because that is what the crash-free rate counts.
const String _logTag = 'Order';

class _RecordingReporter extends SdCrashReporter {
  final List<String> errors = <String>[];
  final List<String> fatals = <String>[];
  final List<String> breadcrumbs = <String>[];

  @override
  void recordError(String reason, {Object? error, StackTrace? stackTrace}) =>
      errors.add(reason);

  @override
  void recordFatal(String reason, {Object? error, StackTrace? stackTrace}) =>
      fatals.add(reason);

  @override
  void log(String message) => breadcrumbs.add(message);

  @override
  void setUserId(String? uid) {}
}

/// Relies on the contract's own `recordFatal`, the way an app that never
/// overrode it would.
class _ErrorOnlyReporter extends SdCrashReporter {
  final List<String> errors = <String>[];

  @override
  void recordError(String reason, {Object? error, StackTrace? stackTrace}) =>
      errors.add(reason);

  @override
  void setUserId(String? uid) {}
}

void main() {
  setUp(() => SdLogger.enabled = false);
  tearDown(SdCrashReporter.detach);

  test('action, info and warning leave a breadcrumb without the data', () {
    final _RecordingReporter reporter = _RecordingReporter();

    SdCrashReporter.attach(reporter);
    SdLogger.action(_logTag, 'Ship order', <String, String>{'id': 'ord-4'});
    SdLogger.info(_logTag, 'Order shipped', <String, String>{'id': 'ord-4'});
    SdLogger.warning(_logTag, 'Retry', <String, int>{'attempt': 2});
    SdLogger.debug(_logTag, 'Detail', <String, int>{'n': 1});

    expect(reporter.breadcrumbs, <String>[
      'Order - Ship order',
      'Order - Order shipped',
      'Order - Retry',
    ]);
  });

  test('error is non-fatal and fatal is fatal', () {
    final _RecordingReporter reporter = _RecordingReporter();

    SdCrashReporter.attach(reporter);
    SdLogger.error(_logTag, 'Save failed', error: StateError('x'));
    SdLogger.fatal(_logTag, 'Uncaught', error: StateError('y'));

    expect(reporter.errors, <String>['Order - Save failed']);
    expect(reporter.fatals, <String>['Order - Uncaught']);
  });

  test('a reporter with no fatal kind still sees the failure', () {
    final _ErrorOnlyReporter reporter = _ErrorOnlyReporter();

    SdCrashReporter.attach(reporter);
    SdLogger.fatal(_logTag, 'Uncaught', error: StateError('y'));

    expect(reporter.errors, <String>['Order - Uncaught']);
  });
}
