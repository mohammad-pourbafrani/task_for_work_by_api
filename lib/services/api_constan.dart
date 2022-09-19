class ApiConstan {
  // static const baseUrl = "https://imdb-api.com/API/";
  static const baseUrl = "https://moviesapi.ir/";
  static const getMostPopularMovies = "${baseUrl}api/v1/movies";
  static const getComingSoonMovies = "${baseUrl}api/v1/movies";
  static const getCategoryMovies = "${baseUrl}api/v1/genres";
  static const getResultSearch = "${baseUrl}api/v1/movies";
  static const getUserInfo = "${baseUrl}api/user";
  static const postUserInfoSignUp = "${baseUrl}api/v1/register";
  static const postUserInfoLogIn = "${baseUrl}oauth/token";
  String getItemCategory(int id) {
    return "${baseUrl}api/v1/genres/$id/movies";
  }

  String getSingleMovie(int id) {
    return "${baseUrl}api/v1/movies/$id";
  }
}
