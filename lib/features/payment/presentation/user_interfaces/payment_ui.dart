import 'package:app/core/blocs/application_state.dart';
import 'package:app/core/blocs/cubit_factory.dart';
import 'package:app/core/components/custom_scaffold.dart';
import 'package:app/core/components/garbo_button.dart';
import 'package:app/features/payment/presentation/business_components/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentUI extends StatefulWidget {
  const PaymentUI({Key? key}) : super(key: key);

  @override
  State<PaymentUI> createState() => _PaymentUIState();
}

class _PaymentUIState extends State<PaymentUI> {
  final PaymentCubit paymentCubit = CubitFactory.paymentCubit;
  final CardFormEditController controller = CardFormEditController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: CustomScaffold(
        title: 'Pagamento',
        body: BlocConsumer<PaymentCubit, ApplicationState>(
          bloc: paymentCubit,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                CardFormField(
                  style: CardFormStyle(
                    backgroundColor: Colors.grey[800],
                    borderRadius: 8,
                  ),
                  controller: controller,
                ),
                const SizedBox(
                  height: 32,
                ),
                GarboButton(
                    text: 'Pagar',
                    isLoading: state is PaymentLoadingState,
                    onPressed: () {
                      paymentCubit.startPayment(
                          BillingDetails(email: 'ruben.xb@hotmail.com'), []);
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}
