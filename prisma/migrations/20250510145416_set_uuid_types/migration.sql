/*
  Warnings:

  - The primary key for the `etf` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `issuer_id` on the `etf` table. All the data in the column will be lost.
  - The primary key for the `security` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `issuer` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `issuer` to the `etf` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `etf` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `security` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "etf" DROP CONSTRAINT "etf_issuer_id_fkey";

-- AlterTable
ALTER TABLE "etf" DROP CONSTRAINT "etf_pkey",
DROP COLUMN "issuer_id",
ADD COLUMN     "issuer" TEXT NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "etf_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "security" DROP CONSTRAINT "security_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "security_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "issuer";
