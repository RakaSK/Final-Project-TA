part of 'helpers.dart';

void modalStatusBayar(BuildContext context, String status, String users,
    String email, DateTime createdAt, int uidOrderBuy, String picture) {
  final productBloc = BlocProvider.of<ProductBloc>(context);
  final mediaQuery = MediaQuery.of(context);

  // final ResponseOrderBuy orderBuy;

  showDialog(
    context: context,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        // height: 550,
        height: mediaQuery.size.height * 0.74,
        width: mediaQuery.size.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close))
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            picture == null || picture == ""
                ? Column(
                    children: [
                      SizedBox(height: 200),
                      Text('Bukti pembayaran belum di upload!'),
                      SizedBox(height: 120),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        height: mediaQuery.size.height * 0.45,
                        width: mediaQuery.size.height * 0.348,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(URLS.baseUrl + picture))),
                      ),
                    ],
                  ),
            const SizedBox(height: 35.0),
            TextFrave(
              text:
                  'Pembeli = ${users}\nEmail = ${email}\nTanggal = ${createdAt.day.toString() + " - " + createdAt.month.toString() + " - " + createdAt.year.toString()}',
              maxLines: 5,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon(Icons.checklist_rounded, color: Color(0xff0C6CF2)),
                    BtnFrave(
                      // icon: Icon(
                      //   Icons.checklist_rounded,
                      //   color: Color(0xff0C6CF2),
                      //   size: 20,
                      // ),
                      height: 45,
                      width: 130,
                      text: 'Yes',
                      backgroundColor: Colors.green[500]!,
                      // color: (status == 0) ? Colors.red : Colors.green,
                      onPressed: () {
                        if (picture == null || picture == "") {
                          print('belum ada bukti bayar');
                          Navigator.pop(context);
                          modalWarning(context, "Belum ada bukti bayar");
                        } else {
                          productBloc.add(OnUpdateStatusPembayaranEvent(
                              uidOrderBuy.toString(),
                              (status == 0) ? '0' : '1'));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    BtnFrave(
                      height: 45,
                      width: 130,
                      text: 'No',
                      backgroundColor: Colors.red[500]!,
                      // color: (status == 0) ? Colors.red : Colors.green,
                      onPressed: () {
                        if (picture == null || picture == "") {
                          print('belum ada bukti bayar');
                          Navigator.pop(context);
                          modalWarning(context, "Belum ada bukti bayar");
                        } else {
                          productBloc.add(OnUpdateStatusPembayaranEvent(
                              uidOrderBuy.toString(),
                              (status == 1) ? '1' : '0'));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
