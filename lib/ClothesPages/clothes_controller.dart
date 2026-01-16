import 'package:get/get.dart';

class ClothesController extends GetxController {
  var selectedIndex = 0.obs;


  final List<Map<String, String>> images = [
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDzQhDzCkTFfxeXW7tTOFslXz7TPorp0OeE7ap52jKmHdNdeb8",
      "title": "Snake Leather Bag",
      "rate": "4.5",
      "sold": "8,374",
      "price": "\$445.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image":
          "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT3lRf4kFg8cJuQRiRTFwR8gzrqZlEAkwO9v-IsgGNkD7xIgpTQ",
      "title": "Suga Leather Shoes",
      "rate": "4.7",
      "sold": "7,483",
      "price": "\$375.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image":
          "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSJIUF7LejgnSF9PvSJanKfNhRMw2Nq6CVaaZs5B99BT0OIVwD7",
      "title": "Leather Casual Suit",
      "rate": "4.3",
      "sold": "6,937",
      "price": "\$420.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image":
          "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQfXi7qVYuvg9sK4T6Yh7uxoORDotUy_a4GRwog6nkG4okjhnAv",
      "title": "Black Leather Bag",
      "rate": "4.9",
      "sold": "8,174",
      "price": "\$765.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image":
          "https://miro.medium.com/v2/resize:fit:1100/format:webp/0*f8p_nFCjZwsaTS-M",
      "title": "Snake Leather Bag",
      "rate": "4.5",
      "sold": "8,374",
      "price": "\$445.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image": "https://images.unsplash.com/photo-1626947346165-4c2288dadc2a",
      "title": "Suga Leather Shoes",
      "rate": "4.7",
      "sold": "7,483",
      "price": "\$375.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image":
          "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSJIUF7LejgnSF9PvSJanKfNhRMw2Nq6CVaaZs5B99BT0OIVwD7",
      "title": "Leather Casual Suit",
      "rate": "4.3",
      "sold": "6,937",
      "price": "\$420.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    {
      "image":
          "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTHcinNTFDvJLaRlxXvzMN7o2uWABf7wCcWXHkiT94TmKY3nz6Y",
      "title": "Black Leather Bag",
      "rate": "4.9",
      "sold": "8,174",
      "price": "\$765.00",
      "reviews": "4.749 reviews",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
    },
    // baki items same
  ];

  void changeCategory(int index) {
    selectedIndex.value = index;
  }
}
