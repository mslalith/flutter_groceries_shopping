import 'package:flutter/material.dart' show required;

class Product {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final String weight;
  final String description;

  const Product({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.imagePath,
    @required this.weight,
    @required this.description,
  });
}

const List<Product> products = <Product>[
  Product(
    id: 1,
    name: 'Flour Bulk Pizzeria',
    price: 23.98,
    imagePath: 'images/flour_bulk_pizzeria.png',
    weight: '5kg',
    description: 'Classica is a flour blend obtained by milling selected tender grains of domestic and foreign origin. It is recommended for working using the direct method with medium leavening times, and is suitable for the preparation of traditional Neapolitan pizza.',
  ),
  Product(
    id: 2,
    name: 'Truffle Crunchy Peanuts',
    price: 9.78,
    imagePath: 'images/truffle_crunchy_peanuts.png',
    weight: '120g',
    description: 'A truffle snack you will not be able to do without. It\'s a classic snack and a nice accent in creative salads and other courses as decoration.',
  ),
  Product(
    id: 3,
    name: 'Cereal Rusks Fette Biscottate',
    price: 4.78,
    imagePath: 'images/cereal_rusks_fette_biscottate.png',
    weight: '125g',
    description: 'Carefully prepared with only the best ingredients, these Cereal Rusks are absolutely delicious! You can use these crunchy Rusks for almost anything. Pair with jam, butter and spreads of all sorts!',
  ),
  Product(
    id: 4,
    name: 'White Truffles and Porcini Sauce',
    price: 9.78,
    imagePath: 'images/white_truffles_and_porcini_sauce.png',
    weight: '180g',
    description: 'White truffles and porcini is a classic: now you can taste this delicious combination in a few easy steps! Add the sauce to your risotto or tagliatelle and your gourmet specialty food is ready to serve.',
  ),
  Product(
    id: 5,
    name: 'Amarena Wild Cherries in Syrup',
    price: 16.98,
    imagePath: 'images/amarena_wild_cherries_in_syrup.png',
    weight: '600g',
    description: 'The ultimate symbol and flavor of Fabbri: a world icon. Amarena Fabbri is demi glacé and preserved in syrup, using a secret recipe passed down through the generations, with the same loving care as a hundred years ago. A versatile ingredient in sweets or savories... or simply to eat as is.',
  ),
  Product(
    id: 6,
    name: 'Nocciolata Organic Hazelnut Spread with Cocoa and Milk',
    price: 5.48,
    imagePath: 'images/nocciolata_organic_hazelnut_spread_with_cocoa_and_milk.png',
    weight: '270g',
    description: 'Nocciolata Dairy Free has a deep chocolate flavor, balanced by the generosity of hazelnuts. Perfect if you are lactose intolerant or milk allergic, if you follow a vegan diet, or if you simply prefer a more intense taste!',
  ),
  Product(
    id: 7,
    name: 'Organic Extra Dark Chocolate Bar',
    price: 6.98,
    imagePath: 'images/organic_extra_dark_chocolate_bar.png',
    weight: '70g',
    description: '100% Ecuador cocoa, single-origin organic bar. A fine selection of Fino Aromatico - Criollo Blanco and Nacional Amendolado cocoa. Cultivated following the ancestral technique of the Chakra, calling for the presence of a diverse variety of tree species in the cultivar, Ecuador cocoa has a very aromatic intensity and aroma with toasted notes, as well as hints of nuts and Taggiasca olives.',
  ),
];
