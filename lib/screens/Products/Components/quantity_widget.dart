import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  final int initialCount;
  final int minCount;
  final int maxCount;

  const QuantityWidget({
    Key? key,
    this.initialCount = 0,
    this.minCount = 0,
    this.maxCount = 100,
  }) : super(key: key);

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
    _controller.text = _count.toString();
  }

  void _incrementCount() {
    if (_count < widget.maxCount) {
      setState(() {
        _count++;
        _controller.text = _count.toString();
      });
    }
  }

  void _decrementCount() {
    if (_count > widget.minCount) {
      setState(() {
        _count--;
        _controller.text = _count.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrementCount,
        ),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: _controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
              isDense: true,
              contentPadding:
                  EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              int? newValue = int.tryParse(value);
              if (newValue != null &&
                  newValue >= widget.minCount &&
                  newValue <= widget.maxCount) {
                setState(() {
                  _count = newValue;
                });
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
            color: kprimaryColor,
          ),
          onPressed: _incrementCount,
        ),
      ],
    );
  }
}
