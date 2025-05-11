import prisma from "../config/db";
import { NOT_FOUND } from "../constants/http";
import appAssert from "../utils/appAssert";
import AppErrorCode from "../constants/appErrorCode";
import logger from "../config/logger";
import { etfSelect } from "../constants/etf.prisma";

export const getETFData = async (isin: string) => {
  const etfData = await prisma.etf.findUnique({
    where: { isin },
    select: etfSelect,
  });

  logger.info(`ETF data fetched for ${isin} ${etfData?.name}`);

  appAssert(etfData, NOT_FOUND, "ETF not found", AppErrorCode.InvalidISIN);

  return {
    ...etfData,
    issuer: etfData.issuer.name,
  };
};

export const getETFDailyInfo = async (
  isin: string,
  from?: string,
  to?: string
) => {
  console.log(isin, from, to);
};

export const getETFDailyComposition = async (
  isin: string,
  from?: string,
  to?: string
) => {
  console.log(isin, from, to);
};

export const getETFCreationUnit = async (
  isin: string,
  from?: string,
  to?: string
) => {
  console.log(isin, from, to);
};

export const getETFRedemptionUnit = async (
  isin: string,
  from?: string,
  to?: string
) => {
  console.log(isin, from, to);
};
