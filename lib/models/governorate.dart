




class Governorate {
  final String id;
  final String title;
  final String imageURL;

  const Governorate({

    required this.id,
    required this.title,
    required this.imageURL,
  });
  const Governorate.searsh(this.id,  {
    required this.title,
    required this.imageURL,
  });
}
