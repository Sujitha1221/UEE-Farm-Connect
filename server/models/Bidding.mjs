import mongoose from "mongoose";

const BiddingSchema = new mongoose.Schema({
  farmerUserName: {
    type: String,
    required: true,
  },

  userName: {
    type: String,
    required: true,
  },

  productName: {
    type: String,
    required: true,
  },

  weight: {
    type: String,
    required: true,
  },

  amountPerKg: {
    type: String,
    required: true,
  },

  totalAmount: {
    type: String,
    required: true,
  },

  status: {
    type: String,
    required: true,
  },

  creationDateTime: {
    type: String,
    required: true,
  },
});

export default mongoose.model("Bidding", BiddingSchema);
