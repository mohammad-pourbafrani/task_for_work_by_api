import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:task_for_work_by_api/models/category_model.dart';
import 'package:task_for_work_by_api/models/most_popular_movie_model.dart';
import 'package:task_for_work_by_api/models/single_movie_model.dart';
import 'package:task_for_work_by_api/services/api_constan.dart';
import 'package:task_for_work_by_api/services/dio_service.dart';

class MainController extends GetxController {
  //storage
  final storage = new FlutterSecureStorage();

  //variable
  RxString userName = RxString("");
  RxInt selectedNavBar = RxInt(0);
  RxBool loadingMostPopular = RxBool(false);
  RxBool loadingComingSoon = RxBool(false);
  RxBool loadingcategory = RxBool(false);
  RxBool loadingCategoryMovie = RxBool(false);
  RxBool loadingPageSingleMovie = RxBool(false);
  RxBool loadingSearchBar = RxBool(false);
  RxBool statusSearch = RxBool(true);
  RxMap<String, dynamic> dataPageMostPopular = RxMap();
  RxMap<String, dynamic> dataPageComingSoon = RxMap();
  RxMap<String, dynamic> dataPageCategoryItem = RxMap();
  RxMap<String, dynamic> dataPageResultSearchItem = RxMap();
  Rx<SingleMovieModel> singleMovie = SingleMovieModel().obs;

  int pageMostPopular = 1;
  int pageComingSoon = 4;
  int pageCategoryMovie = 1;
  int pageResultSearchMovie = 1;
  int idGenre = 0;

  //list
  RxList<MostPopularMovieModel> mostPopularMovieList = RxList();
  RxList<MostPopularMovieModel> comingSoonMoviesList = RxList();
  RxList<CategoryModel> categoryList = RxList();
  RxList<MostPopularMovieModel> categoryItemList = RxList();
  RxList<MostPopularMovieModel> searchItemList = RxList();
  RxList<SingleMovieModel> single = RxList();

  //controller

  TextEditingController textSearchController = TextEditingController();
  ScrollController? scrollControllerMostMovie;
  ScrollController? scrollControllerComingMovie;
  ScrollController? scrollControllerCategory;

  //method

  scrollListenerMostMovie() {
    if (scrollControllerMostMovie!.offset >=
            scrollControllerMostMovie!.position.maxScrollExtent &&
        !scrollControllerMostMovie!.position.outOfRange) {
      if (pageMostPopular < dataPageMostPopular["page_count"]) {
        mostPopularMovieList.clear();
        pageMostPopular++;

        getMostPopular();
      }
    }
    if (scrollControllerMostMovie!.offset <=
            scrollControllerMostMovie!.position.minScrollExtent &&
        !scrollControllerMostMovie!.position.outOfRange) {
      if (pageMostPopular > 1) {
        mostPopularMovieList.clear();
        pageMostPopular--;
        getMostPopular();
      }
    }
  }

  scrollListenerComingMovie() {
    if (scrollControllerComingMovie!.offset >=
            scrollControllerComingMovie!.position.maxScrollExtent &&
        !scrollControllerComingMovie!.position.outOfRange) {
      if (pageComingSoon < dataPageComingSoon["page_count"]) {
        comingSoonMoviesList.clear();
        pageComingSoon++;

        getComingSoon();
      }
    }
    if (scrollControllerComingMovie!.offset <=
            scrollControllerComingMovie!.position.minScrollExtent &&
        !scrollControllerComingMovie!.position.outOfRange) {
      if (pageComingSoon > 4) {
        comingSoonMoviesList.clear();
        pageComingSoon--;
        getComingSoon();
      }
    }
  }

  scrollListenerCategory() {
    if (scrollControllerCategory!.offset >=
            scrollControllerCategory!.position.maxScrollExtent &&
        !scrollControllerCategory!.position.outOfRange) {
      if (pageCategoryMovie < dataPageCategoryItem["page_count"]) {
        categoryItemList.clear();
        pageCategoryMovie++;

        getMovieCategory(idGenre);
      }
    }
    if (scrollControllerCategory!.offset <=
            scrollControllerCategory!.position.minScrollExtent &&
        !scrollControllerCategory!.position.outOfRange) {
      if (pageCategoryMovie > 1) {
        categoryItemList.clear();
        pageCategoryMovie--;
        getMovieCategory(idGenre);
      }
    }
  }

