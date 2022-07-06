class Store {
  String name = '';
  String? comment;
  int commentaire = 0;
  String imagePath = '';
  bool? favorite;
  int likes = 0;
  double lat = 47.98;
  double lon = 3.56;
  String time = '';

  Store(String name, String comment, bool favorite, double lat, double lon,
      String imagePath, int commentaire, int likes, String time) {
    this.name = name;
    this.comment = comment;
    this.favorite = favorite;
    this.lat = lat;
    this.lon = lon;
    this.imagePath = imagePath;
    this.likes = likes;
    this.commentaire = commentaire;
    this.time = time;
  }

  String setTime() => "Il y a $time";

  String setLike() {
    return "$favorite j'aime";
  }

  String setCommentaire() {
    if (commentaire > 1) {
      return "$commentaire commentaires";
    } else {
      return "$commentaire commentaire";
    }
  }
}
