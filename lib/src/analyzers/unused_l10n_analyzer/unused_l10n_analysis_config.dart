import 'package:glob/glob.dart';

/// Represents converted unused localization config,
/// which contains parsed entities.
class UnusedL10nAnalysisConfig {
  final Iterable<Glob> globalExcludes;
  final RegExp classPattern;

  UnusedL10nAnalysisConfig(
    this.globalExcludes,
    String? classPattern,
  ) : classPattern = RegExp(classPattern ?? r'I18n$');
}
