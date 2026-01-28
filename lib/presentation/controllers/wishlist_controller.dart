import 'package:get/get.dart';

class WishListController extends GetxController {
  var wishlistItems = <Map<String, dynamic>>[].obs;

  void removeFromWishlist(dynamic item) {
    wishlistItems.remove(item);
  }

  void addToCart(dynamic item) {
    // Add to cart logic here
    print('Added to cart: ');
  }

  var selectedIndex = 0.obs;

  final List<String> itemType = [
    " All ",
    "Clothes",
    "Shoes",
    "Bag",
    "Bottle",
    "Watch",
    "Jewelry",
    "Electronics",
  ];

  final List<Map<String, String>> images = [
    {
      "image":
      "https://miro.medium.com/v2/resize:fit:1100/format:webp/0*f8p_nFCjZwsaTS-M",
      "title": "Snake Leather Bag",
      "rate": "4.5",
      "sold": "8,374",
      "price": "\$445.00",
    },
    {
      "image": "https://images.unsplash.com/photo-1626947346165-4c2288dadc2a",
      "title": "Suga Leather Shoes",
      "rate": "4.7",
      "sold": "7,483",
      "price": "\$375.00",
    },
    {
      "image":
      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSJIUF7LejgnSF9PvSJanKfNhRMw2Nq6CVaaZs5B99BT0OIVwD7",
      "title": "Leather Casual Suit",
      "rate": "4.3",
      "sold": "6,937",
      "price": "\$420.00",
    },
    {
      "image":
      "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTHcinNTFDvJLaRlxXvzMN7o2uWABf7wCcWXHkiT94TmKY3nz6Y",
      "title": "Black Leather Bag",
      "rate": "4.9",
      "sold": "8,174",
      "price": "\$765.00",
    },{
      "image":
      "https://miro.medium.com/v2/resize:fit:1100/format:webp/0*f8p_nFCjZwsaTS-M",
      "title": "Snake Leather Bag",
      "rate": "4.5",
      "sold": "8,374",
      "price": "\$445.00",
    },
    {
      "image": "https://images.unsplash.com/photo-1626947346165-4c2288dadc2a",
      "title": "Suga Leather Shoes",
      "rate": "4.7",
      "sold": "7,483",
      "price": "\$375.00",
    },
    {
      "image":
      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSJIUF7LejgnSF9PvSJanKfNhRMw2Nq6CVaaZs5B99BT0OIVwD7",
      "title": "Leather Casual Suit",
      "rate": "4.3",
      "sold": "6,937",
      "price": "\$420.00",
    },
    {
      "image":
      "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTHcinNTFDvJLaRlxXvzMN7o2uWABf7wCcWXHkiT94TmKY3nz6Y",
      "title": "Black Leather Bag",
      "rate": "4.9",
      "sold": "8,174",
      "price": "\$765.00",
    },{
      "image":
      "https://miro.medium.com/v2/resize:fit:1100/format:webp/0*f8p_nFCjZwsaTS-M",
      "title": "Snake Leather Bag",
      "rate": "4.5",
      "sold": "8,374",
      "price": "\$445.00",
    },
    {
      "image": "https://images.unsplash.com/photo-1626947346165-4c2288dadc2a",
      "title": "Suga Leather Shoes",
      "rate": "4.7",
      "sold": "7,483",
      "price": "\$375.00",
    },
    {
      "image":
      "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSJIUF7LejgnSF9PvSJanKfNhRMw2Nq6CVaaZs5B99BT0OIVwD7",
      "title": "Leather Casual Suit",
      "rate": "4.3",
      "sold": "6,937",
      "price": "\$420.00",
    },
    {
      "image":
      "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTHcinNTFDvJLaRlxXvzMN7o2uWABf7wCcWXHkiT94TmKY3nz6Y",
      "title": "Black Leather Bag",
      "rate": "4.9",
      "sold": "8,174",
      "price": "\$765.00",
    },
  ];

  void changeCategory(int index) {
    selectedIndex.value = index;
  }
}

