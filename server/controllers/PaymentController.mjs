import Payment from "../models/Payment.mjs";

export const newPayment = async (req, res) => {
  const { userNameTo, userNameFrom, amount } = req.body;

  Payment.create({
    userName: userNameFrom,
    amount,
    type: "credit",
    transactionDateTime: new Date(),
  })
    .then((Payment) => {
      console.log({ status: "Success", Payment });
      return res.json(Payment);
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });

    Payment.create({
      userName: userNameTo,
      amount,
      type: "debit",
      transactionDateTime: new Date(),
    })
      .then((Payment) => {
        console.log({ status: "Success", Payment });
        return res.json({ status: "Success" });
      })
      .catch((err) => {
        console.log({ status: "Error", err });
        return res.json({ status: "Error", err });
      });
};

export const getAllPaymentByUser = async (req, res) => {
  let userName = req.params.id;

  Payment.find({ userName: userName })
    .then((Payment) => {
      return res.json(Payment);
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};

export const updatePayment = async (req, res) => {
  const { userName, amount, type } = req.body;
  var paymentTemp;

  Payment.findOne({ userName: userName })
    .then((Payment) => {

      if (type == "credit") {
        paymentTemp = parseInt(Payment.amount);
        paymentTemp = paymentTemp + parseInt(amount);
      } else if (type == "debit") {
        paymentTemp = parseInt(Payment.amount);
        paymentTemp = paymentTemp - parseInt(amount);
      }

      Payment.amount = paymentTemp;

      Payment.save()
        .then((Payment) => {
          return res.json(Payment);
        })
        .catch((err) => {
          console.log({ status: "Error", err });
          return res.json({ status: "Error", err });
        });
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });
};
