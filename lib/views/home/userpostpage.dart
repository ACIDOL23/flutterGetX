import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/postcontroller.dart';
import 'package:shopx/views/home/userpostcard.dart';

class UserPost extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  UserPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text('User Post', style: GoogleFonts.balooBhai2()),
        actions: [
          IconButton(onPressed: () {} , icon: const Icon(Icons.language))
        ],
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
          ),
          Expanded(
            child: Obx(() {
              if (postController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: postController.postList.length,
                  /*itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.redAccent,
                  ),
                );
              },*/
                  itemBuilder: (context, index) {
                    return UserPostCard(postController.postList[index]);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
