--------------------------------------------------------
--  DDL for Table SRI_DETALLE_COMPRA
--------------------------------------------------------

  CREATE TABLE "SRI_DETALLE_COMPRA" 
   (	"ID" NUMBER, 
	"IDINFORMANTE" VARCHAR2(20 BYTE), 
	"ANIO" VARCHAR2(10 BYTE), 
	"MES" VARCHAR2(10 BYTE), 
	"CODSUSTENTO" VARCHAR2(10 BYTE), 
	"TPIDPROV" VARCHAR2(10 BYTE), 
	"IDPROV" VARCHAR2(20 BYTE), 
	"TIPOCOMPROBANTE" VARCHAR2(10 BYTE), 
	"PARTEREL" VARCHAR2(10 BYTE), 
	"FECHAREGISTRO" DATE, 
	"ESTABLECIMIENTO" VARCHAR2(10 BYTE), 
	"PUNTOEMISION" VARCHAR2(10 BYTE), 
	"SECUENCIAL" VARCHAR2(20 BYTE), 
	"FECHAEMISION" DATE, 
	"AUTORIZACION" VARCHAR2(100 BYTE), 
	"BASENOGRAIVA" NUMBER DEFAULT 0, 
	"BASEIMPONIBLE" NUMBER DEFAULT 0, 
	"BASEIMPGRAV" NUMBER DEFAULT 0, 
	"BASEIMPEXE" NUMBER DEFAULT 0, 
	"MONTOICE" NUMBER DEFAULT 0, 
	"MONTOIVA" NUMBER DEFAULT 0, 
	"VALRETBIEN10" NUMBER DEFAULT 0, 
	"VALRETSERV20" NUMBER DEFAULT 0, 
	"VALORRETBIENES" NUMBER DEFAULT 0, 
	"VALRETSERV50" NUMBER DEFAULT 0, 
	"VALORRETSERVICIOS" NUMBER DEFAULT 0, 
	"VALRETSERV100" NUMBER DEFAULT 0, 
	"TOTBASESIMPREEMB" NUMBER DEFAULT 0, 
	"CODIGO" VARCHAR2(20 BYTE), 
	"NUMERO" NUMBER
   )  TABLESPACE "DATOS" ;
--------------------------------------------------------
--  DDL for Index PK_SRI_DETALLE_COMPRA
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_SRI_DETALLE_COMPRA" ON "SRI_DETALLE_COMPRA" ("ID") 
  TABLESPACE "INDICES" ;
--------------------------------------------------------
--  Constraints for Table SRI_DETALLE_COMPRA
--------------------------------------------------------

  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("IDINFORMANTE" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("ANIO" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("MES" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("CODSUSTENTO" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("TPIDPROV" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("IDPROV" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("TIPOCOMPROBANTE" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("PARTEREL" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("FECHAREGISTRO" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("ESTABLECIMIENTO" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("PUNTOEMISION" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("SECUENCIAL" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("FECHAEMISION" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("AUTORIZACION" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SRI_DETALLE_COMPRA" ADD CONSTRAINT "PK_SRI_DETALLE_COMPRA" PRIMARY KEY ("ID")
  USING INDEX TABLESPACE "INDICES"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SRI_DETALLE_COMPRA
--------------------------------------------------------

  ALTER TABLE "SRI_DETALLE_COMPRA" ADD CONSTRAINT "FK_SRI_DETALLE_COMPRA" FOREIGN KEY ("IDINFORMANTE")
	  REFERENCES "SRI_INFORMANTE" ("IDINFORMANTE") ON DELETE CASCADE ENABLE;
