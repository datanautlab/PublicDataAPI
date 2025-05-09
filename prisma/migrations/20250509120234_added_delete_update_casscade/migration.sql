/*
  Warnings:

  - A unique constraint covering the columns `[isin]` on the table `ETF` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[isin]` on the table `Security` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "CreationUnit" DROP CONSTRAINT "CreationUnit_etfId_fkey";

-- DropForeignKey
ALTER TABLE "CreationUnit" DROP CONSTRAINT "CreationUnit_securityId_fkey";

-- DropForeignKey
ALTER TABLE "DailyComposition" DROP CONSTRAINT "DailyComposition_etfId_fkey";

-- DropForeignKey
ALTER TABLE "DailyComposition" DROP CONSTRAINT "DailyComposition_securityId_fkey";

-- DropForeignKey
ALTER TABLE "EtfDailyInfo" DROP CONSTRAINT "EtfDailyInfo_etfId_fkey";

-- DropForeignKey
ALTER TABLE "RedemptionUnit" DROP CONSTRAINT "RedemptionUnit_etfId_fkey";

-- DropForeignKey
ALTER TABLE "RedemptionUnit" DROP CONSTRAINT "RedemptionUnit_securityId_fkey";

-- CreateIndex
CREATE UNIQUE INDEX "ETF_isin_key" ON "ETF"("isin");

-- CreateIndex
CREATE UNIQUE INDEX "Security_isin_key" ON "Security"("isin");

-- AddForeignKey
ALTER TABLE "EtfDailyInfo" ADD CONSTRAINT "EtfDailyInfo_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreationUnit" ADD CONSTRAINT "CreationUnit_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreationUnit" ADD CONSTRAINT "CreationUnit_securityId_fkey" FOREIGN KEY ("securityId") REFERENCES "Security"("security_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RedemptionUnit" ADD CONSTRAINT "RedemptionUnit_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RedemptionUnit" ADD CONSTRAINT "RedemptionUnit_securityId_fkey" FOREIGN KEY ("securityId") REFERENCES "Security"("security_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DailyComposition" ADD CONSTRAINT "DailyComposition_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DailyComposition" ADD CONSTRAINT "DailyComposition_securityId_fkey" FOREIGN KEY ("securityId") REFERENCES "Security"("security_id") ON DELETE CASCADE ON UPDATE CASCADE;
