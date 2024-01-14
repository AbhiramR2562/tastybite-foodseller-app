import 'package:flutter/material.dart';
import 'package:food_seller_app/model/items.dart';
import 'package:food_seller_app/pages/item_detail_page.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;
  ItemsDesignWidget({super.key, this.model, this.context});

  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailsPage(
                      model: widget.model,
                    )));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 295,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Text(
                widget.model!.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  // fontFamily: "Train",
                ),
              ),
              const SizedBox(height: 5),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              Text(
                widget.model!.shortInfo!,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
