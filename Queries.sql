	#. Visualizar mediante una instrucción SQL todas las tiendas que componen la red de distribución de la fábrica se deberán detallar:
    #nombre de la tienda, dirección, descripción de la categoría, descuento y límite de crédito asociado a la tienda.

create view Tiendas
as
 select articulo_tienda.ID_Tienda , tienda.nombre_tienda,linea_pedido.Direccion_entrega, tienda.Credito,sum(linea_pedido.Cantidad*articulo.Precio) as Importe_tienda
    FROM  articulo_tienda 
    join articulo on articulo_tienda.ID_Articulo= articulo.ID_Articulo
    join tienda on tienda.ID_Tienda= articulo_tienda.ID_Tienda
    join linea_pedido on articulo_tienda.ID_Articulo= linea_pedido.ID_Articulo
	group by ID_Tienda;

create view Categorias
as
select ID_Tienda, nombre_tienda,Direccion_entrega,Importe_tienda,Credito,
(CASE 
    WHEN Importe_tienda<140000 THEN "A"
    WHEN Importe_tienda BETWEEN  140000 AND 149999 THEN "B"
    WHEN Importe_tienda BETWEEN  150000 AND 155000 THEN "C"
    ELSE "D"
	END) as Categoria
    from Tiendas;

select ID_Tienda, nombre_tienda,Direccion_entrega,Importe_tienda,Credito,
(CASE 
    WHEN Categoria = "A"THEN 0.03
    WHEN Categoria = "B" THEN 0.05
    WHEN Categoria ="C" THEN 0.11
    ELSE 0.16
	END) as descuento
    from Categorias;

#Visualizar mediante una instrucción SQL los pedidos suministrados a cada una de las tiendas en un
#período determinado (último año). Se deberán obtener los siguientes datos: número de pedido, fecha de suministro, dirección de entrega, y el importe total del pedido.
    select linea_pedido.ID_Pedido, linea_pedido.Fecha_pedido,  linea_pedido.Direccion_entrega,(linea_pedido.Cantidad*articulo.Precio) as Importe_pedido
    FROM  articulo_tienda 
    join articulo on articulo_tienda.ID_Articulo= articulo.ID_Articulo
    join tienda on tienda.ID_Tienda= articulo_tienda.ID_Tienda
    join linea_pedido on articulo_tienda.ID_Articulo= linea_pedido.ID_Articulo
	where Fecha_pedido BETWEEN  '2023-01-01 00:00:00' AND '2023-12-31 00:00:00'
    group by ID_Pedido;
    
#Identificar mediante una consulta SQL los repartos realizados por cada uno de los proveedores
#destinados a ello. Se deberá identificar al menos: Nombre del proveedor de reparto, su dirección y la
#relación de los artículos suministrados en cada reparto.

select proveedor.Nombre_proveedor , proveedor.direccion, articulo.ID_Articulo, distribucion_proveedor.Cantidad, articulo.Descripcion
    FROM  distribucion_proveedor
    join proveedor on  distribucion_proveedor.ID_Proveedor=proveedor.ID_Proveedor
    join articulo on  distribucion_proveedor.ID_Articulo= articulo.ID_Articulo
    ;
    
#Totalizar los repartos anuales realizados por cada proveedor de reparto

select proveedor.Nombre_proveedor ,distribucion_proveedor.Cantidad,(distribucion_proveedor.Cantidad*articulo.Precio) as Total_reparto
    FROM  distribucion_proveedor
    join proveedor on  distribucion_proveedor.ID_Proveedor=proveedor.ID_Proveedor
    join articulo on  distribucion_proveedor.ID_Articulo= articulo.ID_Articulo
    where Fecha_distribucion BETWEEN  '2023-01-01 00:00:00' AND '2023-12-31 00:00:00'
    group by proveedor.Nombre_proveedor
    ;
    
#Identificar los cambios a realizar en el modelo relacional y en BBDD para clasificar a los proveedores
#de reparto en categorías, de la misma forma que clasificamos las tiendas por categorías.

#se pueden incorporar los campos como atributos por medio de un Case, o se podría crear una nueva tabla con todas las clasificaciones y hacer la relacion mediante ests

#Necesitamos introducir nuevos atributos en la tabla de artículos, la fábrica ha descubierto que puede
#comprar un artículo de parecidas características al nuestro y distribuirlo como marca blanca.

#En este caso se debe diferenciar los productos que son producidos por la fábrica de aquellos que sólo va a distribuir, para ello se puede añadir 
#un ID_fabrica y un ID_artículo, asignándole un ID_fabrica que sea el mismo para todos los productos que son de distribución y haciendo la diferencia
#en el ID artículo, mientras que los fabricados tendran un ID para fábrica y otro para artículo, y la primary key sea la composicion de ambos ID

#Queremos ampliar la información del proveedor de suministro, para ello necesitaríamos incorporar los
#datos relativos a las zonas de cobertura de este (Países y Regiones). Determinar los cambios a
#realizar a nivel físico y lógico.

# Se añadirían estos atributos a la tabla de dirección que está vinculada con el proveedor, a nivel lógico se adicionarían los atributos a la tabla y a nivel estructural quedarían las conexiones igual




    
