import {
    createUser,
    loginUser,
    changePassword,
    updateUser,
    deleteUser,
    getFarmerContact,
    getEmailFromUserName
  } from "../controllers/UserController.mjs";
  import Router from "express";
  
  const UserRouter = Router();
  UserRouter.post("/add-user", createUser);
  UserRouter.post("/login", loginUser);
  UserRouter.post("/change-pwd", changePassword);
  UserRouter.put("/update-user", updateUser);
  UserRouter.delete("/delete-user", deleteUser);
  UserRouter.get("/get-contact/:farmerName", getFarmerContact);
  UserRouter.get("/get-email/:userName", getEmailFromUserName);
  
  export default UserRouter;
