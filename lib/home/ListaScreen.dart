import 'dart:ui';

import 'package:anime_plus/models/AnimeListItem.dart';
import 'package:anime_plus/template/hotel_booking/filters_screen.dart';
import 'package:anime_plus/util/AnimeTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AnimeListView.dart';

class ListaScreen extends StatefulWidget {

  final String titulo;
  final String tipo;

  ListaScreen({
    this.titulo = '',
    this.tipo = ''
  });

  @override
  _ListaScreenState createState() => _ListaScreenState(titulo: titulo, tipo: tipo);
}

class _ListaScreenState extends State<ListaScreen>
    with TickerProviderStateMixin {

  final TextEditingController busquedaController = TextEditingController();
  AnimationController animationController;
  List<AnimeListItem> animeList;

  final String titulo;
  final String tipo;

  _ListaScreenState({
    this.titulo = '',
    this.tipo = ''
  });


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    animeList = await AnimeListItem.getLista(tipo);
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AnimeTheme.buildLightTheme(),
      child: Container(child: Scaffold(
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  getAppBarUI(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData)
                          return SpinKitRipple(
                            color: Colors.deepOrange,
                            size: 300.0,
                          );
                        else
                          return Column(
                              children: <Widget>[
                                getSearchBarUI(),
                                getFilterBarUI(),
                                getListUI()
                              ]
                          );
                      },
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ))
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AnimeTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, 2), blurRadius: 8.0)],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height - 50,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  onTap: () => Navigator.pop(context),
                  child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.arrow_back)),
                ),
              ),
            ),
            Expanded(child: Center(child: Text(titulo, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22))),
            )
          ],
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AnimeTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(38.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: busquedaController,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: AnimeTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'One Piece...',
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: AnimeTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(38.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                onTap: () {
                  var busqueda = busquedaController.text.trim();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListaScreen(titulo: busqueda, tipo: 'buscar/' + busqueda)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                      FontAwesomeIcons.search,
                      size: 20,
                      color: Color(0xFFEA6624)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(top: 0, left: 0, right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AnimeTheme
                  .buildLightTheme()
                  .backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: AnimeTheme
              .buildLightTheme()
              .backgroundColor,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        tipo == 'portada' ? '20 animes en portada' : animeList
                            .length.toString() + ' animes encontrados',
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 16)),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text('Filtro', style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort, color: AnimeTheme
                                .buildLightTheme()
                                .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(top: 0, left: 0, right: 0, child: Divider(height: 1),
        )
      ],
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: AnimeTheme
            .buildLightTheme()
            .backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 259,
            child: ListView.builder(
              itemCount: animeList.length,
              padding: const EdgeInsets.only(top: 8),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final int count = animeList.length > 10 ? 10 : animeList.length;
                final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval( (1 / count) * index, 1.0, curve: Curves.fastOutSlowIn))
                );
                animationController.forward();
                return AnimeListView(
                  callback: () {},
                  animeItem: animeList[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
