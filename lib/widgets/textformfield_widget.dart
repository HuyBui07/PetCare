import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class TextFormFieldCustom extends StatefulWidget {
  final Function onChanged;
  VoidCallback onTap;
  String label, value;
  bool isCheck, isReadOnly, isMandatory;

  TextFormFieldCustom(
      this.label, this.value, this.isCheck, this.isReadOnly, this.isMandatory,
      {super.key, required this.onChanged, required this.onTap});

  @override
  State<TextFormFieldCustom> createState() => _TextFormFillCustomState();
}

class _TextFormFillCustomState extends State<TextFormFieldCustom> {
  final TextEditingController _controller = TextEditingController();
  late Color _colorCheck;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colorCheck = widget.isCheck ? AppColors.green : AppColors.gray;
    _controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onTap: widget.onTap,
      readOnly: widget.isReadOnly ? true : false,
      //initialValue: widget.value,
      onChanged: (value) {
        widget.onChanged(value);
        value.isEmpty
            ? setState(() {
                _colorCheck = AppColors.gray;
              })
            : !widget.isCheck && !value.contains('@')
                ? setState(() {
                    _colorCheck = AppColors.gray;
                  })
                : _colorCheck = AppColors.green;
      },
      validator: (String? value) {
        return (value != null) ? 'Please enter your ${widget.label}!' : null;
      },
      style: TextStyle(fontSize: scaleW(15, context)),
      decoration: InputDecoration(
          suffixText: '*',
          suffixStyle: TextStyle(
            color: widget.isMandatory ? Colors.red : Colors.transparent,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.lightgrey2,
              width: 1.5,
            ),
          ),
          suffixIcon: widget.isCheck || widget.label == 'New email'
              ? Icon(
                  Icons.check_circle_rounded,
                  color: _colorCheck,
                )
              : widget.isReadOnly
                  ? Icon(
                      Icons.navigate_next,
                      color: AppColors.gray,
                      size: scaleW(35, context),
                    )
                  : null,
          hintText: 'Enter your ${widget.label}',
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColors.gray,
              ),
          floatingLabelStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColors.violet,
              ),
          hintStyle: TextStyle(fontSize: scaleW(12, context))),
    );
  }
}
