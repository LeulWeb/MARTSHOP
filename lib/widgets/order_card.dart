import 'dart:math';

import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final OrderItem order;
  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount}"),
            // ignore: todo
            //TODO: set subtitle with DateFormat()

            subtitle: Text(
              DateFormat("dd/mm/yy hh:mm").format(widget.order.date),
            ),

            trailing: IconButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              icon: expanded
                  ? const Icon(Icons.expand_more)
                  : const Icon(Icons.expand_less),
            ),
          ),

          //if in List will display something if it is true else noting
          if (expanded)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              // padding: const EdgeInsets.all(8),
              height: min(widget.order.items.length * 20 + 1, 180),
              child: ListView.builder(
                itemCount: widget.order.items.length,
                itemBuilder: (ctx, index) => Row(
                  children: [
                    Text(widget.order.items[index].title),
                    Spacer(),
                    Text(
                        "${widget.order.items[index].price}X ${widget.order.items[index].quantity}")
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
