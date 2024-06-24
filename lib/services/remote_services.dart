import 'package:shopx/models/post.dart';
import 'package:shopx/models/products.dart';
import 'package:shopx/services/base_client.dart';




class RemoteServices{

  static Future<List<Product>?> fetchProducts() async {
    var response = await BaseClient().get('https://makeup-api.herokuapp.com/api/v1','/products.json?brand=maybelline');
    print(response);
    return productFromJson(response);

  }

  static Future<List<Post>?> fetchPosts() async {
    var response = await BaseClient().get('https://jsonplaceholder.typicode.com', '/posts');
    print(response);
    return postFromJson(response);
  }
}
