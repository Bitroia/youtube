import 'package:flutter/material.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Api.dart';

class Inicio extends StatefulWidget {

  String pesquisa;

  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa){

    Api api = Api();
    return api.pesquisar(pesquisa);
  }
  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
          if (snapshot.hasData) {
            List<Video>? videosNullable = snapshot.data;
            if (videosNullable != null) {
              List<Video> videos = videosNullable;
              return ListView.separated(
                itemBuilder: (context, index){
                  Video video = videos[ index ];

                  return GestureDetector(
                    onTap: (){
                      YoutubePlayerController _controller = YoutubePlayerController(
                        initialVideoId: "UCVHFbqXqoYvEWM1Ddxl0QDg",
                        flags: YoutubePlayerFlags(
                          autoPlay: true,
                          mute: true,
                        ),
                      );
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        onReady: (){
                          _controller.addListener();
                        },
                      );
                    } ,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage( video.imagem )
                              )
                          ),
                        ),
                        ListTile(
                          title: Text( video.titulo ),
                          subtitle: Text( video.canal ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: videos.length,
              );
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
          } else {
            return Center(
                child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
