import express from "express";
import bodyParser from "body-parser";
import dotenv from 'dotenv';
import cors from "cors";
import databaseConnection from "./config/database.mjs";
import logger from "./utils/logger.mjs";
import ProductRouter from "./routes/ProductRoute.mjs";


const app = express();
const PORT = process.env.PORT || "8080";

dotenv.config();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true
}))



app.use(express.json({ limit: "20000mb"}));
app.use(express.urlencoded({ limit: "20000mb" }));


app.listen(PORT, () => {
    logger.info(`Server is up and running on port ${PORT}`)
    databaseConnection();
})

//routes
app.use('/product', ProductRouter);
