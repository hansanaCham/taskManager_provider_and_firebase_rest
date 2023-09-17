import 'package:flutter/material.dart';

import 'counter_badge.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int count;
  final String title;
  const TaskAppBar(this.title, this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: count > -1 ? CountBadge(count: count) : Container(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
