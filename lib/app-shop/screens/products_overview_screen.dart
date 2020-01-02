import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';

import 'product_detail_screen.dart';
import 'cart_screen.dart';

enum FilterOptions { OnlyFavorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions choice) {
              setState(() {
                _showOnlyFavorites = choice == FilterOptions.OnlyFavorites;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOptions.OnlyFavorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: '${cart.itemCount}',
              child: child,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(onlyFavorites: _showOnlyFavorites),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  ProductsGrid({this.onlyFavorites});

  final bool onlyFavorites;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        onlyFavorites ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(products[i]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem(this.product, {Key key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: ProductFavoriteBadge(product),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
          ),
        ),
      ),
    );
  }
}

class ProductFavoriteBadge extends StatefulWidget {
  ProductFavoriteBadge(this.product, {Key key}) : super(key: key);
  final Product product;
  @override
  _ProductFavoriteBadgeState createState() => _ProductFavoriteBadgeState();
}

class _ProductFavoriteBadgeState extends State<ProductFavoriteBadge> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
      color: Theme.of(context).accentColor,
      onPressed: () {
        setState(() {
          widget.product.toggleFavoriteStatus();
        });
      },
    );
  }
}
