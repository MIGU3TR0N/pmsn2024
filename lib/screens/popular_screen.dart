import 'package:flutter/material.dart';
import 'package:pmsn2024/models/popular_moviedao.dart';
import 'package:pmsn2024/network/popular_api.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  PopularApi? popularApi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularApi = PopularApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: popularApi!.getPopularMovies(), 
        builder: (context, AsyncSnapshot<List<PopularMovieDao>> snapdhot){
          if(snapdhot.hasData){
            return GridView.builder(
              itemCount: snapdhot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ), 
              itemBuilder: (context, index){
                return cardPopular(snapdhot.data![index]);
              },
            );
          }else{
            if(snapdhot.hasError){
              return Center(
                child: Text('Something was wrong :('),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
  Widget cardPopular(PopularMovieDao popular){
    return GestureDetector(
      // {} para enviar mas datos a pushNamed
      onTap: () => Navigator.pushNamed(context, "/detail", arguments: popular),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
            )
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: .7,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  height: 50,
                  child: Text(popular.title, style: TextStyle( color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}