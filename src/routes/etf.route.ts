import { Router } from "express";
import { OK } from "../constants/http";
import {
  getETFCreationUnitHandler,
  getETFDailyCompositionHandler,
  getETFDailyInfoHandler,
  getETFDataHandler,
  getETFRedemptionUnitHandler,
} from "../controller/etf.controller";

const etfRouter = Router();

etfRouter.get("/", (req, res) => {
  console.log("ETF route hit");
  res.status(OK).json({ msg: "ETF route" });
});

// Debug route
etfRouter.get("/debug", (req, res) => {
  console.log("ETF debug route hit");
  res.status(OK).json({ msg: "ETF debug route works" });
});

// More specific routes first
etfRouter.get("/daily_info/:isin", getETFDailyInfoHandler);

etfRouter.get("/daily_composition/:isin", getETFDailyCompositionHandler);

etfRouter.get("/creation_unit/:isin", getETFCreationUnitHandler);

etfRouter.get("/redemption_unit/:isin", getETFRedemptionUnitHandler);

// Generic route last
etfRouter.get("/:isin", getETFDataHandler);

export default etfRouter;
