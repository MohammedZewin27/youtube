import 'package:flutter/material.dart';

import '../res.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(Res.logo),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.cast)),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {},
            iconSize: 40,
            icon: const CircleAvatar(
              foregroundImage: NetworkImage(
                  'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg'),
            )),
      ],
    );
  }
}
