import 'package:picnic_app/core/domain/model/tree_node.dart';

extension TreeExtension<T extends TreeNode<T>> on T {
  /// Normalizes connections between tree nodes, updates [parent] field of this object
  /// and of all its children to the correct value
  T normalizeConnections({T? parent}) {
    final normalizedChildren = <T>[];
    var normalizedNode = copyWithChildren(normalizedChildren);
    if (parent != null) {
      normalizedNode = normalizedNode.copyWithParent(parent);
    }
    for (final child in children) {
      normalizedChildren.add(child.normalizeConnections(parent: normalizedNode));
    }
    return normalizedNode;
  }

  T _rebuildTreeWithReplacement(T newNode) {
    if (!hasParent) {
      return newNode;
    }
    final siblings = parent.children.toList();
    final nodeIndex = siblings.indexOf(this);
    siblings[nodeIndex] = newNode;
    final newParent = parent.copyWithChildren(siblings);
    return parent.rebuildTreeWithReplacement(newParent);
  }

  /// Returns new tree (starting from the root), in which this node is replaced by [newNode]
  T rebuildTreeWithReplacement(T newNode) {
    return _rebuildTreeWithReplacement(newNode).normalizeConnections();
  }

  /// Returns copy of the tree with [oldNode] replaced by [newNode], must be called on tree root.
  T replaceNode(T oldNode, T newNode) {
    if (hasParent || oldNode.root != this) {
      throw StateError('This function must be called on root node of [oldNode]');
    }
    return oldNode.rebuildTreeWithReplacement(newNode);
  }

  /// Check if [node] is part of the tree
  bool containsNode(T node) {
    return firstWhereOrNull((e) => e == node) != null;
  }

  T? firstWhereOrNull(bool Function(T element) test) {
    if (test(this)) {
      return this;
    }

    for (final child in children) {
      final childResult = child.firstWhereOrNull(test);
      if (childResult != null) {
        return childResult;
      }
    }

    return null;
  }
}
