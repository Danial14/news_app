import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/responsive/web_views/categories_medium_view.dart';
import 'package:news_app/views/responsive/web_views/web_app_drawer.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../utils/route_util.dart';
import '../../../view_model/categories_view_model.dart';
import 'extra_large_category_web.dart';
import 'extra_large_detail_web.dart';

class CategoriesSmallView extends StatefulWidget {
  const CategoriesSmallView({super.key});

  @override
  State<CategoriesSmallView> createState() => _CategoriesSmallViewState();
}

class _CategoriesSmallViewState extends State<CategoriesSmallView> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var newsFuture;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      newsFuture = Provider.of<CategoriesViewModel>(context, listen: false);
      print("fetching categories");
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
      if(constraints.maxWidth >= 1200){
        return Container();
      }
      else if(constraints.maxWidth >= 992 && constraints.maxWidth < 1200){
        return Container();
      }
      else if(constraints.maxWidth >= 768 && constraints.maxWidth < 992){
        return Container();
      }
      else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
        return CategoriesMediumView();
      }
      else {
        return Scaffold(
          key: _key,
          drawer: WebAppDrawer(null, newsFuture),
          appBar: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xffD9D9D9).withOpacity(1.0),
                      Color(0xffD9D9D9).withOpacity(0.23)
                    ]
                ),
              ),
            ),
            title: Text("News", style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.w700)),
            leading: Padding(
              padding: EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Image.asset("assets/images/Menu.png"),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(RouteUtil.createRoute(
                        ExtraLargeWebCategory()));
                  },
                  child: Image.asset(
                    "assets/images/category_icon.png", width: 40, height: 40,),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: FutureBuilder<bool>(
                future: newsFuture.fetchInitialBusinessNews(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.data!) {
                    return SpinKitCircle(
                      size: 40,
                      color: Colors.blue,
                    );
                  }
                  else {
                    return Consumer<CategoriesViewModel>(
                        builder: (context, news, ch) {
                          var data = news.getCategoriesHeadLines;
                          return ListView.builder(itemBuilder: (ctx, position) {
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                    data.articles![position].description!,
                                    data.articles![position].source!.name,
                                    DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                    data.articles![position].urlToImage,
                                    Constants.ROUTE_CATEGORY
                                )));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(flex: 3, child: Container(
                                      height: constraints.maxHeight * 0.3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: data.articles![position]
                                            .urlToImage != null
                                            ? CachedNetworkImage(
                                          imageUrl: data.articles![position]
                                              .urlToImage,
                                          fit: BoxFit.cover,
                                          placeholder: (ctx, st) {
                                            return SpinKitCircle(color: Colors
                                                .blue,);
                                          },
                                          errorWidget: (ctx, st, ob) {
                                            return Icon(Icons.error, color: Colors
                                                .red,);
                                          },
                                        )
                                            :
                                        Center(
                                          child: Text(
                                            "Image not found 404",
                                            style: GoogleFonts.italiana(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(child: Container(
                                      height: constraints.maxHeight * 0.3,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 8,
                                            child: Text(
                                              data.articles![position].title!,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                          /*ListTile(
                                                          leading: Text(data.articles![position].source!.id!,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!))),
                                                          minLeadingWidth: 30,
                                                        )*/
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(child: FittedBox(
                                                  child: Text(
                                                    data.articles![position]
                                                        .source!.name,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight
                                                            .w700
                                                    ),
                                                  ),
                                                  fit: BoxFit.contain,
                                                  alignment: Alignment.centerLeft,
                                                ),
                                                  //flex: 2,
                                                ),
                                                //SizedBox(width: 5,),
                                                Expanded(child: Container(
                                                    alignment: Alignment
                                                        .centerRight,
                                                    child: Text(
                                                        DateFormat.yMMMd("en_US")
                                                            .format(
                                                            DateTime.parse(data
                                                                .articles![position]
                                                                .publishedAt!)))))
                                              ],
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                      ),
                                    ),
                                      flex: 4,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                            itemCount: data.articles!.length,
                          );
                        }
                    );
                  }
                },
              ),
            ),
          ),
        );
      }
    });
  }
}
