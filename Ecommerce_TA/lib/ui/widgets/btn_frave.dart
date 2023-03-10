part of 'widgets.dart';

class BtnFrave extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double border;
  final Color colorText;
  final Color backgroundColor;
  final double fontSize;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;

  const BtnFrave(
      {Key? key,
      required this.text,
      this.width = double.infinity,
      this.onPressed,
      this.height = 50,
      this.border = 8.0,
      this.colorText = Colors.white,
      this.fontSize = 19,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = ColorsFrave.primaryColorFrave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border))),
        child: TextFrave(text: text, color: colorText, fontSize: fontSize),
        onPressed: onPressed,
      ),
    );
  }
}
