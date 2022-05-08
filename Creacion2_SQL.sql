create database Mayorista_ropa;

use Mayorista_ropa;

Create Table  `Direccion`(
`ID_direccion` varchar(10),
`Numero` varchar(3),
`Calle` varchar(100),
`Poblacion` varchar(100),
`Telefono` varchar(10),
`Email` varchar(100),
 PRIMARY KEY (`ID_direccion`)
);

CREATE TABLE `descuento` (
  `ID_categoria` varchar(4),
  `Descripcion` varchar(200),
  `Descuento` float, CHECK ( `Descuento` <0.2),
  PRIMARY KEY (`ID_categoria`)
);
CREATE TABLE Tienda (
  ID_Tienda varchar(4),
  Nombre_tienda varchar(10),
  limite_Credito int , CHECK (limite_Credito < 30000),
 ID_categoria1 varchar(4),
  PRIMARY KEY (ID_Tienda),
  FOREIGN KEY (ID_categoria1) REFERENCES descuento(ID_categoria)
);


  

CREATE TABLE `Articulo` (
  `ID_Articulo` varchar(4),
  `Descripcion` varchar(100),
  `Precio` int(10),
  PRIMARY KEY (`ID_Articulo`)
);


CREATE TABLE `Proveedor` (
  `ID_Proveedor` varchar(4),
  `nombre_proveedor` varchar(100),
  `direccion_proveedor` varchar(10),
  PRIMARY KEY (`ID_Proveedor`),
FOREIGN KEY (`direccion_proveedor`) REFERENCES `Direccion`(`ID_direccion`)
);

CREATE TABLE `pedidos` (
  `ID_Pedido` varchar(4),
  `ID_Tienda1` varchar(4),
 `ID_Proveedor1` varchar(4),
  `Fecha_pedido` DateTime,
  PRIMARY KEY (`ID_Pedido`),
  FOREIGN KEY (`ID_Tienda1`) REFERENCES `Tienda`(`ID_Tienda`),
  FOREIGN KEY (`ID_Proveedor1`) REFERENCES `Proveedor`(`ID_Proveedor`)
);

CREATE TABLE `linea_pedidos` (
  `ID_linea_pedido` varchar(4),
   `ID_Pedido1` varchar(4),
  `ID_Articulo1` varchar(4),
 `Cantidad` int,
  PRIMARY KEY (`ID_linea_pedido`),
  FOREIGN KEY (`ID_Articulo1`) REFERENCES `Articulo`(`ID_Articulo`),
  FOREIGN KEY (`ID_Pedido1`) REFERENCES `pedidos`(`ID_Pedido`)
  );
  
  CREATE TABLE `Direccion_lineas` (
   `ID_direccion2` varchar(100),
   `ID_Tienda2` varchar(4),
  `ID_Pedido3` varchar(4),
  PRIMARY KEY (`ID_Tienda2`,`ID_direccion2`,`ID_Pedido3`),
  FOREIGN KEY (`ID_Tienda2`) REFERENCES `tienda`(`ID_Tienda`),
  FOREIGN KEY (`ID_direccion2`) REFERENCES `Direccion`(`ID_direccion`),
  FOREIGN KEY (`ID_Pedido3`) REFERENCES `pedidos`(`ID_Pedido`)
  );




