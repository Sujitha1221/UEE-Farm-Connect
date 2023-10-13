import { Router } from "express";

import { 
    newBidding,

 } from "../controllers/BiddingController.mjs";

const route = Router();

route.post("/new-bidding", newBidding);

export default route;
