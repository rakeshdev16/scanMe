import 'package:scan_me_plus/export.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool isReadOnly;
  final bool isRequired;
  final Function(String)? onChange;
  final FocusNode focusNode;
  final int? minLines;
  final Color? fillColor;
  final InputBorder? decoration;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Widget? suffixIconWidget;
  final EdgeInsets? padding;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    required this.focusNode,
    this.validator,
    this.padding,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.keyboardType,
    this.onChange,
    this.onFieldSubmitted,
    this.minLines,
    this.fillColor,
    this.decoration,
    this.textInputAction,
    this.suffixIconWidget,
    this.isRequired = false,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null && label != ''
            ? RichText(
                text: TextSpan(
                    text: label ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 12.5.sp),
                    children: [
                      isRequired == true
                          ? const TextSpan(
                              text: '*', style: TextStyle(color: Colors.red))
                          : const WidgetSpan(child: SizedBox())
                    ]),
              ).paddingOnly(bottom: 8.w)
            : const SizedBox(),
        TextFormField(
          controller: controller,
          validator: validator,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
          readOnly: isReadOnly,
          onChanged: onChange,
          focusNode: focusNode,
          minLines: minLines,
          onFieldSubmitted: onFieldSubmitted,
          style: Theme.of(context).textTheme.bodyMedium,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: fillColor ?? Colors.transparent,
            contentPadding: padding ??
                EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.colorTextSecondary,
                ),
            suffix: suffixIconWidget,
            errorMaxLines: 2,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: decoration ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.5.w),
                  borderRadius: BorderRadius.circular(10.r),
                ),
            enabledBorder: decoration ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.5.w),
                  borderRadius: BorderRadius.circular(10.r),
                ),
            disabledBorder: decoration ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.5.w),
                  borderRadius: BorderRadius.circular(10.r),
                ),
            focusedBorder: decoration ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.5.w),
                  borderRadius: BorderRadius.circular(10.r),
                ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.5.w),
              borderRadius: BorderRadius.circular(10.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.5.w),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
