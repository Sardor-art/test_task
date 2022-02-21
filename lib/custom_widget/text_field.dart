import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool? showError;
  final TextEditingController? controller;
  final bool? autoFocus;
  final Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? errorText;
  final TextInputAction? inputAction;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final String? hintText;
  final Color? fillColor;
  final Function()? onTap;
  final bool? readOnly;
  final double? labelPadding;
  final bool? isResizable;
  final TextStyle? labelStyle;

  const CustomTextField({
    Key? key,
    this.labelText = '',
    this.showError,
    this.controller,
    this.autoFocus,
    this.onChanged,
    this.keyboardType,
    this.prefixText,
    this.fillColor,
    this.isResizable = false,
    this.errorText,
    this.inputAction,
    this.currentFocus,
    this.nextFocus,
    this.hintText,
    this.onTap,
    this.labelPadding = 4,
    this.labelStyle,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: labelText.isNotEmpty ? 12 : 0),
        Visibility(
          visible: labelText.isNotEmpty,
          child: RichText(
            text: TextSpan(
              text: labelText,
              style: labelStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black45,
                  ),
            ),
          ),
        ),
        SizedBox(height: labelPadding),
        TextFormField(
          readOnly: readOnly ?? false,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black38,
          ),
          controller: controller,
          focusNode: currentFocus,
          onTap: onTap,
          maxLines: (isResizable ?? false) ? null : 1,
          autofocus: autoFocus ?? false,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
          onFieldSubmitted: (term) {},
          textInputAction: inputAction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            filled: true,
            hintText: hintText,
            fillColor: fillColor ?? Colors.white,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorText: showError ?? false ? errorText : null,
          ),
          cursorColor: Colors.green,
          keyboardType: keyboardType,
        ),
        SizedBox(height: labelText.isNotEmpty ? 12 : 0),
      ],
    );
  }
}
