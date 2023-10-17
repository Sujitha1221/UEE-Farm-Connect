import { Router } from "express";

import { 
    newBidding,
    getPendingByFarmerId,
    getPendingByUserId,
    getHistoryByFarmerId,
    getHistoryByUserId,
    rejectBidding,
    expireBidding,
    acceptBidding

 } from "../controllers/BiddingController.mjs";

const route = Router();

route.post("/new-bidding", newBidding);
route.put("/accept-bidding", acceptBidding);
route.get("/get-pending-farmer/:farmerUserName", getPendingByFarmerId);
route.get("/get-pending-user/:userName", getPendingByUserId);
route.get("/get-history-farmer/:farmerUserName", getHistoryByFarmerId);
route.get("/get-history-user/:userName", getHistoryByUserId);
route.get("/reject-bidding/:farmerUserName/:productName", rejectBidding);
route.get("/expire-bidding", expireBidding);

export default route;
