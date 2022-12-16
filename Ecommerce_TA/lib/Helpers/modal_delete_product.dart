part of 'helpers.dart';

void modalDeleteProduct(
    BuildContext context, String name, String image, String uidProduct) {
  final productBloc = BlocProvider.of<ProductBloc>(context);

  showDialog(
    context: context,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 196,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Icon(Icons.close))
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            const TextFrave(text: 'Hapus produk ini?'),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 7, image: NetworkImage(URLS.baseUrl + image))),
                ),
                const SizedBox(width: 10.0),
                TextFrave(
                  text: name,
                  maxLines: 2,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            BtnFrave(
              height: 45,
              text: 'DELETE',
              fontWeight: FontWeight.bold,
              onPressed: () {
                productBloc.add(OnDeleteProductEvent(uidProduct));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}
