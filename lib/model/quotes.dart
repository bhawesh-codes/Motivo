// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import 'dart:convert';

List<Quote> quoteFromJson(String str) => List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
    int id;
    String text;
    String author;
    String category;

    Quote({
        required this.id,
        required this.text,
        required this.author,
        required this.category,
    });

    factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        text: json["text"],
        author: json["author"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "author": author,
        "category": category,
    };
}
