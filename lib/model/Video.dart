class Video {
  String id;
  String titulo;
  String imagem;
  String canal;
  String descricao;

  Video({
    required this.id,
    required this.titulo,
    required this.imagem,
    required this.canal,
    required this.descricao,
  });

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelTitle"],
      descricao: json["snippet"]["description"],

    );
  }

}