abstract class ClientInterface<T> {
  Future<T> getData(String url);
  Future<T> postData(String url, Map<String,T> data);
  Future<T> putData(String url, T data);
  Future<T> deleteData(String url);
  Future<T> patchData(String url, T data);
}