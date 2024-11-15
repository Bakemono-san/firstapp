import 'dart:ffi';

import 'package:firstapp/src/Providers/ContextProvider.dart';
import 'package:firstapp/src/Providers/ProviderInterface.dart';


abstract class ControllerInterface<T>{
  Future<void> updateData(T data);
  Future<void> deleteData(T data);
  Future<void> addData(T data);
  Future<T> getDataById(Long id);

}