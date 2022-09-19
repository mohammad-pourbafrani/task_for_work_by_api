import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:task_for_work_by_api/components/appcolors.dart';
import 'package:task_for_work_by_api/components/my_componenets.dart';
import 'package:task_for_work_by_api/controllers/main_controller.dart';
import 'package:task_for_work_by_api/gen/assets.gen.dart';
import 'package:task_for_work_by_api/main.dart';
import 'package:task_for_work_by_api/views/show%20movie/single_movie_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  //load and injection by binding
  var mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                //header
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      // ignore: todo
                      //TODO: inja name karbar ra az database migirim
                      "Mohhamad",
                      style: Get.textTheme.headline4!.apply(
                        color: AppColors.white,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(Assets.images.avatar.path),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                //search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTap: () {
                      mainController.statusSearch.value = false;
                    },
                    controller: mainController.textSearchController,
                    style: Get.textTheme.headline1!.apply(
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.backgrandNavColor,
                      hintText: 'search'.tr,
                      hintStyle: Get.textTheme.headline1!.apply(
                        color: AppColors.white.withAlpha(100),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          mainController.getMovieSearchbar(
                              mainController.textSearchController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      suffixIcon: Visibility(
                        visible: !mainController.statusSearch.value,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            mainController.statusSearch.value = true;
                            mainController.textSearchController.clear();
                            mainController.searchItemList.clear();
                            mainController.dataPageResultSearchItem.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // most popular movies
                const SizedBox(
                  height: 8,
                ),

                Visibility(
                  visible: mainController.statusSearch.value,
                  replacement: searchMoviesList(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'most_popular'.tr,
                          style: Get.textTheme.subtitle2!.apply(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      mostPopularMoviesList(),
                      //new movie
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'coming_soon'.tr,
                          style: Get.textTheme.subtitle2!.apply(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      comingSoonMoviesList(),
                      const SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mostPopularMoviesList() {
    return SizedBox(
      height: Get.height / 2.7,
      child: mainController.loadingMostPopular.value
          ? loading()
          : ListView.builder(
              controller: mainController.scrollControllerMostMovie,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: mainController.mostPopularMovieList.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    mainController.getSingleMovie(
                        mainController.mostPopularMovieList[index].id!);
                    Get.toNamed(routSingleMovieScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: Get.width / 2.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.backgrandNavColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: mainController
                                    .mostPopularMovieList[index].poster!,
                                imageBuilder: (context, imageProvider) => Image(
                                    image: imageProvider,
                                    width: Get.width / 2.3,
                                    fit: BoxFit.fill),
                                placeholder: (context, url) => loading(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.imageNotFoundColor,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mainController
                                        .mostPopularMovieList[index].title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.headline2!.apply(
                                      color: AppColors.white.withAlpha(155),
                                    ),
                                  ),
                                  Text(
                                    mainController
                                        .mostPopularMovieList[index].country!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.headline2!.apply(
                                      color: AppColors.white.withAlpha(155),
                                    ),
                                  ),
                                  RatingBarIndicator(
                                    rating: mainController
                                                .mostPopularMovieList[index]
                                                .imdbRating! ==
                                            ""
                                        ? 0.0
                                        : double.parse(mainController
                                            .mostPopularMovieList[index]
                                            .imdbRating!),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 10,
                                    itemSize: 16.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }

  Widget comingSoonMoviesList() {
    return SizedBox(
      height: Get.height / 4,
      child: mainController.loadingComingSoon.value
          ? loading()
          : ListView.builder(
              controller: mainController.scrollControllerComingMovie,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: mainController.comingSoonMoviesList.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    mainController.getSingleMovie(
                        mainController.comingSoonMoviesList[index].id!);
                    Get.toNamed(routSingleMovieScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: Get.width / 1.5,
                      height: Get.height / 4,
                      child: Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            width: Get.width / 1.5,
                            height: Get.height / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                  colors: GradianetAppColors
                                      .gradianetComingSoonItem,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: mainController
                                  .comingSoonMoviesList[index].poster!,
                              imageBuilder: (context, imageProvider) => Image(
                                  image: imageProvider,
                                  // height: Get.height / 4,
                                  fit: BoxFit.fill),
                              placeholder: (context, url) => loading(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.imageNotFoundColor,
                                size: 50,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mainController
                                      .comingSoonMoviesList[index].title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.headline2!.apply(
                                    color: AppColors.white.withAlpha(200),
                                  ),
                                ),
                                Text(
                                  mainController
                                      .comingSoonMoviesList[index].year!,
                                  style: Get.textTheme.headline2!.apply(
                                    color: AppColors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }

  Widget searchMoviesList() {
    if (mainController.searchItemList.isEmpty &&
        mainController.dataPageResultSearchItem["total_count"] == 0) {
      return Center(
        child: Text(
          'no_result'.tr,
          style: Get.textTheme.subtitle2!.apply(color: AppColors.white),
        ),
      );
    } else if (mainController.searchItemList.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        width: Get.width,
        height: Get.height * 0.8,
        child: mainController.loadingSearchBar.value
            ? loading()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: mainController.searchItemList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      mainController.getSingleMovie(
                          mainController.searchItemList[index].id!);
                      Get.toNamed(routSingleMovieScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              //image
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: mainController
                                      .searchItemList[index].poster!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: Get.width * 0.20,
                                    height: Get.height * 0.11,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  placeholder: (context, url) => loading(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.image_not_supported_outlined,
                                    color: AppColors.imageNotFoundColor,
                                    size: 50,
                                  ),
                                ),
                              ),
                              //texts
                              Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mainController
                                            .searchItemList[index].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.headline3!.apply(
                                          color: AppColors.white.withAlpha(200),
                                        ),
                                      ),
                                      RatingBarIndicator(
                                        rating: mainController
                                                    .searchItemList[index]
                                                    .imdbRating! ==
                                                ""
                                            ? 0.0
                                            : double.parse(mainController
                                                .searchItemList[index]
                                                .imdbRating!),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 10,
                                        itemSize: 16.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //icon
                              const Expanded(flex: 1, child: SizedBox()),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: AppColors.white.withAlpha(200),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: AppColors.white.withAlpha(150),
                            indent: Get.width * 0.05,
                            endIndent: Get.width * 0.05,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      );
    }
  }
}
