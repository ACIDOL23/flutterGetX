import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/models/post.dart';

class UserPostCard extends StatelessWidget {
  final Post userPost;

  const UserPostCard(this.userPost, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userPost.id}. ${userPost.title}",
              maxLines: 2,
              style: GoogleFonts.balooBhai2(
                  fontWeight: FontWeight.bold, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              userPost.body,
              maxLines: 2,
              style: GoogleFonts.balooBhai2(
                  fontWeight: FontWeight.normal, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
