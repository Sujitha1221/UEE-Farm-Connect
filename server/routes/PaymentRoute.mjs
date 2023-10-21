import { Router } from "express";

import {
  newPayment,
  getAllPaymentByUser,
  updatePayment,
} from "../controllers/PaymentController.mjs";

const route = Router();

route.post("/new-payment", newPayment);
route.get("/get-all-payment-user/:id", getAllPaymentByUser);
route.put("/update-payment", updatePayment);

export default route;
