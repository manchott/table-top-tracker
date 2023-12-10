import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:table_top_tracker/user/model/user_join.dart';
import 'package:table_top_tracker/user/model/user_login.dart';

import '../model/user.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: "http://localhost:8080/user")
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  @POST('/login')
  Future<User> login(@Body() UserLogin userLogin);

  @POST('/join')
  Future<User> join(@Body() UserJoin userJoin);
}
