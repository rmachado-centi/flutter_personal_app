const functions = require("firebase-functions");
const stripe = require("stripe")('sk_test_51NvKD1EVsP8g1CYLrRF8jrx9eZLbx9wMwTkZksyZGOv7RRUqPoDaDhZl2vQ1n8OdxprrCVnaSZ92czCquijOjEW000UkYi2aLQ');

const calculateOrderAmount = (items) => {
    prices = [];
    catalog = [
        { "id": "0", "price": 2.99 }, { "id": "0", "price": 2.99 }, { "id": "0", "price": 2.99 }, { "id": "0", "price": 2.99 }, { "id": "0", "price": 2.99 },
    ];

    items.forEach(item => {
        price = catalog.find(x => x.id == item.id).price;
        prices.push(price);
    });

    return parseInt(prices.reduce((a, b) => a + b) * 100);
}

const generateResponse = function (intent) {
    switch (intent.status) {
        case "requires-action":
            return {
                clientSecret: intent.clientSecret,
                requiresAction: true,
                status: intent.status,
            };
        case "requires_payment_method":
            return {
                "error": "Your card was denied, please provide a new payment method",
            };
        case "succeeded":
            console.log("Payment succeeded.");
            return { clientSecret: intent.clientSecret, status: intent.status, };
    }
    return { error: "Failed" };
}

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, items, currency, useStripeSdk } = req.body;

    console.log(items);

    const orderAmount = calculateOrderAmount(items);
    try {
        if (paymentMethodId) {
            const params = {
                amount: orderAmount,
                confirm: true,
                confirmation_method: "manual",
                currency: currency,
                payment_method: paymentMethodId,
                use_stripe_sdk: useStripeSdk,
            }
            const intent = await stripe.paymentIntents.create(params);
            console.log("Intent: ${intent}");
            return res.send(generateResponse(intent));
        }
    } catch (e) {

    }
});
exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body;
    try {
        if (paymentIntentId) {
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);
    } catch (e) {
        return res.send({ error: e.message });
    }
});