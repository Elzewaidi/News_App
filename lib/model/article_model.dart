class ArticleModel {
  final String? url;
  final String? title;
  final String? author;
  final String? publishedAt;
  final String? urlToImage;
  final String? sourceName;
  final String? description;
  final String? content;

  ArticleModel({
    this.url,
    this.title,
    this.author,
    this.publishedAt,
    this.urlToImage,
    this.sourceName,
    this.description,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      url: json['url'] as String?,
      title: json['title'] as String?,
      author: json['author'] as String?,
      publishedAt: json['publishedAt'] as String?,
      urlToImage: json['urlToImage'] as String?,
      sourceName: json['source'] != null ? json['source']['name'] as String? : null,
      description: json['description'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'author': author,
      'publishedAt': publishedAt,
      'urlToImage': urlToImage,
      'source': {'name': sourceName},
      'description': description,
      'content': content,
    };
  }
}
