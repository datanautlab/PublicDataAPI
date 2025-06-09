import prisma from "../config/db";
import { NOT_FOUND } from "../constants/http";
import appAssert from "../utils/appAssert";
import AppErrorCode from "../constants/appErrorCode";
import logger from "../config/logger";
import {
  etfDailyCompositionSelect,
  etfDailyInfoSelect,
  etfSelect,
} from "../constants/etf.prisma";
import {
  getETFByIsin,
  buildDateFilter,
  mapCompositionData,
  logETFOperation,
} from "../utils/etfHelpers";

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
  const etfData = await getETFByIsin(isin);
  const infoDateFilter = buildDateFilter(from, to);

  const dailyInfo = await prisma.etf_daily_info.findMany({
    where: {
      etf_id: etfData.id,
      info_date: infoDateFilter,
    },
    select: etfDailyInfoSelect,
    orderBy: {
      info_date: "asc",
    },
  });

  logETFOperation("daily info", etfData);

  return {
    isin: etfData.isin,
    name: etfData.name,
    data: dailyInfo,
  };
};

export const getETFDailyComposition = async (
  isin: string,
  from?: string,
  to?: string
) => {
  const etfData = await getETFByIsin(isin);
  const infoDateFilter = buildDateFilter(from, to);

  const dailyComposition = await prisma.daily_composition.findMany({
    where: {
      etf_id: etfData.id,
      info_date: infoDateFilter,
    },
    select: etfDailyCompositionSelect,
    orderBy: {
      info_date: "asc",
    },
  });

  logETFOperation("daily composition", etfData);

  return {
    isin: etfData.isin,
    name: etfData.name,
    data: mapCompositionData(dailyComposition),
  };
};

export const getETFCreationUnit = async (
  isin: string,
  from?: string,
  to?: string
) => {
  const etfData = await getETFByIsin(isin);
  const infoDateFilter = buildDateFilter(from, to);

  const creationUnit = await prisma.creation_unit.findMany({
    where: {
      etf_id: etfData.id,
      info_date: infoDateFilter,
    },
    select: etfDailyCompositionSelect,
    orderBy: {
      info_date: "asc",
    },
  });

  logETFOperation("creation unit", etfData);

  return {
    isin: etfData.isin,
    name: etfData.name,
    data: mapCompositionData(creationUnit),
  };
};

export const getETFRedemptionUnit = async (
  isin: string,
  from?: string,
  to?: string
) => {
  const etfData = await getETFByIsin(isin);
  const infoDateFilter = buildDateFilter(from, to);

  const redemptionUnit = await prisma.redemption_unit.findMany({
    where: {
      etf_id: etfData.id,
      info_date: infoDateFilter,
    },
    select: etfDailyCompositionSelect,
    orderBy: {
      info_date: "asc",
    },
  });

  logETFOperation("redemption unit", etfData);

  return {
    isin: etfData.isin,
    name: etfData.name,
    data: mapCompositionData(redemptionUnit),
  };
};
