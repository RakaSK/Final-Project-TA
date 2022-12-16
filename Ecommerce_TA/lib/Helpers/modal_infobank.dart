part of 'helpers.dart';

void modalInfoBank(BuildContext context, String text,
    {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: SizedBox(
          height: 350,
          child: Column(
            children: [
              Row(
                children: const [
                  TextFrave(
                      text: 'DNI ',
                      color: ColorsFrave.primaryColorFrave,
                      fontWeight: FontWeight.w500),
                  TextFrave(text: 'Shop', fontWeight: FontWeight.w500),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              Container(
                height: 85,
                width: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/Pik.png'))
                    // shape: BoxShape.circle,
                    // gradient: LinearGradient(
                    //     begin: Alignment.centerLeft,
                    //     colors: [Colors.white, ColorsFrave.primaryColorFrave])
                    ),
              ),
              const SizedBox(height: 30.0),
              TextFrave(text: text, fontSize: 17, fontWeight: FontWeight.bold),
              const SizedBox(height: 30.0),
              InkWell(
                onTap: onPressed,
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 150,
                  decoration: BoxDecoration(
                      color: ColorsFrave.primaryColorFrave,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const TextFrave(
                      text: 'Done', color: Colors.white, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
