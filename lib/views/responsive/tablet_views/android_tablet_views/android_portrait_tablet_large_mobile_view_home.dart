import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/drawer.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/route_util.dart';
import '../../../../view_model/news_view_model.dart';
import '../../web_views/extra_large_detail_web.dart';

class AndroidPortraitTabletLargeMobileView extends StatefulWidget {
  const AndroidPortraitTabletLargeMobileView({super.key});

  @override
  State<AndroidPortraitTabletLargeMobileView> createState() => _AndroidPortraitTabletLargeMobileViewState();
}

class _AndroidPortraitTabletLargeMobileViewState extends State<AndroidPortraitTabletLargeMobileView> {
  var newsFuture;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      newsFuture = Provider.of<NewsViewModel>(context, listen: false);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(newsFuture),
      body: FutureBuilder<bool>(
          future: newsFuture.fetchInitialHeadlinesNews("bbc-news"),
          builder: (ctx, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
              return SpinKitCircle(
                color: Colors.blue,
                size: 40,
              );
            }
            else{
              return Consumer<NewsViewModel>(
                builder: (ctx, news, ch){
                  var data = news.getHeadlines;
                  print("news length: ${data.articles!.length}");
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.1
                        ),
                        itemBuilder: (ctx, position){
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                  data.articles![position].description!,
                                  data.articles![position].source!.name,
                                  DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                  data.articles![position].urlToImage,
                                  Constants.ROUTE_HOME
                              )));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: data.articles![position].urlToImage != null ? ClipRRect(
                                          child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                            fit: BoxFit.cover,
                                            placeholder: (ctx, st){
                                              return SpinKitCircle(color: Colors.blue,);
                                            },
                                            errorWidget: (ctx, str, obj){
                                              return Image.asset("assets/images/404.png", fit: BoxFit.cover,);
                                            },
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ) : ClipRRect(child: Image.asset("assets/images/404.png", fit: BoxFit.cover,),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3,),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(padding: EdgeInsets.only(left: 3),child: Text(data.articles![position].title!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18
                                        ),
                                      )),
                                    ),
                                    SizedBox(height: 12,),
                                    ListTile(contentPadding: EdgeInsets.only(left: 3),leading: FittedBox(
                                      child: Text(data.articles![position].source!.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      fit: BoxFit.contain,
                                      alignment: Alignment.centerLeft,
                                    ),
                                      trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          )
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          );
                        },
                        itemCount: data.articles!.length,
                      ),
                  );
                },
              );
            }
          }
      ),
    );
  }
}
