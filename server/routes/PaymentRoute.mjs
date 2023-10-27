import { Router } from "express";

import {
  newPayment,
  getAllPaymentByUser,
  updatePayment,
  getRevenue,
} from "../controllers/PaymentController.mjs";

const route = Router();

route.post("/new-payment", newPayment);
route.get("/get-all-payment-user/:id", getAllPaymentByUser);
route.put("/update-payment", updatePayment);
route.get("/payments", getRevenue);

export default route;
