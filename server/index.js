import express from "express";
import dotenv from "dotenv";

import userRoutes from './routes/user.js';
import { errorHandler, notFound } from "./middleware/error.js";
import connectDB from "./config/db.js";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";

dotenv.config();
const PORT = process.env.PORT || 5000

connectDB();
const app = express();
app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/api/users', userRoutes);
app.get("/", (req, res) => res.send("Server is ready!!"));
app.use(notFound);
app.use(errorHandler);

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
})