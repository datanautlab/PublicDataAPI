/*
  Warnings:

  - You are about to drop the `CreationUnit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DailyComposition` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ETF` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EtfDailyInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Issuer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `RedemptionUnit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Security` table. If the table is not empty, all the data it contains will be lost.

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
ALTER TABLE "ETF" DROP CONSTRAINT "ETF_issuerId_fkey";

-- DropForeignKey
ALTER TABLE "EtfDailyInfo" DROP CONSTRAINT "EtfDailyInfo_etfId_fkey";

-- DropForeignKey
ALTER TABLE "RedemptionUnit" DROP CONSTRAINT "RedemptionUnit_etfId_fkey";

-- DropForeignKey
ALTER TABLE "RedemptionUnit" DROP CONSTRAINT "RedemptionUnit_securityId_fkey";

-- DropTable
DROP TABLE "CreationUnit";

-- DropTable
DROP TABLE "DailyComposition";

-- DropTable
DROP TABLE "ETF";

-- DropTable
DROP TABLE "EtfDailyInfo";

-- DropTable
DROP TABLE "Issuer";

-- DropTable
DROP TABLE "RedemptionUnit";

-- DropTable
DROP TABLE "Security";

-- CreateTable
CREATE TABLE "issuer" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "issuer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "etf" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isin" TEXT NOT NULL,
    "issuer_id" TEXT NOT NULL,
    "benchmark" TEXT NOT NULL,
    "asset_class" TEXT NOT NULL,
    "theme" TEXT NOT NULL,
    "inception_date" TIMESTAMP(3) NOT NULL,
    "investment_strategy" TEXT NOT NULL,
    "risk_level" TEXT NOT NULL,
    "listing_exchange" TEXT NOT NULL,
    "dividend_policy" TEXT NOT NULL,
    "replication_method" TEXT NOT NULL,
    "replication_model" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "etf_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "etf_daily_info" (
    "etf_id" TEXT NOT NULL,
    "info_date" TIMESTAMP(3) NOT NULL,
    "aum" DECIMAL(65,30) NOT NULL,
    "share_outstanding" DECIMAL(65,30) NOT NULL,
    "nav" DECIMAL(65,30) NOT NULL,
    "expense_ratio" DECIMAL(65,30) NOT NULL,
    "tracking_error" DECIMAL(65,30) NOT NULL,
    "creation_unit_size" INTEGER NOT NULL,
    "redemption_unit_size" INTEGER NOT NULL,
    "estimated_cash" DECIMAL(65,30) NOT NULL,
    "derived_cash" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "etf_daily_info_pkey" PRIMARY KEY ("etf_id","info_date")
);

-- CreateTable
CREATE TABLE "security" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isin" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "sector" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "security_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "creation_unit" (
    "etf_id" TEXT NOT NULL,
    "info_date" TIMESTAMP(3) NOT NULL,
    "security_id" TEXT NOT NULL,
    "num_shares" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "creation_unit_pkey" PRIMARY KEY ("etf_id","info_date","security_id")
);

-- CreateTable
CREATE TABLE "redemption_unit" (
    "etf_id" TEXT NOT NULL,
    "info_date" TIMESTAMP(3) NOT NULL,
    "security_id" TEXT NOT NULL,
    "num_shares" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "redemption_unit_pkey" PRIMARY KEY ("etf_id","info_date","security_id")
);

-- CreateTable
CREATE TABLE "daily_composition" (
    "etf_id" TEXT NOT NULL,
    "info_date" TIMESTAMP(3) NOT NULL,
    "security_id" TEXT NOT NULL,
    "num_shares" DECIMAL(65,30) NOT NULL,
    "change_num_shares" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "daily_composition_pkey" PRIMARY KEY ("etf_id","info_date","security_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "etf_isin_key" ON "etf"("isin");

-- CreateIndex
CREATE INDEX "etf_isin_idx" ON "etf"("isin");

-- CreateIndex
CREATE UNIQUE INDEX "security_isin_key" ON "security"("isin");

-- CreateIndex
CREATE INDEX "security_isin_idx" ON "security"("isin");

-- AddForeignKey
ALTER TABLE "etf" ADD CONSTRAINT "etf_issuer_id_fkey" FOREIGN KEY ("issuer_id") REFERENCES "issuer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "etf_daily_info" ADD CONSTRAINT "etf_daily_info_etf_id_fkey" FOREIGN KEY ("etf_id") REFERENCES "etf"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creation_unit" ADD CONSTRAINT "creation_unit_etf_id_fkey" FOREIGN KEY ("etf_id") REFERENCES "etf"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creation_unit" ADD CONSTRAINT "creation_unit_security_id_fkey" FOREIGN KEY ("security_id") REFERENCES "security"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "redemption_unit" ADD CONSTRAINT "redemption_unit_etf_id_fkey" FOREIGN KEY ("etf_id") REFERENCES "etf"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "redemption_unit" ADD CONSTRAINT "redemption_unit_security_id_fkey" FOREIGN KEY ("security_id") REFERENCES "security"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_composition" ADD CONSTRAINT "daily_composition_etf_id_fkey" FOREIGN KEY ("etf_id") REFERENCES "etf"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_composition" ADD CONSTRAINT "daily_composition_security_id_fkey" FOREIGN KEY ("security_id") REFERENCES "security"("id") ON DELETE CASCADE ON UPDATE CASCADE;
