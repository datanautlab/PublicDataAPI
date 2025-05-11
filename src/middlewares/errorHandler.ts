/* eslint-disable @typescript-eslint/no-unused-vars */
import { ErrorRequestHandler, Response } from "express";
import { INTERNAL_SERVER_ERROR } from "../constants/http";
import logger from "../config/logger";
import { AppError } from "../utils/AppError";

// App error handler
const handleAppError = (err: AppError, res: Response) => {
  return res.status(err.statusCode).json({
    message: err.message,
    errorCode: err.errorCode,
  });
};

// Error handler middleware
const errorHandler: ErrorRequestHandler = (err, req, res, next) => {
  logger.error(`{path: ${req.path}, message: ${err.message}}`);

  if (err instanceof AppError) {
    handleAppError(err, res);
    return;
  }

  res.status(INTERNAL_SERVER_ERROR).json({ message: err.message });
  return;
};

export default errorHandler;
