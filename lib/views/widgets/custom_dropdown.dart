import 'package:scan_me_plus/export.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T?> dropdownItems;
  final T? dropdownValue;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final String? label;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final InputBorder? decoration;
  final String? Function(dynamic)? validate;
  final Function(dynamic)? onChanged;
  final FocusNode? focusNode;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    required this.dropdownItems,
    this.dropdownValue,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.hint,
    this.label,
    this.hintStyle,
    this.fillColor,
    this.decoration,
    this.focusNode,
    this.validate,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        Flexible(
          child: DropdownButtonFormField2(
            decoration: inputDecoration(context),
            onChanged: onChanged,
            focusNode: focusNode,
            isExpanded: true,
            value: dropdownValue,
            isDense: true,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              maxHeight: 200.h,
              

            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.colorTextSecondary,
                ),
            validator: validate,
            items: dropdownItems.map<DropdownMenuItem<T>>((value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  inputDecoration(context) => InputDecoration(
        errorMaxLines: 2,
        filled: true,
        isCollapsed: true,
        isDense: true,
        counterText: '',
        contentPadding: contentPadding ??
            EdgeInsets.only(
                top: dropdownValue != null && dropdownValue != '' ? 10.h : 6.w,
                bottom: dropdownValue != null && dropdownValue != '' ? 10.h : 12.h,
                right: 3.w,
                left:
                    dropdownValue != null && dropdownValue != '' ? 0.w : 15.w),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: hintStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.colorTextSecondary,
                ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: fillColor ?? Colors.transparent,
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
      );
}
