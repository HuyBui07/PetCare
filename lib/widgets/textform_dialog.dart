import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class TextFormDialog extends StatefulWidget {
  String label;
  String value;
  bool isMandatory;
  final Function onTap;
  TextFormDialog(this.label, this.value, this.isMandatory,
      {super.key, required this.onTap});

  @override
  State<TextFormDialog> createState() => _TextFormDialogState();
}

class _TextFormDialogState extends State<TextFormDialog> {
  Color _color = AppColors.gray;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _color = _color == AppColors.gray ? AppColors.violet : AppColors.gray;
        });
        widget.onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                    color: _color,
                    fontSize: scaleW(9, context),
                    fontWeight: FontWeight.w500),
              ),
              widget.isMandatory
                  ? const Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    )
                  : Container()
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1, color: _color))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.value,
                    style: TextStyle(
                      fontSize: scaleW(15, context),
                    )),
                const Icon(
                  Icons.navigate_next,
                  color: AppColors.gray,
                  size: 40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
