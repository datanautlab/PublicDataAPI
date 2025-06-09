import prisma from "../config/db";
import { NOT_FOUND } from "../constants/http";
import appAssert from "./appAssert";
import AppErrorCode from "../constants/appErrorCode";
import logger from "../config/logger";
import { Decimal } from "@prisma/client/runtime/library";

// Helper function to get ETF by ISIN and assert it exists
export const getETFByIsin = async (isin: string) => {
  const etfData = await prisma.etf.findUnique({
    where: { isin },
    select: { id: true, name: true, isin: true },
  });
  appAssert(etfData, NOT_FOUND, "ETF not found", AppErrorCode.InvalidISIN);
  return etfData;
};

// Helper function to build date filter
export const buildDateFilter = (from?: string, to?: string) => {
  const infoDateFilter: { gte?: Date; lte?: Date } = {};

  if (from && to) {
    infoDateFilter.gte = new Date(from);
    const toDate = new Date(to);
    toDate.setUTCHours(23, 59, 59, 999);
    infoDateFilter.lte = toDate;
  } else {
    const toDate = new Date();
    infoDateFilter.lte = toDate;
    infoDateFilter.gte = new Date(toDate.getTime() - 24 * 60 * 60 * 1000);
  }

  return infoDateFilter;
};

// Interface for composition-like data items
export interface CompositionItem {
  info_date: Date;
  num_shares: Decimal;
  security: {
    name: string;
    type: string;
    sector: string;
    isin: string;
  };
}

// Helper function to map composition-like data
export const mapCompositionData = (items: CompositionItem[]) => {
  return items.map((item) => ({
    info_date: item.info_date,
    security_name: item.security.name,
    security_type: item.security.type,
    sector: item.security.sector,
    security_isin: item.security.isin,
    num_shares: item.num_shares,
  }));
};

// Helper function for logging
export const logETFOperation = (
  operation: string,
  etfData: { name: string; isin: string; id: string }
) => {
  logger.info(
    `ETF ${operation} fetched for ${etfData.name} ${etfData.isin} ${etfData.id}`
  );
};
