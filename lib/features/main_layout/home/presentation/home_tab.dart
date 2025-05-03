import 'dart:async';
import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/core/resources/enum.dart';
import 'package:ecommerce_app/features/main_layout/home/data/datasource/remote/home_category_remote_ds_impl.dart';
import 'package:ecommerce_app/features/main_layout/home/data/repository/home_category_impl.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/usecases/home_categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/bloc/home_categories_bloc.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCategoriesBloc(
              HomeCategoriesUsecase(
                  HomeCategoryImpl(HomeCategoryRemoteDsImpl(ApiManager()))),
            )..add(GetHomeCategoriesEvent()),
        child: BlocConsumer<HomeCategoriesBloc, HomeCategoriesState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.requestState == RequestState.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.categories?.data == null ||
                  state.categories!.data!.isEmpty) {
                return const Center(child: Text("No categories available"));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAdsWidget(
                      adsImages: adsImages,
                      currentIndex: _currentIndex,
                      timer: _timer,
                    ),
                    Column(
                      children: [
                        CustomSectionBar(
                          sectionNname: 'Categories',
                          function: () {},
                        ),
                        SizedBox(
                          height: 272.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories!.data!.length,
                            itemBuilder: (context, index) {
                              return CustomCategoryWidget(
                                categoryModel: state.categories!.data![index],
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
