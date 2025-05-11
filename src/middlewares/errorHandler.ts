/* eslint-disable @typescript-eslint/no-unused-vars */
import { ErrorRequestHandler } from "express";
import { INTERNAL_SERVER_ERROR } from "../constants/http";
import logger from "../config/logger";
// Error handler middleware
const errorHandler: ErrorRequestHandler = (err, req, res, next) => {
  logger.error(`PATH: ${req.path}`, { error: err });

  res.status(INTERNAL_SERVER_ERROR).json({ message: "Something went wrong" });
  return;
};

export default errorHandler;
