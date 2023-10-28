import Payment from "../models/Payment.mjs";

export const newPayment = async (req, res) => {
  const { userNameTo, userNameFrom, amount } = req.body;

  Payment.create({
    userName: userNameFrom,
    amount,
    type: "Send",
    transactionDateTime: new Date(),
  })
    .then((Payment) => {
      console.log({ status: "Success", Payment });
      //return res.json(Payment);
    })
    .catch((err) => {
      console.log({ status: "Error", err });
      return res.json({ status: "Error", err });
    });

    Payment.create({
      userName: userNameTo,
      amount,
      type: "Receive",
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
  const { userNameTo, userNameFrom, amount } = req.body;
  var paymentTemp;

  Payment.findOne({ userName: userNameTo })
    .then((Payment) => {
      paymentTemp = parseInt(Payment.amount);
      paymentTemp = paymentTemp + parseInt(amount);

      Payment.amount = paymentTemp;

      Payment.save()
        .then((Payment) => {
          //return res.json(Payment);
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

    Payment.findOne({ userName: userNameFrom })
    .then((Payment) => {
      paymentTemp = parseInt(Payment.amount);
      paymentTemp = paymentTemp - parseInt(amount);

      Payment.amount = paymentTemp;

      Payment.save()
        .then((Payment) => {
          return res.json({ status: "Success" });
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

export const getRevenue = async (req, res) => {
  try {
    // Extracting userName and type from the query parameters
    const { userName, type } = req.query;

    if (!userName || !type) {
      return res
        .status(400)
        .send({ error: "userName and type are required query parameters" });
    }

    // Fetching the payments
    const payments = await Payment.find({ userName, type });

    // Sending the payments as a response
    res.json(payments);
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: "Internal Server Error" });
  }
};
