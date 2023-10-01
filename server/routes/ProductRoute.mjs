import { ProductController } from "../controllers/Productcontroller.mjs";
import express from "express";
const ProductRouter = express.Router();

ProductRouter.post('/add',ProductController.createProduct);
ProductRouter.get('/',ProductController.getAllProducts);
ProductRouter.delete('/delete/:id',ProductController.deleteProductById);
ProductRouter.get('/get/:farmerName',ProductController.getProductbyFarmerName);

export default ProductRouter;