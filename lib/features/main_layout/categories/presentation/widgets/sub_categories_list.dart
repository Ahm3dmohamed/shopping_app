import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_card_item.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:flutter/material.dart';

import '../../../home/data/model/category_model/datum.dart';
import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  List<Datum>? subCategory;
  SubCategoriesList({required this.subCategory, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        slivers: <Widget>[
          // category title
          SliverToBoxAdapter(
            child: Text(
              'Laptops & Electronics',
              style: getBoldStyle(
                  color: ColorManager.primary, fontSize: FontSize.s14),
            ),
          ),
          // the category card
          SliverToBoxAdapter(
            child: CategoryCardItem("Laptops & Electronics",
                ImageAssets.categoryCardImage, goToCategoryProductsListScreen),
          ),
          // the grid view of the subcategories
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: subCategory?.length ?? 0,
                (context, index) => SubCategoryItem(
                    subCategory?[index].name ?? "Medo",
                    subCategory?[index].image ?? ImageAssets.categoryHomeImage,
                    goToCategoryProductsListScreen),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.65,
                mainAxisSpacing: AppSize.s8,
                crossAxisSpacing: AppSize.s8,
              ))
        ],
      ),
    );
  }

  goToCategoryProductsListScreen() {}
}
