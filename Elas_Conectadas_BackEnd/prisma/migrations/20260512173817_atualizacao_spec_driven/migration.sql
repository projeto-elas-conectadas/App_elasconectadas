/*
  Warnings:

  - The primary key for the `Ads` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `cover` on the `Ads` table. The data in that column could be lost. The data in that column will be cast from `LongBlob` to `VarChar(191)`.
  - The primary key for the `AdvertisingOnUsers` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `OTP` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Post` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `cover` on the `Post` table. The data in that column could be lost. The data in that column will be cast from `LongBlob` to `VarChar(191)`.
  - The primary key for the `PostOnAdmins` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `location` on the `users` table. All the data in the column will be lost.
  - You are about to alter the column `pfp` on the `users` table. The data in that column could be lost. The data in that column will be cast from `LongBlob` to `VarChar(191)`.

*/
-- DropForeignKey
ALTER TABLE `AdvertisingOnUsers` DROP FOREIGN KEY `AdvertisingOnUsers_advertisingId_fkey`;

-- DropForeignKey
ALTER TABLE `AdvertisingOnUsers` DROP FOREIGN KEY `AdvertisingOnUsers_userId_fkey`;

-- DropForeignKey
ALTER TABLE `OTP` DROP FOREIGN KEY `OTP_userId_fkey`;

-- DropForeignKey
ALTER TABLE `PostOnAdmins` DROP FOREIGN KEY `PostOnAdmins_adminId_fkey`;

-- DropForeignKey
ALTER TABLE `PostOnAdmins` DROP FOREIGN KEY `PostOnAdmins_postId_fkey`;

-- DropIndex
DROP INDEX `AdvertisingOnUsers_advertisingId_fkey` ON `AdvertisingOnUsers`;

-- DropIndex
DROP INDEX `OTP_userId_fkey` ON `OTP`;

-- DropIndex
DROP INDEX `PostOnAdmins_postId_fkey` ON `PostOnAdmins`;

-- AlterTable
ALTER TABLE `Ads` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `cover` VARCHAR(191) NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `AdvertisingOnUsers` DROP PRIMARY KEY,
    MODIFY `userId` VARCHAR(191) NOT NULL,
    MODIFY `advertisingId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`userId`, `advertisingId`);

-- AlterTable
ALTER TABLE `OTP` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `userId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Post` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `cover` VARCHAR(191) NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `PostOnAdmins` DROP PRIMARY KEY,
    MODIFY `adminId` VARCHAR(191) NOT NULL,
    MODIFY `postId` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`adminId`, `postId`);

-- AlterTable
ALTER TABLE `users` DROP PRIMARY KEY,
    DROP COLUMN `location`,
    ADD COLUMN `bairro` VARCHAR(191) NULL,
    ADD COLUMN `cidade` VARCHAR(191) NULL,
    ADD COLUMN `estado` VARCHAR(191) NULL,
    ADD COLUMN `numero` VARCHAR(191) NULL,
    ADD COLUMN `rua` VARCHAR(191) NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `pfp` VARCHAR(191) NULL,
    ADD PRIMARY KEY (`id`);

-- CreateTable
CREATE TABLE `Produto` (
    `id` VARCHAR(191) NOT NULL,
    `nome` VARCHAR(191) NOT NULL,
    `descricao` VARCHAR(191) NOT NULL,
    `preco` VARCHAR(191) NOT NULL,
    `categoria` VARCHAR(191) NOT NULL,
    `regiaoAtendimento` VARCHAR(191) NOT NULL,
    `imagemPrincipal` TEXT NOT NULL,
    `imagensAdicionais` JSON NULL,
    `criado_em` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Produto` ADD CONSTRAINT `Produto_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdvertisingOnUsers` ADD CONSTRAINT `AdvertisingOnUsers_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AdvertisingOnUsers` ADD CONSTRAINT `AdvertisingOnUsers_advertisingId_fkey` FOREIGN KEY (`advertisingId`) REFERENCES `Ads`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostOnAdmins` ADD CONSTRAINT `PostOnAdmins_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PostOnAdmins` ADD CONSTRAINT `PostOnAdmins_postId_fkey` FOREIGN KEY (`postId`) REFERENCES `Post`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OTP` ADD CONSTRAINT `OTP_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
