import client from "prom-client";
import { Request, Response, NextFunction } from "express";

const requestCounter = new client.Counter({
  name: "request_count",
  help: "Total request count",
  labelNames: ["method", "route", "status_code"],
});

const requestCount = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  
  const startTime = Date.now();

  res.on("finish", () => {
    const endTime = Date.now();
    console.log(`Request ${req.method} ${req.originalUrl} took ${endTime - startTime}ms`);

    requestCounter.inc({
      method: req.method,
      route: req.path,
      status_code: res.statusCode,
    });
  });

  next();
};

export default requestCount;
