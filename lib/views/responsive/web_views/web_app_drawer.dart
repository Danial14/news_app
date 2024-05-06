import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/news_view_model.dart';

class WebAppDrawer extends StatefulWidget {
  late NewsViewModel _newsViewModel;
  WebAppDrawer(NewsViewModel newsViewModel){
    this._newsViewModel = newsViewModel;
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
      child: Drawer(
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
