import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:task_for_work_by_api/components/appcolors.dart';
import 'package:task_for_work_by_api/components/my_componenets.dart';
import 'package:task_for_work_by_api/controllers/main_controller.dart';

class SinglMovieScreen extends StatelessWidget {
  SinglMovieScreen({Key? key}) : super(key: key);
  //load and injection by binding
  var mainControllerSingle = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(
            () => mainControllerSingle.loadingPageSingleMovie.value
                ? Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.50,
                      ),
                      loading(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.5,
                        width: Get.width,
                        child: Stack(
                          children: [
                            //poster
                            Container(
                              foregroundDecoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                colors:
                                    GradianetAppColors.gradianetSingleMovieItem,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                              child: CachedNetworkImage(
                                imageUrl: mainControllerSingle
                                    .singleMovie.value.poster!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.fill),
                                  ),
                                ),
                                placeholder: (context, url) => loading(),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: AppColors.imageNotFoundColor,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),

                            //icon app bar

                            Positioned(
                              top: 10,
                              left: 10,
                              right: 10,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors
                                          .colorBackgroundSingleMovieIcon
                                          .withAlpha(200),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: AppColors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors
                                          .colorBackgroundSingleMovieIcon
                                          .withAlpha(150),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_outline_rounded,
                                        color: AppColors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //data movie

                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  //title
                                  Text(
                                    mainControllerSingle
                                        .singleMovie.value.title!,
                                    style: Get.textTheme.subtitle2!.apply(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  //detail
                                  Text(
                                    "${mainControllerSingle.singleMovie.value.year!} ● ${mainControllerSingle.singleMovie.value.genres!.getRange(0, mainControllerSingle.singleMovie.value.genres!.length).join(" , ")} ● ${mainControllerSingle.singleMovie.value.runtime!}",
                                    style: Get.textTheme.headline2!.apply(
                                      color: AppColors.white.withAlpha(150),
                                    ),
                                  ),
                                  //rating
                                  RatingBarIndicator(
                                    rating: mainControllerSingle.singleMovie
                                                .value.imdbRating! ==
                                            ""
                                        ? 0.0
                                        : double.parse(mainControllerSingle
                                            .singleMovie.value.imdbRating!),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 10,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'plot_summery'.tr,
                                style: Get.textTheme.subtitle2!.apply(
                                  color: AppColors.white,
                                ),
                              ),
                              // plot
                              ReadMoreText(
                                mainControllerSingle.singleMovie.value.plot!,
                                style: Get.textTheme.headline2!.apply(
                                  color: AppColors.white.withAlpha(150),
                                ),
                                trimMode: TrimMode.Line,
                                trimLines: 2,
                                trimCollapsedText: 'Read more',
                                trimExpandedText: 'less',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'actors'.tr,
                                style: Get.textTheme.subtitle2!.apply(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //actors
                              costumaiseHashtag(mainControllerSingle
                                  .singleMovie.value.actors!),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'awards'.tr,
                                style: Get.textTheme.subtitle2!.apply(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //awards
                              costumaiseHashtag(mainControllerSingle
                                  .singleMovie.value.awards!),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget costumaiseHashtag(List list) {
    return SizedBox(
      height: Get.height * 0.05,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: costumiseRoundedContainer(
                Text(
                  list[index]!.toString(),
                  style: Get.textTheme.headline2!.apply(
                    color: AppColors.white.withAlpha(150),
                  ),
                ),
                AppColors.colorBackgroundSingleMovieIcon.withAlpha(150)),
          );
        }),
      ),
    );
  }
}
