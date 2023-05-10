class Config{
  static const String appName = "FILKOM E-PORTFOLIO";
  //static const String apiURL = "http://103.187.223.15:8800";
  static const String apiURL = "https://123e-180-248-43-161.ngrok-free.app";//PROD_URL
  static const loginAPI = "$apiURL/api/auth/login";
  static const registerAPI = "$apiURL/api/auth/register";
  static const users = "$apiURL/api/users";
  static const post ="$apiURL/api/posts";
  static const article = "$apiURL/api/articles";
  static const activity ="$apiURL/api/activities";
  static const badges ="$apiURL/api/badges";
  static const fetchUserArticle = "$apiURL/api/articles/all";
  static const fetchUserPost = "$apiURL/api/posts/all";
  static const fetchUserActivities = "$apiURL/api/activities";
  static const fetchUserBadges = "$apiURL/api/badges/all";
  static const timelineArticleApi = "$apiURL/api/articles/timeline/all";
  static const timelineApi = "$apiURL/api/posts/timeline/all";
  static const album = "$apiURL/api/album";
  static const project = "$apiURL/api/projects";
}