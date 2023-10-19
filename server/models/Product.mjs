import mongoose from "mongoose";

const productSchema = new mongoose.Schema(
  {
    productName: {
      type: String,
      required: true,
    },
    farmerName: {
      type: String,
      required: true,
    },
    quantity: {
      type: Number,
      required: true,
    },
    amountPerkg: {
      type: Number,
      required: true,
    },
    expiryDate:{
        type:Date,
        required:true
    },
    photo: {
      type:String
    }
}

);

export default mongoose.model("Product", productSchema);