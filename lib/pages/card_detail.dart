import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music/database/database_client.dart';
import 'package:music/pages/NowPlaying.dart';
import 'package:music/util/lastplay.dart';
import 'package:music/util/utility.dart';

class CardDetail extends StatefulWidget {
  
  final Song song;
  final int mode;
  final DatabaseClient db;
  CardDetail(this.db, this.song, this.mode);
  @override
  State<StatefulWidget> createState() {
    return new StateCardDetail();
  }
}

class StateCardDetail extends State<CardDetail> {
  List<Song> songs;
  bool isLoading = true;
  var image;
  @override
  void initState() {
    super.initState();
    initAlbum();
  }

  void initAlbum() async {
    image = widget.song.albumArt == null
        ? null
        : new File.fromUri(Uri.parse(widget.song.albumArt));
    if (widget.mode == 0)
      songs = await widget.db.fetchSongsfromAlbum(widget.song.albumId);
    else
      songs = await widget.db.fetchSongsByArtist(widget.song.artist);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      body: isLoading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : new CustomScrollView(
              slivers: <Widget>[
                new SliverAppBar(
                  expandedHeight:
                      orientation == Orientation.portrait ? 350.0 : 200.0,
                  pinned: true,
                  floating: true,
                  title: Text(widget.song.album),
                  flexibleSpace: new FlexibleSpaceBar(
                    
                    background: new Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        new Hero( 
                          tag: widget.mode == 0
                              ? widget.song.album
                              : widget.song.artist,
                          child: image != null
                              ? new Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: new ListTile(
                       title: Text(widget.mode == 0
                            ? widget.song.album
                            : widget.song.artist,
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        maxLines: 1,),
                        subtitle: new Text(
                        widget.mode == 0 ? widget.song.artist : "",
                        style: new TextStyle(fontSize: 14.0),
                        maxLines: 1,
                      ),
                      trailing: new Text(songs.length.toString() + " songs"),
                      ),
                    ),
                   
                    
                    new Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text("Songs",
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ))),
                  ]),
                ),
                new SliverList(
                  delegate: new SliverChildBuilderDelegate((builder, i) {
                    return new ListTile(
                      leading: new CircleAvatar(
                        child: new Hero(
                          tag: songs[i].id,
                          child: avatar(
                              context, getImage(songs[i]), songs[i].title),
                        ),
                      ),
                      title: new Text(songs[i].title,
                          maxLines: 1, style: new TextStyle(fontSize: 18.0)),
                      subtitle: new Text(
                        songs[i].artist,
                        maxLines: 1,
                        style:
                            new TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      trailing: new Text(
                          new Duration(milliseconds: songs[i].duration)
                              .toString()
                              .split('.')
                              .first,
                          style: new TextStyle(
                              fontSize: 12.0, color: Colors.grey)),
                      onTap: () {
                        MyQueue.songs = songs;
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                new NowPlaying(widget.db, songs, i,0)));
                      },
                    );
                  }, childCount: songs.length),
                ),
              ],
            ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
         setState(() {
            MyQueue.songs = songs;
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) =>
                  new NowPlaying(widget.db, MyQueue.songs, 0,0)));
         });
        },
        child: new Icon(Icons.shuffle),
      ),
    );
  }
}
