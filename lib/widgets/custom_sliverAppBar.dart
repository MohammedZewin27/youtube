import 'package:flutter/material.dart';
import 'package:youtube/generated/assets.dart';
import 'package:youtube/screens/openYouTubeScreen.dart';

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
        child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, OpenYouTube.routeName);
            },
            child: Image.asset(Assets.imageLogo)),
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
                  'https://avatars.githubusercontent.com/u/133890793?s=400&u=812fefa522ca129ce43ddab61dfdd9e20db4a407&v=4'),
            )),
      ],
    );
  }
}
