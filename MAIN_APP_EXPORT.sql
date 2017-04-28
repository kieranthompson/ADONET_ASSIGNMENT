--------------------------------------------------------
--  File created - Friday-April-28-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table GUITARS
--------------------------------------------------------

  CREATE TABLE "GUITARSTORE"."GUITARS" 
   (	"GUITAR_ID" NUMBER, 
	"MANUFACTURER" VARCHAR2(20 BYTE), 
	"GUITAR_MODEL" VARCHAR2(255 BYTE), 
	"PRICE" NUMBER(*,0), 
	"QUANTITY" NUMBER, 
	"COLOR" VARCHAR2(20 BYTE), 
	"SKIN_PATTERN" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into GUITARSTORE.GUITARS
SET DEFINE OFF;
--------------------------------------------------------
--  Constraints for Table GUITARS
--------------------------------------------------------

  ALTER TABLE "GUITARSTORE"."GUITARS" MODIFY ("COLOR" NOT NULL ENABLE);
  ALTER TABLE "GUITARSTORE"."GUITARS" MODIFY ("QUANTITY" NOT NULL ENABLE);
  ALTER TABLE "GUITARSTORE"."GUITARS" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "GUITARSTORE"."GUITARS" MODIFY ("GUITAR_MODEL" NOT NULL ENABLE);
  ALTER TABLE "GUITARSTORE"."GUITARS" MODIFY ("MANUFACTURER" NOT NULL ENABLE);
  ALTER TABLE "GUITARSTORE"."GUITARS" MODIFY ("GUITAR_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  DDL for Procedure ADD_GUITAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GUITARSTORE"."ADD_GUITAR" (
new_guitar_id GUITARS.GUITAR_ID%type,
new_guitar_manufacturer GUITARS.MANUFACTURER%type,
new_guitar_model GUITARS.GUITAR_MODEL%type,
new_guitar_price GUITARS.PRICE%type,
new_guitar_quantity GUITARS.QUANTITY%type,
new_guitar_color GUITARS.COLOR%type,
new_guitar_skin_pattern GUITARS.SKIN_PATTERN%type
)
as
begin insert into GUITARS 
(GUITAR_ID, MANUFACTURER, GUITAR_MODEL, PRICE, QUANTITY, COLOR, SKIN_PATTERN) 
values 
( new_guitar_id, new_guitar_manufacturer, new_guitar_model, new_guitar_price, new_guitar_quantity, new_guitar_color, new_guitar_skin_pattern);
Commit;
exception
when dup_val_on_index then
raise_application_error(-20001, 'Guitar Already On Stock File');
when others then
raise_application_error(-20011, sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure DELETE_GUITAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GUITARSTORE"."DELETE_GUITAR" 
(
req_guitar_id NUMBER
)
is no_of_records_found number;
BEGIN
SELECT count(*) into no_of_records_found FROM GUITARS
WHERE GUITAR_ID = req_guitar_id;
IF no_of_records_found >= 1 THEN
delete from GUITARS where GUITAR_ID = req_guitar_id;
commit;
else
RAISE_APPLICATION_ERROR(-20010, 'Guitar Does Not Exist On Stock File');
END IF;
END DELETE_GUITAR;

/
--------------------------------------------------------
--  DDL for Procedure EDIT_GUITAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "GUITARSTORE"."EDIT_GUITAR" (
req_guitar_id GUITARS.GUITAR_ID%type,
new_guitar_manufacturer GUITARS.MANUFACTURER%type,
new_guitar_model GUITARS.GUITAR_MODEL%type,
new_guitar_price GUITARS.PRICE%type,
new_guitar_quantity GUITARS.QUANTITY%type,
new_guitar_color GUITARS.COLOR%type,
new_guitar_skin_pattern GUITARS.SKIN_PATTERN%type)
AS
no_of_records_found number;
Begin
SELECT count(*) into no_of_records_found FROM GUITARS
WHERE GUITAR_ID = req_guitar_id;
IF no_of_records_found >= 1 THEN
update GUITARS
set MANUFACTURER = new_guitar_manufacturer,
    GUITAR_MODEL = new_guitar_model,
    PRICE = new_guitar_price,
    QUANTITY = new_guitar_quantity,
    COLOR = new_guitar_color,
    SKIN_PATTERN = new_guitar_skin_pattern
where GUITAR_ID = req_guitar_id;
commit;
else
RAISE_APPLICATION_ERROR(-20010, 'Guitar Not On Stock File');
END IF;
END EDIT_GUITAR;

/