  @override
  onInit() async {
    if (await storage.containsKey(key: "username").then((value) => value)) {
      userName.value = await storage.read(key: "username").then((value) {
        return value.toString();
      });
    } else {
      await storage.write(key: "username", value: "guest");
      userName.value = "guest";
    }

    scrollControllerMostMovie = ScrollController();
    scrollControllerComingMovie = ScrollController();
    scrollControllerCategory = ScrollController();
    scrollControllerComingMovie!.addListener(scrollListenerComingMovie);
    scrollControllerMostMovie!.addListener(scrollListenerMostMovie);
    scrollControllerCategory!.addListener(scrollListenerCategory);

    getMostPopular();
    getComingSoon();
    getCategory();
    super.onInit();
  }

  getMostPopular() async {
    loadingMostPopular.value = true;

    Map<String, dynamic> parametr = {'page': pageMostPopular};
    var responseMostPopular =
        await DioService().getMethod(ApiConstan.getMostPopularMovies, parametr);

    if (responseMostPopular.statusCode == 200) {
      responseMostPopular.data['data'].forEach((element) {
        mostPopularMovieList.add(MostPopularMovieModel.fromJson(element));
      });

      dataPageMostPopular.value = responseMostPopular.data['metadata'];
    }

    log(responseMostPopular.toString());
    loadingMostPopular.value = false;
  }

  getComingSoon() async {
    loadingComingSoon.value = true;
    Map<String, dynamic> parametr = {'page': pageComingSoon};
    var responseComingSoon =
        await DioService().getMethod(ApiConstan.getComingSoonMovies, parametr);

    if (responseComingSoon.statusCode == 200) {
      responseComingSoon.data['data'].forEach((element) {
        comingSoonMoviesList.add(MostPopularMovieModel.fromJson(element));
      });
      dataPageComingSoon.value = responseComingSoon.data['metadata'];
    }
    loadingComingSoon.value = false;
  }

  getCategory() async {
    loadingcategory.value = true;
    Map<String, dynamic> parametr = {};
    var responsecategory =
        await DioService().getMethod(ApiConstan.getCategoryMovies, parametr);

    if (responsecategory.statusCode == 200) {
      responsecategory.data.forEach((element) {
        categoryList.add(CategoryModel.fromJson(element));
      });
    }
    loadingcategory.value = false;
  }

  getMovieCategory(int id) async {
    categoryItemList.clear();
    loadingCategoryMovie.value = true;

    Map<String, dynamic> parametr = {'page': pageCategoryMovie};
    var responseItemCategory = await DioService()
        .getMethod(ApiConstan().getItemCategory(id), parametr);

    if (responseItemCategory.statusCode == 200) {
      responseItemCategory.data['data'].forEach((element) {
        categoryItemList.add(MostPopularMovieModel.fromJson(element));
      });

      dataPageCategoryItem.value = responseItemCategory.data['metadata'];
    }

    log(responseItemCategory.toString());
    loadingCategoryMovie.value = false;
  }

  getSingleMovie(int id) async {
    loadingPageSingleMovie.value = true;
    Map<String, dynamic> parametr = {};
    var responseSingleMovie =
        await DioService().getMethod(ApiConstan().getSingleMovie(id), parametr);

    if (responseSingleMovie.statusCode == 200) {
      singleMovie.value = SingleMovieModel.fromJson(responseSingleMovie.data);
    }

    log(responseSingleMovie.toString());
    log(singleMovie.value.awards.toString());
    loadingPageSingleMovie.value = false;
  }

  getMovieSearchbar(String name) async {
    searchItemList.clear();
    loadingSearchBar.value = true;

    Map<String, dynamic> parametr = {'q': name, 'page': pageResultSearchMovie};
    var responseSearchBar =
        await DioService().getMethod(ApiConstan.getResultSearch, parametr);

    if (responseSearchBar.statusCode == 200) {
      responseSearchBar.data['data'].forEach((element) {
        searchItemList.add(MostPopularMovieModel.fromJson(element));
      });

      dataPageResultSearchItem.value = responseSearchBar.data['metadata'];
    }

    log(responseSearchBar.toString());
    loadingSearchBar.value = false;
  }
}
