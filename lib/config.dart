class Config{
  static const String appName = "FILKOM E-PORTFOLIO";
  //static const String apiURL = "http://103.187.223.15:8800";
  static const String apiURL = "https://2a3c-36-68-220-93.ap.ngrok.io";//PROD_URL
  static const loginAPI = "$apiURL/api/auth/login";
  static const registerAPI = "$apiURL/api/auth/register";
  static const users = "$apiURL/api/users";
  static const postApi ="$apiURL/api/posts";
  static const createArticle = "$apiURL/api/articles";
  static const createActivity ="$apiURL/api/activities";
  static const articleApi = "$apiURL/api/articles/all";
  static const userActivities = "$apiURL/api/posts/all";
  static const activities = "$apiURL/api/activities/all";
  static const badges = "$apiURL/api/badges/all";
  static const timelineArticleApi = "$apiURL/api/articles/timeline/all";
  static const timelineApi = "$apiURL/api/posts/timeline/all";
}