import { createBankAccountDetails } from "../controllers/BankDetailsController.mjs";
import Router from "express";

const BankDetailsRouter = Router();
BankDetailsRouter.post("/bank-details", createBankAccountDetails);

export default BankDetailsRouter;
