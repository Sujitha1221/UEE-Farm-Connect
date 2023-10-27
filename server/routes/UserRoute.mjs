import {
  createUser,
  loginUser,
  changePassword,
  updateUser,
  deleteUser,
} from "../controllers/UserController.mjs";
import Router from "express";

const UserRouter = Router();
UserRouter.post("/add-user", createUser);
UserRouter.post("/login", loginUser);
UserRouter.post("/change-pwd", changePassword);
UserRouter.put("/update-user", updateUser);
UserRouter.delete("/delete-user/:email", deleteUser);

export default UserRouter;
