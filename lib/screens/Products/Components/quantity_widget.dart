import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../models/Product/product_model.dart';

class QuantityWidget extends StatefulWidget {
  final int initialCount;
  final int minCount;
  final int? maxCount;
  final Alternative alternative;
  final Function(int value) callback;

  const QuantityWidget(
      {Key? key,
      this.initialCount = 1,
      required this.minCount,
      this.maxCount,
      required this.alternative,
      required this.callback})
      : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int _count;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
    _controller.text = widget.alternative.name != null
        ? '${(num.tryParse(widget.alternative.value!)! * _count)} ${widget.alternative.name}'
        : _count.toString();
  }

  void _incrementCount() {
    if (widget.maxCount == null) {
      setState(() {
        _count++;
        _controller.text = widget.alternative.name != null
            ? '${(num.tryParse(widget.alternative.value!)! * _count)} ${widget.alternative.name}'
            : _count.toString();
      });
      widget.callback(_count);
    } else if (_count < widget.maxCount!) {
      setState(() {
        _count++;
        _controller.text = widget.alternative.name != null
            ? '${(num.tryParse(widget.alternative.value!)! * _count)} ${widget.alternative.name}'
            : _count.toString();
      });
      widget.callback(_count);
    }
  }

  void _decrementCount() {
    if (_count > widget.minCount!) {
      setState(() {
        _count--;
        _controller.text = widget.alternative.name != null
            ? '${(num.tryParse(widget.alternative.value!)! * _count)} ${widget.alternative.name}'
            : _count.toString();
      });
      widget.callback(_count);

      // context.read<MainProvider>().detailButtonPriceSum =
      //     _count * context.read<MainProvider>().currentProductModel.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
          onPressed: _decrementCount,
        ),
        Flexible(
          // width: 40,
          child: TextFormField(
            readOnly: widget.alternative.name != null,
            controller: _controller,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(color: Colors.white)),
              isDense: true,
              contentPadding:
                  EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            ),
            keyboardType: widget.alternative.name != null
                ? TextInputType.text
                : TextInputType.number,
            onChanged: (value) {
              int? newValue = int.tryParse(value);
              if (newValue != null && newValue >= widget.minCount) {
                if (widget.maxCount == null) {
                  setState(() {
                    _count = newValue;
                    widget.callback(_count);
                  });
                } else if (newValue <= widget.maxCount!) {
                  setState(() {
                    _count = newValue;
                    widget.callback(_count);
                  });
                }
              } else {
                _controller.text =
                    _count.toString(); // Reset to current count if invalid
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _incrementCount,
        )
      ],
    );
  }
}
