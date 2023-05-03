abstract class TreeNode<T extends TreeNode<T>> {
  const TreeNode();

  List<T> get children;

  T get parent;

  T get root => hasParent ? parent.root : (this as T);

  bool get hasParent;

  T copyWithParent(T parent);

  T copyWithChildren(List<T> children);
}
