# Proyecto Bookstore - José Alfredo Arroyo

## Descripción
Este proyecto implementa un Data Warehouse para la gestión de órdenes de libros, donde se incluye el modelado dimensional, la creación de tablas de hechos y dimensiones, y los procesos ETL desarrollados en SQL Server Integration Services (SSIS).

## Estructura del proyecto
- **BookStoreOLTP**: Base de datos transaccional con las tablas del negocio consistentes en libros, autores, clientes y órdenes.
- **BookStoreDW**: Base de datos dimensional que contiene las tablas de dimensiones y hechos diseñadas para análisis OLAP.
- **BookStoreETL**: Paquetes en SQL Server Integration Services (SSIS) que cargan dimensiones y hechos, con manejo de errores y àrea de staging.
- **BookStoreOLAP**: Proyecto Tabular en Analysis Services como implementación de métricas y perspectivas del proyecto.
- **README.md**: Documentación principal

## Modelo Dimensional 
- **DimBook**: Información de libros y autores.
- **DimCustomer**: Datos de clientes y direcciones.
- **DimAddress**: Ubicaciones de entrega.
- **DimShippingMethod**: Métodos de envío y costos.
- **DimDate**: Calendario para el análisis temporal.
- **FactOrders**: Tabla de hechos con toda la información cruzada de dimensiones.

## Procesos ETL
- **Extracción**: Procedimientos como GetBookChangesByRowVersion y GetOrdersChangesByRowVersion para extraer la informaciòn y volcarla al DW.
- **Transformación**: Concatenación de autores con libros y manejo de no coincidencias en Lookups.
- **Carga**: Procedimientos como DW_MergeDimBook, DW_MergeDimAuthor y DW_MergeFactOrders para el llenado de dimensiones y hechos.
