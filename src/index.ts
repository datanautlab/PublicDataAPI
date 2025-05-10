import "dotenv/config";
import express, { urlencoded, json } from "express";
import cors from "cors";
import errorHandler from "./middlewares/errorHandler";
import { connectToDatabase } from "./config/db";
import etfRouter from "./routes/etf.route";
import { PORT } from "./constants/env";
import { OK } from "./constants/http";

const app = express();

app.use(urlencoded({ extended: true }));
app.use(json());
app.use(cors());

// Debug middleware to log all requests
app.use((req, res, next) => {
  console.log(`${req.method} ${req.originalUrl}`);
  next();
});

app.get("/", (req, res) => {
  console.log("Root route hit!");
  res.status(OK).json({ msg: "Server is up and running" });
});

console.log("Registering ETF routes at /v1/etf");
app.use("/v1/etf", etfRouter);

// 404 handler
app.use((req, res) => {
  console.log(`404 - Not Found: ${req.method} ${req.originalUrl}`);
  res.status(404).send("Endpoint not found");
});

app.use(errorHandler);

app.listen(PORT, async () => {
  await connectToDatabase();
  console.log(`Server is listening at port ${PORT}`);
});
