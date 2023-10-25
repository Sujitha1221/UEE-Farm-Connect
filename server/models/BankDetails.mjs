import mongoose from "mongoose";
const Schema = mongoose.Schema;

const BankSchema = new Schema({
  email: {
    type: String,
    required: true,
  },
  bankName: {
    type: String,
    required: true,
  },
  branchName: {
    type: String,
    required: true,
  },
  branchNumber: {
    type: Number,
    required: true,
  },
  accountNumber: {
    type: Number,
    required: true,
  },
});

const Bank = mongoose.model("bankDetail", BankSchema);

export default Bank;
