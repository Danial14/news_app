import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../view_model/news_view_model.dart';

class AppDrawer extends StatefulWidget {
  late NewsViewModel _newsViewModel;
  AppDrawer(NewsViewModel newsViewModel){
    this._newsViewModel = newsViewModel;
  }
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(flex: 3,child: Container(child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset("assets/images/splash_pic.jpg", fit: BoxFit.cover,)))),
          Expanded(flex: 5, child: Container(
            decoration: BoxDecoration(
                color: Color(0xffF7F4E7)
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Text("Channels", style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 28
                  ),),
                ),
                SizedBox(height: 2,),
                Container(
                  width: 304,
                  height: 1,
                  color: Colors.black,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    widget._newsViewModel.fetchBbcHeadlinesNews();
                  },
                  child: ListTile(
                    leading: Text("BBC", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    widget._newsViewModel.fetchCnnHeadlinesNews();
                  },
                  child: ListTile(
                    leading: Text("CNN", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    widget._newsViewModel.fetchAlJazeeraHeadlinesNews();
                  },
                  child: ListTile(
                    leading: Text("Al Jazeera", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    widget._newsViewModel.fetchIndependentHeadlinesNews();
                  },
                  child: ListTile(
                    leading: Text("Independent", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    widget._newsViewModel.fetchReutersHeadlinesNews();
                  },
                  child: ListTile(
                    leading: Text("Reuters", style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),),
                  ),
                )
              ],
            ),
          ),)
        ],
      ),
    );
  }
}
