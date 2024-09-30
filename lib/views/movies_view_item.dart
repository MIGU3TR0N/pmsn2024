import 'package:flutter/material.dart';
import 'package:pmsn2024/database/movies_database.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/views/movie_view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItem extends StatefulWidget {
  MovieViewItem({
    super.key, 
    required this.moviesDAO
  });

  MoviesDAO moviesDAO;

  @override
  State<MovieViewItem> createState() => _MovieViewItemState();
}



class _MovieViewItemState extends State<MovieViewItem> {
  MoviesDatabase? moviesDatabase;
  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Column(
        children: [Row(
          children: [
            Image.network(
              'https://www.ecartelera.com/carteles/16600/16608/005_m.jpg',
              height: 100,
            ),
            Expanded(
              child: ListTile(
                title: Text(widget.moviesDAO.nameMovie!),
                subtitle: Text(widget.moviesDAO.releaseDate!),
              ),
            ),
            IconButton(onPressed: (){
              WoltModalSheet.show(
                context: context, 
                pageListBuilder: (context) => [
                  WoltModalSheetPage(
                    child: MovieView(moviesDAO: widget.moviesDAO,)
                  )
                ]
              );
            }, icon: Icon(Icons.edit),),
            IconButton(onPressed: (){
              moviesDatabase!.DELETE('tblmovies', widget.moviesDAO.idMovie!).then((value) {
                if( value > 0 ){
                  GlobalValues.banUpdListMovies.value = !GlobalValues.banUpdListMovies.value;
                  return QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Transaction Completed Successfully!',
                    autoCloseDuration: const Duration(seconds: 2),
                    showConfirmBtn: true,
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
              });
            }, icon: Icon(Icons.delete),),
          ],
        ),
        Divider(),
        Text(widget.moviesDAO.overview!),
      ]
      ),
    );
  }
}

// 