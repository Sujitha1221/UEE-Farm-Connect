import logger from "../utils/logger.mjs";
import Product from "../models/Product.mjs";

export const ProductController = {
    createProduct: async (req, res) => {
        try {
          const { productName, farmerName, quantity, amountPerkg, expiryDate, photo } = req.body;
      
          // Check for missing required fields
          if (!productName) {
            return res.status(400).json({ error: "Product name is required" });
          }
          if (!farmerName) {
            return res.status(400).json({ error: "Farmer name is required" });
          }
          if (!quantity) {
            return res.status(400).json({ error: "Quantity is required" });
          }
          if (!amountPerkg) {
            return res.status(400).json({ error: "Amount per kg is required" });
          }
          if (!expiryDate) {
            return res.status(400).json({ error: "Expiry Date is required" });
          }
      
          const product = new Product({ productName, farmerName, quantity, amountPerkg, expiryDate, photo });
      
          await product.save();
      
          res.status(201).json(product); // Use 201 status for successful creation
          logger.info("Product created successfully");
        } catch (error) {
          console.error(error);
          res.status(500).json({ error: "Error creating product" });
          logger.error("Product Creation Failed");
        }
      },
      

    getAllProducts: async (req, res) => {
        try {
          const products = await Product.find();
          res.status(200).json(products);
          logger.info(`Product details fetched`);
        } catch (error) {
          res.status(500).json({ message: error });
          logger.error(`Error getting all products ${error.message}`);
        }
      },

      getProductbyFarmerName: async (req, res) => {
        try {
          const farmerName = req.params.farmerName;
          // Find all products associated with the found farmer
          const products = await Product.find({ farmerName: farmerName });
      
          if (products.length === 0) {
            return res.status(404).json({ status: "No products found for this farmer" });
          }
      
          res.status(200).json({ status: "Products found", products });
        } catch (err) {
          console.error(err.message);
          res.status(500).json({ status: "Error with fetching products", error: err.message });
        }
      },

      deleteProductById: async (req, res) => {
        try {
          await Product.findByIdAndDelete(req.params.id) //delete
            .then(() => {
              res.status(200).json("success"); //send success message to the frontend
              logger.info(`Product deleted successfully`);
            });
        } catch (error) {
          logger.error(`Product delete failed`);
          res.status(400).send("failed");
        }
      },

      getProductbyId: async (req, res) => {
        let id = req.params.id; //get the id from the request(parameter)
      
        await Product.findOne({ _id: `${id}` }) //compare the id with the got id and return the details
          .then((product) => {
            res.status(200).send({ status: "Product Details fetched", product }); //send response as a json object and a status
          })
          .catch((err) => {
            console.log(err.message);
      
            res.status(500).send({ status: "Error with fetching Product details", error: err.message }); //send error message
          });
      },
      
  }