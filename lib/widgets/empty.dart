import "package:flutter/material.dart";

class Empty extends StatelessWidget {
  const Empty({Key? key, this.emptyText = ":( Nothing to show"})
      : super(key: key);

  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Text(
            emptyText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 100,
            child: Image.asset(
              "assets/images/zzz.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
