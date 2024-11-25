///Represents article from database for Information screen
class Article {
  ///Title of the article
  final String title;

  ///Date when article was published
  final String publishedDate;

  ///Author of the article
  final String author;

  ///Link to the article
  final String url;

  ///Content of the article
  final String body;

  ///Path to the representative image of the article
  final String pathToImage;

  Article(this.title, this.publishedDate, this.author, this.url, this.body,
      this.pathToImage);
}
