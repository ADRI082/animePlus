class AnimeListItem {

  AnimeListItem({
    this.imagen = '',
    this.titulo = '',
  });

  String imagen;
  String titulo;

  static List<AnimeListItem> listaAnimes = <AnimeListItem>[
    AnimeListItem(
      imagen: 'assets/hotel/hotel_1.png',
      titulo: 'Grand Royal Hotel',
    ),
  ];

  String get subtitulo => 'prueba';

  get rating => 20.0;

  get reviews => 'prueba';
}
