-- CreateTable
CREATE TABLE "usuarios" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL DEFAULT '',
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "rol" TEXT NOT NULL DEFAULT 'vendedor',
    "activo" INTEGER NOT NULL DEFAULT 1,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categorias" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "activo" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "categorias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fabricantes" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "activo" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "fabricantes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "productos" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,
    "stock" INTEGER NOT NULL,
    "activo" INTEGER NOT NULL DEFAULT 1,
    "id_categoria" INTEGER NOT NULL,
    "id_fabricante" INTEGER NOT NULL,

    CONSTRAINT "productos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pedidos" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado" TEXT NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "pedidos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalles_pedidos" (
    "id" SERIAL NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DOUBLE PRECISION NOT NULL,
    "id_pedido" INTEGER NOT NULL,
    "id_producto" INTEGER NOT NULL,

    CONSTRAINT "detalles_pedidos_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "categorias_nombre_key" ON "categorias"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "fabricantes_nombre_key" ON "fabricantes"("nombre");

-- AddForeignKey
ALTER TABLE "productos" ADD CONSTRAINT "productos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "categorias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "productos" ADD CONSTRAINT "productos_id_fabricante_fkey" FOREIGN KEY ("id_fabricante") REFERENCES "fabricantes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedidos" ADD CONSTRAINT "pedidos_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalles_pedidos" ADD CONSTRAINT "detalles_pedidos_id_pedido_fkey" FOREIGN KEY ("id_pedido") REFERENCES "pedidos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalles_pedidos" ADD CONSTRAINT "detalles_pedidos_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "productos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
