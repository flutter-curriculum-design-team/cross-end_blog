import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'dio.dart';

/*
 * 服务端内容API接口（仅供参考未完成）
 */

// class HomeAPI {
//   static const String baseUrl = 'http://localhost:9000';
//   //static const String baseUrl = 'https://your-api-url.com';
//
//   static Future<dynamic> getBaseData(String endpoint) async {
//     final response = await http.get(Uri.parse('$baseUrl/service-content/post/page?step=5'));
//     if (response.statusCode == 200) {
//       // 返回解析后的JSON数据
//       return json.decode(utf8.decode(response.bodyBytes));
//     } else {
//       // 如果请求失败，抛出异常
//       throw Exception('Failed to load data!');
//     }
//   }
//
//   static Future<dynamic> getPostList(String endpoint) async {
//     final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
//     if (response.statusCode == 200) {
//       // 返回解析后的JSON数据
//       return json.decode(utf8.decode(response.bodyBytes));
//     } else {
//       // 如果请求失败，抛出异常
//       throw Exception('Failed to load data!');
//     }
//   }
// }

// 上面只是测试
class HomeAPI {
  Future<dynamic> getUserIntialInfo() async {
    Response response = await dio.get('/service-user/information/initial');
    print(response.data['data']);
    // String data = JsonEncoder.withIndent('  ')
    //     .convert(response.data); // 将 Map 数据转换为 JSON 格式的字符串
    // LogUtil.d(data);
    return response.data;
  }

  Future<dynamic> getPostPage() async {
    Response response = await dio.get('/service-content/post/page',
        queryParameters: {'authorId': 20211120053, 'step': 5});
    print(response.data['data']);
    // String data = JsonEncoder.withIndent('  ')
    //     .convert(response.data); // 将 Map 数据转换为 JSON 格式的字符串
    // LogUtil.d(data);
    return response.data;
  }
}
