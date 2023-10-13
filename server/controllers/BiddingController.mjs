import Bidding from "../models/Bidding.mjs";

export const newBidding = async (req, res) => {
    const { farmerUserName, userName, productName, weight, amountPerKg, totalAmount } = req.body;
  
    Bidding.create({
        farmerUserName, 
        userName, 
        productName, 
        weight, 
        amountPerKg, 
        totalAmount,
        status: "pending",
        creationDateTime: new Date(),
    })
      .then((Bidding) => {
        console.log({ status: "Success", Bidding });
        return res.json(Bidding);
        
      })
      .catch((err) => {
        console.log({ status: "Error", err });
        return res.json({ status: "Error", err });
      });
  };

  