// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/common_rule.dart';
import '../../rule_utils.dart';

part 'utils/config_parser.dart';
part 'visitor.dart';

class BanNameRule extends CommonRule {
  static const String ruleId = 'ban-name';

  final List<_BanNameConfigEntry> _entries;

  BanNameRule([Map<String, Object> config = const {}])
      : _entries = _ConfigParser._parseEntryConfig(config),
        super(
          id: ruleId,
          severity: readSeverity(config, Severity.style),
          excludes: readExcludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final visitor = _Visitor(_entries);

    source.unit.visitChildren(visitor);

    return visitor.nodes
        .map(
          (node) => createIssue(
            rule: this,
            location: nodeLocation(node: node.node, source: source),
            message: node.message,
          ),
        )
        .toList(growable: false);
  }
}
