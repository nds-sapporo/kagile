import 'package:kagile/services/restclient.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
