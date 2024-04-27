import 'package:feed_app/models/post.dart';
import 'package:feed_app/repositories/like_repository.dart';
import 'package:flutter/material.dart';

import 'circle_profile.dart';
import 'post_action_card.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final void Function()? onTap;
  const PostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  CircleProfile(
                    name: post.user.name[0].toString(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    post.user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(post.title),
            ),
            Text(post.body),
            const Divider(),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LikeButton(post: post),
                  PostActionButton(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              /////အတုံးလေးလုပ်တာ//////
                              Container(
                                width: 100,
                                height: 8,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(188, 188, 188, 0.4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.only(bottom: 20),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 20, right: 20),
                                  separatorBuilder: (_, __) => const Divider(),
                                  itemCount: post.comments.length,
                                  itemBuilder: (_, i) {
                                    final comment = post.comments[i];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleProfile(
                                                name: comment.name[0]),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(comment.email),
                                          ],
                                        ),
                                        Text(comment.name),
                                        Text(comment.body)
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icons.mode_comment_outlined,
                    label: "Comment ${post.comments.length}",
                  ),
                  const PostActionButton(
                    icon: Icons.share,
                    label: "Share",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final PostModel post;
  const LikeButton({super.key, required this.post});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return PostActionButton(
      color: LikeRepository.get(widget.post.id.toString()) ? Colors.red : null,
      icon: LikeRepository.get(widget.post.id.toString())
          ? Icons.favorite
          : Icons.favorite_border,
      label: "Favorite",
      onTap: () async {
        await LikeRepository.action(widget.post.id.toString());
        setState(() {});
      },
    );
  }
}
