import 'package:dio/dio.dart';
import 'package:my_blog/services/dio.dart';

class DioUtil {
  Future<dynamic> getUserIntialInfo() async {
    Response response = await dio.get('/service-user/information/initial');
    return response.data;
  }


  //登录获取验证码
  Future<dynamic> getLoginCaptcha(String email) async {
    // 发送Get请求，并添加查询参数
    Response response = await dio.get(
      '/service-user/user/mail/login/captcha',
      queryParameters: {'email': email},
    );
    return response.data;
  }

  //注册获取验证码
  Future<dynamic> getRegisterCaptcha(String email) async {
    // Dio dio = Dio();
    // 发送Get请求，并添加查询参数
    Response response = await dio.get(
      '/service-user/user/mail/register/captcha',
      queryParameters: {'email': email},
    );
    return response.data;
  }

  //修改密码获取验证码
  Future<dynamic> getRecoverCaptcha(String email) async {
    // Dio dio = Dio();
    // 发送Get请求，并添加查询参数
    Response response = await dio.get(
      '/service-user/user/mail/recover/captcha',
      queryParameters: {'email': email},
    );
    print(response.data.runtimeType);
    return response.data;
  }

  //注册
  Future<dynamic> register(
      String email, String captcha, String password) async {
    // Dio dio = Dio();
    // 发送Get请求，并添加查询参数
    Response response = await dio.post(
      '/service-user/user/register',
      data: {
        'email': email,
        'captcha': captcha,
        'password': password,
        'registerType': 'email'
      },
    );
    print(response);
    print(response.data.runtimeType);
    return response.data;
  }

  //登录
  Future<dynamic> login(String email, String password) async {
    // Dio dio = Dio();
    // 发送Get请求，并添加查询参数
    Response response = await dio.post(
      '/service-user/oauth/token',
      queryParameters: {
        //下面这样写不管用，目前还不知道原因
        // 'client_id': {Constants.clientId},
        // 'client_secret': {Constants.clientSecret},
        // 'grant_type': {Constants.grantType},
        'client_id': 'cross-end',
        'client_secret': 'cross-end',
        'grant_type': 'password',
        // 'username': {
        //   "email": email,
        //   "authType": 'password',
        //   "password": password
        // },
        'username':
            '{"email":"$email","authType":"password","password":"$password"}',
        // POST localhost:9000/service-user/oauth/token?client_id=cross-end&client_secret=cross-end&grant_type=password&username={"email":"2064989403@qq.com","authType":"password","password":"030321"}
      },
    );
    print(response.data.runtimeType);
    print(response.data);
    print(response.statusCode);
    print(response.statusMessage);
    print(response.requestOptions);
    return response.data;
  }

  //修改密码
  Future<dynamic> recover(String email, String captcha, String password) async {
    // Dio dio = Dio();
    // 发送Get请求，并添加查询参数
    Response response = await dio.put(
      '/service-user/user/recover',
      data: {
        'email': email,
        'captcha': captcha,
        'password': password,
      },
    );
    return response.data;
  }
}
