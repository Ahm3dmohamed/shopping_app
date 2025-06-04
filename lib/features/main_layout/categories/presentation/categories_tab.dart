import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/data_source/subcategories_ds.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/usecases/get_subcategories_use_cases.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/bloc/categores_bloc.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/bloc/categores_event.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/bloc/categores_state.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/categories_list.dart';
import 'package:ecommerce_app/features/main_layout/home/data/datasource/remote/home_category_remote_ds_impl.dart';
import 'package:ecommerce_app/features/main_layout/home/data/repository/home_category_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/domain/usecases/home_categories_usecase.dart';
import '../data/repo/sub_categories_rpo_impl.dart';
import 'widgets/sub_categories_list.dart';

// class CategoriesTab extends StatefulWidget {
//   const CategoriesTab({super.key});

//   @override
//   State<CategoriesTab> createState() => _CategoriesTabState();
// }

// class _CategoriesTabState extends State<CategoriesTab> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CategoresBloc(
//           HomeCategoriesUsecase(
//               HomeCategoryImpl(HomeCategoryRemoteDsImpl(ApiManager()))),
//           GetSubcategoriesUseCases(
//               CategoriesRpoImpl(SubcategoriesDsImpl(ApiManager())))),
//       child: BlocConsumer<CategoresBloc, CategoresState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: AppPadding.p12, vertical: AppPadding.p12),
//             child: Row(
//               children: [
//                 CategoriesList(
//                   categoryModel: state.categories,
//                   onClick: (id) {
//                     BlocProvider.of<CategoresBloc>(context)
//                         .add(GetSubCategoriesEvent(id));
//                   },
//                 ),
//                 const SizedBox(
//                   width: AppSize.s16,
//                 ),
//                 SubCategoriesList(
//                   subCategory: state.subCategorymodel,
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CategoresBloc(
          HomeCategoriesUsecase(
            HomeCategoryImpl(HomeCategoryRemoteDsImpl(ApiManager())),
          ),
          GetSubcategoriesUseCases(
            CategoriesRpoImpl(SubcategoriesDsImpl(ApiManager())),
          ),
        );
        bloc.add(GetHomeCategoriesEvent()); // ✅ Load categories on start
        return bloc;
      },
      child: BlocConsumer<CategoresBloc, CategoresState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12,
              vertical: AppPadding.p12,
            ),
            child: Row(
              children: [
                CategoriesList(
                  categoryModel: state.categories,
                  onClick: (id) {
                    BlocProvider.of<CategoresBloc>(context)
                        .add(GetSubCategoriesEvent(id));
                  },
                ),
                const SizedBox(width: AppSize.s16),
                SubCategoriesList(
                  subCategory: state.subCategorymodel,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
