import express from "express";
import dotenv from "dotenv";
import connectDB from "./config/db.js";
import bodyParser from "body-parser";
import swaggerUi from "swagger-ui-express";
import { swaggerSpec } from "./config/swagger.js";

import parentRoutes from "./routes/parent.js";
import childRoutes from "./routes/child.js";

dotenv.config();
const PORT = process.env.PORT || 5000

connectDB();
const app = express();
app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use("/parent", parentRoutes);
app.use("/child", childRoutes);

app.get("/", (req, res) => res.send("Server is ready!!"));

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
})