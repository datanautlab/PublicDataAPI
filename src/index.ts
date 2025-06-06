import "dotenv/config";
import express, { urlencoded, json } from "express";
import cors from "cors";
import client from "prom-client";
import errorHandler from "./middlewares/errorHandler";
import { connectToDatabase } from "./config/db";
import etfRouter from "./routes/etf.route";
import { PORT } from "./constants/env";
import { OK } from "./constants/http";
import request from "./middlewares/request";
import logger from "./config/logger";

const app = express();

app.use(urlencoded({ extended: true }));
app.use(json());
app.use(cors());
app.use(request);

app.get("/", (req, res) => {
  res.status(OK).json({ msg: "Server is up and running" });
});

app.use("/v1/etf", etfRouter);

app.get("/metrics", async (req, res) => {
  const metrics = await client.register.metrics();
  res.set("Content-Type", client.register.contentType);
  res.send(metrics);
});

// 404 handler
app.use((req, res) => {
  logger.error(`404 - Not Found: ${req.method} ${req.originalUrl}`);
  res.status(404).send("Not found");
});

app.use(errorHandler);

app.listen(PORT, async () => {
  await connectToDatabase();
  const collectDefaultMetrics = client.collectDefaultMetrics;
  collectDefaultMetrics();
  logger.info(`Server is listening at port ${PORT}`);
});
