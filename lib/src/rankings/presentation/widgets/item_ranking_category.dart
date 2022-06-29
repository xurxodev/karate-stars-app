import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_entries_page.dart';

class ItemRankingCategory extends StatelessWidget {
  final String rankingId;
  final Category category;

  const ItemRankingCategory({required this.rankingId, required this.category});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return RoundedCard(
        elevation: 0.0,
        borderRadius: const BorderRadius.all(radius),
        child: GestureDetector(
            onTap: () {
              final args = RankingEntriesArgs(
                  rankingId: rankingId, categoryId: category.id);
              RankingEntriesPage.navigate(context, arguments: args);
            },
            child: ListTile(
              title: Text(category.name),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            )));
  }
}
