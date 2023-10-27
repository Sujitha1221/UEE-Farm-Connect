import express from "express";
import bodyParser from "body-parser";
import dotenv from "dotenv";
import cors from "cors";
import databaseConnection from "./config/database.mjs";
import logger from "./utils/logger.mjs";
import PaymentRoute from "./routes/PaymentRoute.mjs";
import BiddingRoute from "./routes/BiddingRoute.mjs";
import cron from "node-cron";
import Bidding from "./models/Bidding.mjs";
import axios from "axios";
import ProductRouter from "./routes/ProductRoute.mjs";
import UserRouter from "./routes/UserRoute.mjs";
import BankDetailsRouter from "./routes/BankDetails.mjs";

const app = express();
const PORT = process.env.PORT || "8080";

dotenv.config();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


import('./twilio.mjs');



app.use(express.json({ limit: "20000mb"}));
app.use(express.urlencoded({ limit: "20000mb" }));



function myScheduledTask() {
  const currentTime = new Date();
  console.log('Task executed in Sri Lankan time' + currentTime);

  axios.get('http://localhost:8080/bidding/expire-bidding')
  .then((bid) => {
    return res.json(bid);
  })
  .catch((err) => {
    console.error('Error', error);
    return res.json({ status: "Error", err });
  });
  
}

cron.schedule('55 23 * * *', myScheduledTask, {
  scheduled: true,
  timezone: 'Asia/Colombo'
});

app.listen(PORT, () => {
  logger.info(`Server is up and running on port ${PORT}`);
  databaseConnection();
});
// app.use((req, res, next) => {
//     // Set COOP and COEP headers to loosen security restrictions (for development purposes).
//     res.setHeader('Cross-Origin-Opener-Policy', 'same-origin');
//     res.setHeader('Cross-Origin-Embedder-Policy', 'require-corp');
//     next();
//   });

//routes
app.use('/product', ProductRouter);
app.use("/user", UserRouter);
app.use("/payment", PaymentRoute);
app.use("/bidding", BiddingRoute);
app.use("/bank", BankDetailsRouter);