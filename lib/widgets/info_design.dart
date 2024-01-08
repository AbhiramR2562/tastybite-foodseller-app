import 'package:flutter/material.dart';
import 'package:food_seller_app/model/menus.dart';
import 'package:food_seller_app/pages/item_page.dart';

class InfoDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;
  InfoDesignWidget({super.key, this.model, this.context});

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemPage(
                    model: widget.model,
                  ))),
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
              const SizedBox(height: 5),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              Text(
                widget.model!.menuTitle!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  // fontFamily: "Train",
                ),
              ),
              Text(
                widget.model!.menuInfo!,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 10,
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
