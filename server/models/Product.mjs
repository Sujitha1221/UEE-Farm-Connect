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
      type: String,
      required: true,
    },
    amountPerkg: {
      type: Number,
      required: true,
    },
    expiryDate:{
        type:String,
        required:true
    },
    photo: {
      type:String
    }
}

);

export default mongoose.model("Product", productSchema);