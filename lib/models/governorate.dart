




class Governorate {
  final String id;
  final String title;
  final String imageURL;
  final String countActive;
  const Governorate({
    required this.countActive,
    required this.id,
    required this.title,
    required this.imageURL,
  });
  const Governorate.searsh(this.id, this.countActive, {
    required this.title,
    required this.imageURL,
  });
}
