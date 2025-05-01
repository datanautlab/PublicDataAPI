-- CreateTable
CREATE TABLE "Issuer" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Issuer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ETF" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isin" TEXT NOT NULL,
    "issuerId" TEXT NOT NULL,
    "benchmark" TEXT NOT NULL,
    "assetClass" TEXT NOT NULL,
    "theme" TEXT NOT NULL,
    "inceptionDate" TIMESTAMP(3) NOT NULL,
    "investmentStrategy" TEXT NOT NULL,
    "riskLevel" TEXT NOT NULL,
    "listingExchange" TEXT NOT NULL,
    "dividendPolicy" TEXT NOT NULL,
    "replicationMethod" TEXT NOT NULL,
    "replicationModel" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ETF_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EtfDailyInfo" (
    "etfId" TEXT NOT NULL,
    "infoDate" TIMESTAMP(3) NOT NULL,
    "aum" DECIMAL(65,30) NOT NULL,
    "shareOutstanding" DECIMAL(65,30) NOT NULL,
    "nav" DECIMAL(65,30) NOT NULL,
    "expenseRatio" DECIMAL(65,30) NOT NULL,
    "trackingError" DECIMAL(65,30) NOT NULL,
    "creationUnitSize" INTEGER NOT NULL,
    "redemptionUnitSize" INTEGER NOT NULL,
    "estimatedCash" DECIMAL(65,30) NOT NULL,
    "derivedCash" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EtfDailyInfo_pkey" PRIMARY KEY ("etfId","infoDate")
);

-- CreateTable
CREATE TABLE "Security" (
    "security_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isin" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "sector" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Security_pkey" PRIMARY KEY ("security_id")
);

-- CreateTable
CREATE TABLE "CreationUnit" (
    "etfId" TEXT NOT NULL,
    "infoDate" TIMESTAMP(3) NOT NULL,
    "securityId" TEXT NOT NULL,
    "numShares" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CreationUnit_pkey" PRIMARY KEY ("etfId","infoDate","securityId")
);

-- CreateTable
CREATE TABLE "RedemptionUnit" (
    "etfId" TEXT NOT NULL,
    "infoDate" TIMESTAMP(3) NOT NULL,
    "securityId" TEXT NOT NULL,
    "numShares" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RedemptionUnit_pkey" PRIMARY KEY ("etfId","infoDate","securityId")
);

-- CreateTable
CREATE TABLE "DailyComposition" (
    "etfId" TEXT NOT NULL,
    "infoDate" TIMESTAMP(3) NOT NULL,
    "securityId" TEXT NOT NULL,
    "numShares" DECIMAL(65,30) NOT NULL,
    "changeNumShares" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DailyComposition_pkey" PRIMARY KEY ("etfId","infoDate","securityId")
);

-- CreateIndex
CREATE INDEX "ETF_isin_idx" ON "ETF"("isin");

-- CreateIndex
CREATE INDEX "Security_isin_idx" ON "Security"("isin");

-- AddForeignKey
ALTER TABLE "ETF" ADD CONSTRAINT "ETF_issuerId_fkey" FOREIGN KEY ("issuerId") REFERENCES "Issuer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EtfDailyInfo" ADD CONSTRAINT "EtfDailyInfo_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreationUnit" ADD CONSTRAINT "CreationUnit_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CreationUnit" ADD CONSTRAINT "CreationUnit_securityId_fkey" FOREIGN KEY ("securityId") REFERENCES "Security"("security_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RedemptionUnit" ADD CONSTRAINT "RedemptionUnit_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RedemptionUnit" ADD CONSTRAINT "RedemptionUnit_securityId_fkey" FOREIGN KEY ("securityId") REFERENCES "Security"("security_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DailyComposition" ADD CONSTRAINT "DailyComposition_etfId_fkey" FOREIGN KEY ("etfId") REFERENCES "ETF"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DailyComposition" ADD CONSTRAINT "DailyComposition_securityId_fkey" FOREIGN KEY ("securityId") REFERENCES "Security"("security_id") ON DELETE RESTRICT ON UPDATE CASCADE;
