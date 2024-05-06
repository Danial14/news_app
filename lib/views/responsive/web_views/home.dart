import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/utils/route_util.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/views/responsive/web_views/extra_large_category_web.dart';
import 'package:news_app/views/responsive/web_views/web_app_drawer.dart';
import 'package:provider/provider.dart';

import 'extra_large_detail_web.dart';

class ExtraLargeWebHomeView extends StatefulWidget {
  const ExtraLargeWebHomeView({super.key});

  @override
  State<ExtraLargeWebHomeView> createState() => _ExtraLargeWebHomeViewState();
}

class _ExtraLargeWebHomeViewState extends State<ExtraLargeWebHomeView> {
  NewsViewModel? _newsViewModel;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      key: _key,
      drawer: WebAppDrawer(_newsViewModel!),
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
        title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
        leading: Padding(
          padding: EdgeInsets.only(left: 5),
          child: InkWell(
            onTap: (){
              _key.currentState!.openDrawer();
            },
            child: Image.asset("assets/images/Menu.png"),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushReplacement(RouteUtil.createRoute(ExtraLargeWebCategory()));
              },
              child: Image.asset("assets/images/category_icon.png", width: 40,height: 40,),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: _newsViewModel!.fetchInitialHeadlinesNews("bbc-news"),
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
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
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
                        controller: scrollController,
                      ),
                    ),
                  );
                },
              );
            }
          }
        ),
      ),
    );
  }
}
