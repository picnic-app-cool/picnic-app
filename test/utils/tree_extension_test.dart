import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/tree_node.dart';
import 'package:picnic_app/utils/extensions/tree_extension.dart';

void main() {
  test("normalizeConnections fixes parent references", () {
    void checkParents(
      TestTreeNode node, {
      TestTreeNode parent = const TestTreeNode.none(),
      required int level,
    }) {
      if (node.parent != parent) {
        throw TestFailure('Parent is incorrect for node "${node.testLabel}" on level $level');
      }
      for (final child in node.children) {
        checkParents(
          child,
          parent: node,
          level: level + 1,
        );
      }
    }

    final tree = const TestTreeNode.root(
      children: [
        TestTreeNode(
          testLabel: '0',
          children: [],
          parent: TestTreeNode.none(),
        ),
        TestTreeNode(
          testLabel: '1',
          children: [
            TestTreeNode(
              testLabel: '1-0',
              children: [
                TestTreeNode(
                  testLabel: '1-0-0',
                  children: [],
                  parent: TestTreeNode.none(),
                ),
              ],
              parent: TestTreeNode.none(),
            ),
          ],
          parent: TestTreeNode.none(),
        ),
      ],
    ).normalizeConnections();

    checkParents(tree, level: 0);
  });

  test("replaceNode & rebuildTreeWithReplacement replace node correctly", () {
    final firstTree = const TestTreeNode.root(
      children: [
        TestTreeNode(
          testLabel: '0',
          children: [],
          parent: TestTreeNode.none(),
        ),
        TestTreeNode(
          testLabel: '1',
          children: [
            TestTreeNode(
              testLabel: '1-0 [FROM]',
              children: [],
              parent: TestTreeNode.none(),
            ),
          ],
          parent: TestTreeNode.none(),
        ),
      ],
    ).normalizeConnections();

    const replaceTo = TestTreeNode(
      testLabel: '1-0 [TO]',
      children: [
        TestTreeNode(
          testLabel: '1-0-0',
          children: [],
          parent: TestTreeNode.none(),
        ),
      ],
      parent: TestTreeNode.none(),
    );

    final secondTree = const TestTreeNode.root(
      children: [
        TestTreeNode(
          testLabel: '0',
          children: [],
          parent: TestTreeNode.none(),
        ),
        TestTreeNode(
          testLabel: '1',
          children: [replaceTo],
          parent: TestTreeNode.none(),
        ),
      ],
    ).normalizeConnections();

    expect(
      firstTree.children[1].children[0].rebuildTreeWithReplacement(replaceTo),
      secondTree,
    );

    expect(
      firstTree.replaceNode(firstTree.children[1].children[0], replaceTo),
      secondTree,
    );
  });

  test("firstWhereOrNull finds node correctly", () {
    final tree = const TestTreeNode.root(
      testLabel: 'r',
      children: [
        TestTreeNode(
          testLabel: '0',
          children: [],
          parent: TestTreeNode.none(),
        ),
        TestTreeNode(
          testLabel: '1',
          children: [
            TestTreeNode(
              testLabel: '1-0',
              children: [],
              parent: TestTreeNode.none(),
            ),
          ],
          parent: TestTreeNode.none(),
        ),
      ],
    ).normalizeConnections();

    expect(tree.firstWhereOrNull((e) => e.testLabel == 'r'), tree);
    expect(tree.firstWhereOrNull((e) => e.testLabel == '0'), tree.children[0]);
    expect(tree.firstWhereOrNull((e) => e.testLabel == '1'), tree.children[1]);
    expect(tree.firstWhereOrNull((e) => e.testLabel == '1-0'), tree.children[1].children[0]);
    expect(tree.firstWhereOrNull((e) => e.testLabel == 'incorrect'), null);
  });
}

class TestTreeNode extends TreeNode<TestTreeNode> with EquatableMixin {
  const TestTreeNode({
    required this.testLabel,
    required this.children,
    required TestTreeNode parent,
  }) : _parent = parent;

  const TestTreeNode.root({
    required this.children,
    this.testLabel = 'root',
  }) : _parent = null;

  const TestTreeNode.none()
      : children = const [],
        _parent = null,
        testLabel = '';

  final String testLabel;

  @override
  final List<TestTreeNode> children;

  final TestTreeNode? _parent;

  @override
  TestTreeNode get parent => _parent ?? const TestTreeNode.none();

  @override
  bool get hasParent => parent != const TestTreeNode.none();

  @override
  TestTreeNode copyWithChildren(List<TestTreeNode> children) {
    return TestTreeNode(testLabel: testLabel, children: children, parent: parent);
  }

  @override
  TestTreeNode copyWithParent(TestTreeNode parent) {
    return TestTreeNode(testLabel: testLabel, children: children, parent: parent);
  }

  @override
  String toString() => 'TestTreeNode "$testLabel", ${children.length} children';

  @override
  List<Object?> get props => [testLabel, children, _parent?.testLabel];
}
