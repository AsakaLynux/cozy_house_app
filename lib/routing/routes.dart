abstract final class Routes {
  static const splash = "/";
  static const main = "/main";
  static const home = "home";
  static String placeWithId(int id) => '$home/$id';
  static const houseDetail = ":id";
  static const favourite = "favourite";
  static const wallet = "wallet";
}
