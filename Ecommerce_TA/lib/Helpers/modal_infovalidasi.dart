part of 'helpers.dart';

void modalinfovalidasi(BuildContext context, String text1, String text2,
    {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (BuildContext context1) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: SizedBox(
          height: 265,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  // GestureDetector(
                  //   onTap: () {
                  //     print("X");
                  //     Navigator.of(context1).pop();
                  //   },
                  //   child: Text("X"),
                  // )
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              // Container(
              //     height: 90,
              //     width: 90,
              //     decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         gradient: LinearGradient(
              //             begin: Alignment.centerLeft,
              //             colors: [
              //               Colors.white,
              //               ColorsFrave.primaryColorFrave
              //             ])),
              //     child: Container(
              //       margin: const EdgeInsets.all(10.0),
              //       decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: ColorsFrave.primaryColorFrave),
              //       child:
              //           const Icon(Icons.check, color: Colors.white, size: 38),
              //     )),
              // const SizedBox(height: 35.0),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFrave(
                        text: text1, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.red[200],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFrave(
                        text: text2, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.green[300],
                    ),
                  ),
                ],
              ),
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
