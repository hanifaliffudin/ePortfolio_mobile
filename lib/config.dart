class Config{
  static const String appName = "FILKOM E-PORTFOLIO";
  static const String apiURL = "http://103.187.223.15:8800";
  //static const String apiURL = "https://67e5-118-99-125-4.ap.ngrok.io";//PROD_URL
  static const loginAPI = "$apiURL/api/auth/login";
  static const registerAPI = "$apiURL/api/auth/register";
  static const users = "$apiURL/api/users";
  static const postApi ="$apiURL/api/posts";
  static const timelineApi = "$apiURL/api/posts/timeline/all";
  static const userActivities = "$apiURL/api/posts/all";
}