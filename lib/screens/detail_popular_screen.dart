import 'package:flutter/material.dart';
import 'package:pmsn2024/models/popular_moviedao.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  @override
  Widget build(BuildContext context) {
    // de un modal esta recuperando los elementos y asignando a una variable
    // esta recuperando los datos 
    final popular = ModalRoute.of(context)!.settings.arguments as PopularMovieDao;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: .3,
            fit: BoxFit.fill,
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}')
          ),
        ),
      ),
    );
  }
}