import 'dart:convert';

import 'package:app/core/blocs/application_state.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'payment_state.dart';

class PaymentCubit extends Cubit<ApplicationState> {
  PaymentCubit() : super(const PaymentInitialState());

  Future<void> startPayment(
      BillingDetails billingDetails, List<Map<String, dynamic>> items) async {
    emit(const PaymentLoadingState());

    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: billingDetails,
        ),
      ),
    );

    final paymentIntentResult = await _callPayEndpointMethodId(
      useStripeSdk: true,
      paymentMethodId: paymentMethod.id,
      currency: 'eur',
      items: items,
    );

    if (paymentIntentResult['error'] != null) {
      // Error creating or confirming the payment intent.
      emit(const PaymentFailureState());
    }

    if (paymentIntentResult['clientSecret'] != null &&
        paymentIntentResult['requiresAction'] == null) {
      // The payment succeeded / went through.
      emit(const PaymentSuccessState());
    }

    if (paymentIntentResult['clientSecret'] != null &&
        paymentIntentResult['requiresAction'] == true) {
      final String clientSecret = paymentIntentResult['clientSecret'];
      confirmPaymentIntent(clientSecret);
    } else {}
  }

  Future<void> confirmPaymentIntent(String clientSecret) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(clientSecret);

      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        // Call API to confirm intent
        final results =
            await _callPayEndpointIntentId(paymentIntentId: paymentIntent.id);

        if (results['error'] != null) {
          emit(const PaymentFailureState());
        } else {
          emit(const PaymentSuccessState());
        }
      }
    } catch (err) {
      print(err);
      emit(const PaymentFailureState());
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    final url = Uri.parse(
      'https://us-central1-garbo-dcb3a.cloudfunctions.net/StripePayEndpointMethodId',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'useStripeSdk': useStripeSdk,
        'paymentMethodId': paymentMethodId,
        'currency': currency,
        'items': items
      }),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _callPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse(
      'https://us-central1-garbo-dcb3a.cloudfunctions.net/StripePayEndpointIntentId',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'paymentIntentId': paymentIntentId,
      }),
    );
    return json.decode(response.body);
  }
}
