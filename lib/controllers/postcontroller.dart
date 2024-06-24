
import 'package:get/get.dart';
import 'package:shopx/models/post.dart';
import 'package:shopx/services/remote_services.dart';

import '../services/base_controller.dart';


class PostController extends GetxController with BaseController {
  var isLoading = true.obs;
  var postList = <Post>[].obs;


  @override
  void onInit() {
    fetchPost();
    //getData();
    //postData();
    super.onInit();
  }

  void fetchPost() async{
    try{
      isLoading.value = true;
      var posts = await RemoteServices.fetchPosts();
      if(posts!=null){
        postList.value = posts;
      }
    }finally{
      isLoading.value = false;
    }
  }

  /*void getData() async {
    showLoading('Fetching data');
    var response = await BaseClient().get('https://jsonplaceholder.typicode.com', '/posts').catchError(handleError);
    if (response != null) postList.value = response ;
    hideLoading();
    print(response);
  }

  void postData() async {
    var request = {'message': 'CodeX sucks!!!'};
    showLoading('Posting data...');
    var response = await BaseClient().post('https://jsonplaceholder.typicode.com', '/posts', request).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    hideLoading();
    print(response);
  }*/
}