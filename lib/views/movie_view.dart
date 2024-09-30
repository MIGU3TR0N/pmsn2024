import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024/database/movies_database.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:quickalert/quickalert.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key,
  this.moviesDAO
  });

  MoviesDAO? moviesDAO;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();
  MoviesDatabase? moviesDatabase;
  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();

    if (widget.moviesDAO != null){
      conName.text = widget.moviesDAO!.nameMovie!;
      conOverview.text = widget.moviesDAO!.overview!;
      conImgMovie.text = widget.moviesDAO!.imgMovie!;
      conRelease.text = widget.moviesDAO!.releaseDate!;
    }
  }
  @override
  Widget build(BuildContext context) {
    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: const InputDecoration(
        hintText: 'Nombre de la pelicula',
      ),
    );
    final txtOverView = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Sinapsis de la pelicula',
      ),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: const InputDecoration(
        hintText: 'Poster de la pelicula',
      ),
    );
    final txtRelease = TextFormField(
      controller: conRelease,
      decoration: const InputDecoration(
        hintText: 'Fecha de la pelicula',
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context, 
          initialDate: DateTime.now(),
          firstDate: DateTime(2000), 
          lastDate: DateTime(2025));
          if(pickedDate != null){
            String formatDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            conRelease.text = formatDate;
            setState(() {});
          }
      },
      maxLength: 10,
      readOnly: true,
      canRequestFocus: false,
    );
    final btnSave = ElevatedButton(
      onPressed: (){
        moviesDatabase!.INSERT('tblmovies', {
          "nameMovie": conName.text,
          "overview": conOverview.text,
          "idgenre": 1,
          "imgMovie": conImgMovie.text,
          "releaseDate": conRelease.text,
        }).then((value) {
          if( value > 0 ){
            GlobalValues.banUpdListMovies.value = !GlobalValues.banUpdListMovies.value;
            return QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Transaction Completed Successfully!',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          }else{
            return QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'Something was wrong! :()',
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          }
        },);
      }, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[200],
      ),
      child: const Text('Guardar'),
    );
    return ListView(
      shrinkWrap: true,
      children: [
        txtNameMovie,
        txtOverView,
        txtImgMovie,
        txtRelease,
        btnSave
      ],
    );
  }
}