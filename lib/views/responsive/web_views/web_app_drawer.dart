import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/news_view_model.dart';

import '../../../constants/constants.dart';
import '../../../view_model/categories_view_model.dart';

class WebAppDrawer extends StatefulWidget {
  NewsViewModel? _newsViewModel;
  CategoriesViewModel? _categoriesViewModel;
  WebAppDrawer([NewsViewModel? newsViewModel, CategoriesViewModel? categoriesViewModel]){
    this._newsViewModel = newsViewModel;
    this._categoriesViewModel = categoriesViewModel;
  }
  _WebDrawerState createState(){
    return _WebDrawerState();
  }

}
class _WebDrawerState extends State<WebAppDrawer> with TickerProviderStateMixin{
  late Tween<Offset> _slideTween;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  @override
  void initState() {
    // TODO: implement initState
    _slideTween = Tween<Offset>(
      begin: Offset(0.5, 1),
      end: Offset(0, 0)
    );
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat(reverse: true);
    _animation = _slideTween.animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate));
    _animationController.addStatusListener((status) {
      print("drawer: ${status.name}");
      if(status.name == "reverse"){
        _animationController.stop();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget._categoriesViewModel == null ? Drawer(
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
                      widget._newsViewModel!.fetchBbcHeadlinesNews();
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
                      widget._newsViewModel!.fetchCnnHeadlinesNews();
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
                      widget._newsViewModel!.fetchAlJazeeraHeadlinesNews();
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
                      widget._newsViewModel!.fetchIndependentHeadlinesNews();
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
                      widget._newsViewModel!.fetchReutersHeadlinesNews();
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
      ) :
      Drawer(
        child: Column(
          children: <Widget>[
            Expanded(flex: 3,child: Container(child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset("assets/images/splash_pic.jpg", fit: BoxFit.cover,)))),
            Expanded(flex: 5, child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffF7F4E7)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Text("Categories", style: GoogleFonts.poppins(
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
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: InkWell(
                        onTap: () async{
                          Navigator.of(context).pop();
                          await widget._categoriesViewModel!.fetchHealthCategoryNews();
                        },
                        child: Text(Constants.HEALTH, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),),
                      ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: InkWell(
                        onTap: () async{
                          Navigator.of(context).pop();
                          await widget._categoriesViewModel!.fetchBusinessCategoryNews();
                        },
                        child: Text(Constants.BUSINESS, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: InkWell(
                        onTap: () async{
                          Navigator.of(context).pop();
                          await widget._categoriesViewModel!.fetchTechnologyCategoryNews();
                        },
                        child: Text(Constants.TECHNOLOGY, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          widget._categoriesViewModel!.fetchEntertainmentCategoryNews();
                        },
                        child: Text(Constants.ENTERTAINMENT, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          widget._categoriesViewModel!.fetchGeneralCategoryNews();
                        },
                        child: Text(Constants.GENERAL, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          widget._categoriesViewModel!.fetchScienceCategoryNews();
                        },
                        child: Text(Constants.SCIENCE, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          widget._categoriesViewModel!.fetchSportsCategoryNews();
                        },
                        child: Text(Constants.SPORTS, style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),
                          ),
                      ),
                  ),
                ],
              ),
            ),)
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
}
