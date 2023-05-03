extension ObjectExtension<T> on T {
  R let<R>(R Function(T that) func) => func(this);
}
