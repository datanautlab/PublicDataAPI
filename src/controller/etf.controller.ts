import { BAD_REQUEST, OK } from "../constants/http";
import {
  getETFCreationUnit,
  getETFDailyComposition,
  getETFDailyInfo,
  getETFData,
  getETFRedemptionUnit,
} from "../services/etf.service";
import catchError from "../utils/catchError";
import validateETFParams from "../utils/validateETFParams";

export const getETFDataHandler = catchError(async (req, res) => {
  const { isin } = req.params;
  const errors = validateETFParams(isin);
  if (errors.length > 0) {
    return res.status(BAD_REQUEST).json({ message: errors });
  }

  const etfData = await getETFData(isin);

  res.status(OK).json(etfData);
});

export const getETFDailyInfoHandler = catchError(async (req, res) => {
  const { isin } = req.params;
  const { from, to } = req.query;

  const errors = validateETFParams(isin, from as string, to as string);
  if (errors.length > 0) {
    return res.status(BAD_REQUEST).json({ message: errors });
  }

  const etfDailyInfo = await getETFDailyInfo(
    isin,
    from as string,
    to as string
  );

  res.status(OK).json(etfDailyInfo);
});

export const getETFDailyCompositionHandler = catchError(async (req, res) => {
  const { isin } = req.params;
  const { from, to } = req.query;

  const errors = validateETFParams(isin, from as string, to as string);
  if (errors.length > 0) {
        return res.status(BAD_REQUEST).json({ message: errors });
  }

  const etfDailyComposition = await getETFDailyComposition(
    isin,
    from as string,
    to as string
  );

  res.status(OK).json(etfDailyComposition);
});

export const getETFCreationUnitHandler = catchError(async (req, res) => {
  const { isin } = req.params;
  const { from, to } = req.query;

  const errors = validateETFParams(isin, from as string, to as string);
  if (errors.length > 0) {
    return res.status(BAD_REQUEST).json({ message: errors });
  }

  const etfCreationUnit = await getETFCreationUnit(
    isin,
    from as string,
    to as string
  );

  res.status(OK).json(etfCreationUnit);
});

export const getETFRedemptionUnitHandler = catchError(async (req, res) => {
  const { isin } = req.params;
  const { from, to } = req.query;

  const errors = validateETFParams(isin, from as string, to as string);
  if (errors.length > 0) {
    return res.status(BAD_REQUEST).json({ message: errors });
  }

  const etfRedemptionUnit = await getETFRedemptionUnit(
    isin,
    from as string,
    to as string
  );

  res.status(OK).json(etfRedemptionUnit);
});
