import 'package:dio/dio.dart';
import 'package:firstapp/src/Services/ClientInterface.dart';

class Dioclient extends ClientInterface<dynamic> {

  var Client = Dio();

  @override
  Future deleteData(String url)async {
    Response response = await Client.delete(url);

    return response;
  }

  @override
  Future getData(String url)async {
    Response response = await Client.get(url);
    return response;
  }

  @override
  Future patchData(String url,dynamic data)async {
    Response response = await Client.patch(url, data: data);
    return response;
  }

  @override
  Future postData(String url, Map<String, dynamic> data)async {
    Response response = await Client.post(url, data: data);
    return response;
  }

  @override
  Future putData(String url, data)async {
    Response response = await Client.put(url, data: data);
    return response;
  }
  
}