import mongoose from "mongoose";

const PaymentSchema = new mongoose.Schema({
  userName: {
    type: String,
    required: true,
  },

  amount: {
    type: String,
    required: true,
  },

  type: {
    type: String,
    required: true,
  },

  transactionDateTime: {
    type: String,
    required: true,
  },
});

export default mongoose.model("Payment", PaymentSchema);
