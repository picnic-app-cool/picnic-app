abstract class JsonCodec<T> {
  Map<String, dynamic> toJson(T obj);

  T fromJson(Map<String, dynamic> json);
}
