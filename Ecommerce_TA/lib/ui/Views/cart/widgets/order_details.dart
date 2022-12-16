import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      height: 65,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextFrave(
                text: 'Order',
                fontSize: 19,
              ),
              TextFrave(
                text: '\Rp ${productBloc.state.total.toInt()}',
                fontSize: 19,
              )
            ],
          ),
          // const SizedBox(height: 10.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const TextFrave(
          //       text: 'Delivery',
          //       fontSize: 19,
          //     ),
          //     TextFrave(
          //       text: '\Rp ${productBloc.state.delivery.toInt()}',
          //       fontSize: 19,
          //     )
          //   ],
          // ),
          // const SizedBox(height: 10.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const TextFrave(
          //       text: 'Insurance',
          //       fontSize: 19,
          //     ),
          //     TextFrave(
          //       text: '\Rp ${productBloc.state.insurance.toInt()}',
          //       fontSize: 19,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
