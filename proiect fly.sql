CREATE DATABASE IF NOT EXISTS FLY;
USE  FLY;

CREATE TABLE IF NOT EXISTS zboruri(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
companie VARCHAR(20),
acronim VARCHAR(20),
nr_zbor VARCHAR(20)
);


CREATE TABLE calatori(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(20),
prenume VARCHAR(20),
adresa VARCHAR(20),
data_zbor DATE,
id_zbor TINYINT,
FOREIGN KEY(id_zbor)references zboruri(id)
);

DESCRIBE calatori;

CREATE TABLE plati(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_zbor TINYINT,
id_calator TINYINT,
valoare_plata VARCHAR(20),
FOREIGN KEY(id_zbor)references zboruri(id),
FOREIGN KEY(id_calator)references calatori(id)
);

CREATE TABLE anulari(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_anulari INT,
data_anulare DATE,
id_zbor TINYINT,
FOREIGN KEY(id_zbor)references zboruri(id)
);
DROP TABLE anulari;
DESCRIBE anulari;
SHOW TABLES;

ALTER TABLE calatori ADD nr_telefon VARCHAR(50);
DESCRIBE calatori;

ALTER TABLE plati ADD tip_plata VARCHAR(50);
DESCRIBE plati;

ALTER TABLE anulari CHANGE data_anulare perioada_anulare VARCHAR(50) NOT NULL UNIQUE;
DESCRIBE anulari;

ALTER TABLE anulari ADD suma_restituita VARCHAR(50);
DESCRIBE  anulari;

ALTER TABLE anulari DROP suma_restituita;
DESCRIBE anulari;

RENAME TABLE anulari TO cancellations;
DESCRIBE cancellations;

ALTER TABLE calatori DROP FOREIGN KEY calatori_ibfk_1;
ALTER TABLE calatori ADD FOREIGN KEY (id_zbor)references zboruri(id);

RENAME TABLE cancellations TO anulari;
DESCRIBE anulari;

INSERT INTO zboruri VALUES

(NULL,'Lufthansa','LH', 1008),
(NULL,'Swiss Air','SA',2457),
(NULL,'Tarom','TR', 4980),
(NULL,'Iberia','IB',3492),
(NULL,'Air Canada','AC',1432),
(NULL,'Edelweiss','ED',108),
(NULL,'KLM','KM',1234),
(NULL,'Air France','AR',290),
(NULL,'Qantas','QN',3456),
(NULL,'Air Malta','AM',922);

SELECT * FROM zboruri;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE zboruri;
SET FOREIGN_KEY_CHECKS = 1; 

INSERT INTO calatori VALUES
(NULL,'Ionescu','Anda','Bd.Virtutii 18','2019-09-23',3,'0736323412','Barcelona','Bucuresti','2020-01-02'),
(NULL,'Demetriade','Ion', 'Str.Dezrobirii 19','2007-12-07',6,'0777976543','Venetia','Madrid','2019-06-02'),
(NULL,'Popescu','Elisabeta','Str.Sergent Nicolae Popovici 12','2020-11-11',8,'0728234567','New York','Baltimore','2018-03-02'),
(NULL,'Banica','Mariana','Bd.Ion Creanga 432','2001-08-09',1,'0728823461','Sao Paulo','Osaka','2019-07-23'),
(NULL,'Marinescu','Ion','Str.George Enescu 88','1994-10-29',5,'0760976532','Cairo','Moscova','2018-03-14'),
(NULL,'Verman','Adela','Bd.Magheru 09','2014-08-30',8,'0726709843','Chennai','Essen','2020-08-21'),
(NULL,'Stroe','Mariana','Str.Nicolae Ion 14','2018-08-04',9,'0728821265','Detroit','Caracas','2016-08-09'),
(NULL,'Beldiman','Gheorghe','Bd.Iancu de Hunedoara 255','2017-02-28',3,'0788882376','Monterrey','Ankara','2016-10-27'),
(NULL,'Gheorghiu','Aura','Bd.Florilor 23','2020-01-01',4,'0735236786','Alep','Salvador','2014-03-28'),
(NULL,'Badulescu','Felicia','Str.Bujorilor 432','2013-06-30', 5,'0739765432','Napoli','Sibiu','2019-11-29');

SELECT * FROM calatori;

INSERT INTO plati VALUES
(NULL,1,3,2466,'virament bancar'),
(NULL,2,9,4900,'internet banking'),
(NULL,3,10,7900,'cash la agentie'),
(NULL,4,7,357,'virament bancar'),
(NULL,9,1,8000,'op'),
(NULL,5,8,3667,'op'),
(NULL,8,4,2505,'cash la agentie'),
(NULL,10,5,6700,'cash la agentie'),
(NULL,7,6,1200,'virament bancar'),
(NULL,6,2,6700,'op');

DESCRIBE plati;
SELECT * FROM plati;

INSERT INTO anulari VALUES

(NULL,899,'1992-03-03',1),
(NULL,06,'2020-03-28',4),
(NULL,728,'1997-09-30',8),
(NULL,459,'2003-03-21',3),
(NULL,05,'2020-03-10',5),
(NULL,68,'2019-06-23',10),
(NULL,47,'2019-08-28',7),
(NULL,356,'2006-06-14',2),
(NULL,340,'2006-08-01',6),
(NULL,55,'2019-07-29',9);

SELECT * FROM anulari;


INSERT INTO calatori VALUES
(NULL,'Georgescu','Marilena','Bd.Dinicu Golescu 88','2016-04-09',6,'0722849382'),
(NULL,'Costea','Andrei','Str.Vanatorilor 49','2019-09-21',7,'0788129234');

SELECT * FROM calatori;

SET sql_safe_updates = 0;
UPDATE calatori SET nr_telefon =' 0721212121' WHERE nume = 'Costea' and prenume = 'Andrei';
SELECT * FROM calatori;



UPDATE calatori SET nr_telefon =' 0721212121' WHERE id_zbor= 3;
SELECT * FROM calatori;


UPDATE calatori SET nr_telefon =' 0721212121' WHERE id= 11;
SELECT * FROM calatori;


SET sql_safe_updates = 0;
DELETE FROM calatori WHERE nume = 'Costea' and prenume = 'Andrei';
SELECT * FROM calatori;

DELETE FROM calatori WHERE id= 11;
SELECT * FROM calatori;

SET sql_safe_updates = 0;
 SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM calatori WHERE data_plecare >2010;
SELECT * FROM calatori;
DROP TABLE calatori;

# Interogari variate cu select:
# SUBINTEROGARI:
# 1.afisati calatorii care au calatorit cu aceeasi companie ca si Popescu Elisabeta
SELECT id_zbor FROM calatori WHERE nume = 'Popescu' and prenume = 'Elisabeta';
SELECT * FROM calatori where id_zbor = (SELECT id_zbor FROM calatori WHERE nume = 'Popescu' and prenume = 'Elisabeta');


# 2. sa se afle care sunt persoanele care au calatorit impreuna cu Beldiman Gheorghe.
SELECT id_zbor FROM calatori WHERE nume = 'Beldiman'and prenume = 'Gheorghe';
SELECT * FROM calatori WHERE id_zbor = (SELECT id_zbor FROM calatori WHERE nume = 'Beldiman'and prenume = 'Gheorghe');


# 3. sa se afle toate persoanele care au calatorit dupa Verman Adela
SELECT data_zbor FROM calatori WHERE nume = 'Verman' AND prenume = 'Adela';
SELECT * FROM calatori WHERE data_zbor >(SELECT data_zbor FROM calatori WHERE nume = 'Verman' AND prenume = 'Adela');

SELECT DISTINCT(id_anulari) FROM anulari WHERE perioada_anulare < '2019-06-23';

SELECT id_anulari FROM anulari WHERE perioada_anulare < '2019-06-23';

# sa se afiseze numele calatorilor care au calatorit cel mai devreme in 2020
SELECT nume, prenume
from calatori
where id in(select distinct id from calatori where data_plecare >= '2020');
SELECT * FROM calatori;


#JOINURI

# 1.sa se afiseze numele calatorilor pentru care avem anulari
SELECT nume,prenume FROM calatori,anulari WHERE calatori.id = anulari.id_anulari;
SELECT nume,prenume,perioada_anulare FROM calatori INNER JOIN anulari WHERE calatori.id = anulari.id_anulari;


# 2.sa se afiseze toate zborurile cu perioada de anulare
SELECT companie,nr_zbor,perioada_anulare FROM zboruri LEFT JOIN anulari ON zboruri.id = anulari.id_zbor;


SELECT nume,prenume,adresa FROM calatori UNION ALL SELECT id_zbor,id_calator,valoare_plata FROM plati;


# 3.sa se afiseze pentru fiecare companie numele tarii de origine SELF JOIN
SELECT plecari.nume AS plecari,
sosiri.nume AS sosiri
FROM zboruri AS plecari,zboruri AS sosiri
WHERE plecari.nr_zbor = sosiri.id;

# FUNCTII DE GRUP/HAVING:

SELECT CONCAT(nume,prenume,adresa,data_plecare,id_zbor,nr_telefon)AS nume,companie FROM calatori,zboruri WHERE id_zbor = 3;

SELECT CONCAT(nume,prenume,adresa,data_plecare,id_zbor,nr_telefon)AS nume,companie FROM calatori,zboruri WHERE nr_zbor < 280;

# sa se creeze pentru fiecare calator un cod format din nume si oras sosire
select nume,prenume,id_zbor,
concat( substring(nume,1,10),oras_sosire)as cod
from calatori;

# sa se afiseze calatorii care au efectuat zboruri in primul an
select concat_ws('',nume,prenume) as primul_zbor
from calatori
where year(data_plecare)=(select min(year(data_plecare))from calatori);
select * from calatori;

# sa afiseze pentru fiecare companie cate zboruri efectuate are
select companie,count(*) as nr_zbor
from zboruri
group by companie;

#sa se afle toti calatorii cu valoarea platii mai mica de 7900
SELECT id_calator,SUM(valoare_plata) AS Pret
FROM plati
GROUP BY id_calator
HAVING SUM(valoare_plata)<7900;

#dorim sa aflam  totalul metodelor de plata si care sunt acestea pentru sume mai mari decat 6000

SELECT tip_plata,SUM(valoare_plata) AS Pret
FROM plati
GROUP BY tip_plata
HAVING SUM(valoare_plata)>6000;

# Functii predefinite
#sa se afle toate platile mai mari decat plata medie
SELECT AVG(valoare_plata) AS plata_medie FROM plati;
SELECT * FROM plati WHERE valoare_plata >(SELECT AVG(valoare_plata) AS plata_medie FROM plati);



#afisarea valorii platilor mediu, maxim, minim si suma tuturor platilor cu tipul de plata 'virament bancar':
SELECT AVG(valoare_plata), MAX(valoare_plata), MIN(valoare_plata), SUM(valoare_plata)
FROM plati
WHERE tip_plata = 'virament bancar';

# sa se afiseze toate platile cuprinse intre 200 si 1500 lei si id-ul calatorului care le-a efectuat.
select id_calator,valoare_plata
from plati
where valoare_plata between 200 and 1500;

# Sa se afiseze cea mai departata si cea mai apropiata data de plecare:

 SELECT min(data_plecare) as data_plecare_minima,
        max(data_plecare) as data_plecare_maxima
 from calatori;

# sa se afiseze pentru fiecare calator daca numarul de telefon este fix  sau mobil

select nume,prenume,nr_telefon,
if(nr_telefon = 'mobil','mobil','fix')as categorie
from calatori;


UPDATE calatori SET data_plecare = DATE_ADD(data_plecare,INTERVAL 3 DAY);
SELECT * FROM calatori;


#VIEW-uri:
# sa se creeze o tabela virtuala cu numele, prenumele calatorilor si valoarea platii biletelor de avion
CREATE OR REPLACE VIEW detalii_plata AS SELECT nume,prenume,valoare_plata FROM calatori,plati 
WHERE calatori.id = plati.id_calator;
SELECT * FROM detalii_plata;


# sa se creeze o tabela virtuala cu numele calatorilor si numarul de zboruri anulate:
CREATE VIEW NumarAnulari as
SELECT concat_ws(' ',nume,prenume) as nume_anulari,
	   count(id_anulari) as nr_anulari
       from calatori as a
       left join anulari as b on a.id = b.id
       group by a.id;
SELECT * from NumarAnulari;       
       

CREATE OR REPLACE VIEW zboruri_anulate AS SELECT zboruri.companie,zboruri.nr_zbor,anulari.perioada_anulare FROM zboruri INNER JOIN anulari ON zboruri.id = anulari.id_zbor;
SELECT * FROM zboruri_anulate;

# sa se creeze o tabela virtuala cu toti cei care au calatorit in 2020.
CREATE VIEW Calatori_2020 as 
SELECT * FROM calatori
WHERE year(data_plecare) = 2020;
SELECT * FROM Calatori_2020;
SELECT * FROM calatori;

# sa se creeze o tabela virtuala cu id-ul calatorilor si  zborurile efectuate in ordine descrescatoare
CREATE VIEW ZboruriDesc as
select id,avg(data_plecare) as plecari
from calatori
group by id
order by avg(data_plecare) desc;
SELECT * FROM ZboruriDesc;




#PROCEDURI

# 1.  Sa se scrie o procedura care primeste id-ul unui calator si determina cate plati mai mari de 3000 RON are sau afiseaza textul'' nu exista plati mai mari de 3000 ron!''.

DELIMITER //
create procedure mesaj_plata(in id int)
begin
	declare numar_plati int;
    
    select count(valoare_plata) into numar_plati
    from plati
    where id_calator = id and valoare_plata >3000;
    
    
    if (numar_plati=0) then select 'Nu exista plati mai mari de 3000 ron!' as mesaj;
    else select numar_plati as plati_mai_mari_ca_3000_ron;
    end if;
end;
//
delimiter ;

call mesaj_plata(2);
call mesaj_plata (7);
select * from plati;


# sa se scrie o procedura care primeste numarul unei liste si afiseaza denumirile tuturor companilor din acea lista
DELIMITER //
create procedure lista(in nr_lista int)
begin
	select concat_ws(' ',companie,acronim) as denumiri_companii
    from zboruri
    where lista=nr_lista;
end; 
 //
DELIMITER ;

 call lista(3);
 
 


DELIMITER //
CREATE PROCEDURE afisareNrZboruri()
BEGIN
	SELECT COUNT(nr_zbor) FROM zboruri;
END;
//
DELIMITER ;

CALL afisareNrZboruri();


#1.Sa se realizeze o procedura care determina cate plati sunt de un anumit tip


DELIMITER //
CREATE PROCEDURE afisareNrrPlati (IN tipPlati VARCHAR(100))
BEGIN
     SELECT COUNT(tip_plata) FROM plati
     WHERE tip = tipPlati ;
END;
//
DELIMITER ;

CALL afisareNrrPlati('op');
CALL afisareNrrPlati ('virament bancar');
CALL afisareNrrPlati ('cash la agentie');



#2.afisati numarul de zboruri din anii 2020 si 2018.

DELIMITER //
CREATE PROCEDURE nr_zboruri(IN an_zbor int)
BEGIN
	SELECT COUNT(*) FROM calatori
    WHERE YEAR(data_plecare) = an_zbor;
    
END;
//
DELIMITER ;

CALL nr_zboruri(2020);
CALL nr_zboruri(2018);

# 3.sa se determine cate anulari de zboruri au fost efectuate in anii 2019,2020,2006.
DELIMITER //
CREATE PROCEDURE nr_anulari(IN an_anulare INT, OUT nr_anulari INT)
BEGIN
	SELECT COUNT(*) INTO nr_anulari
    FROM anulari
    WHERE year(perioada_anulare) = an_anulare;
END;
//
DELIMITER ;

CALL nr_anulari(2006,@nr_anulari);
SELECT @nr_anulari;
CALL nr_anulari(2020,@nr_anulari);
SELECT @nr_anulari;
CALL nr_anulari(2019,@nr_anulari);
SELECT @nr_anulari;



#
DELIMITER //
CREATE PROCEDURE detalii_plata(IN id_plata INT, OUT numeR VARCHAR(30),
								OUT prenumeR VARCHAR(30),
								OUT metodaR VARCHAR(30))
                                
  begin 
  
SELECT nume,prenume,tip_plata INTO numeR, prenumeR, metodaR
			FROM calatori,plati
			WHERE id = id_plata;

  END;
  //
  DELIMITER ;
  
  DROP PROCEDURE detalii_plata;
  
  CALL detalii_plata(3,@numeR,@prenumeR,@metodaR);
  SELECT @numeR,@prenumeR,@metodaR;
  
  #sa se realizeze o procedura pentru calcularea numarului de plati:
  DELIMITER //
  CREATE PROCEDURE afisareNrPlati()
  BEGIN 
	SELECT COUNT(id_zbor)FROM plati;
  END;
  //
  DELIMITER ;
  
  CALL afisareNrPlati();
    
    
    
 # FUNCTII

# 1. Sa se realizeze o functie care sa numere cate anulari avem per companie.
 DELIMITER //
 CREATE FUNCTION nrAnulariCompanie(anulariCompanie VARCHAR(200)) RETURNS int

BEGIN
	DECLARE nr int DEFAULT 0;
    SELECT COUNT(id_anulare) INTO nr
    FROM anulari AS an, zboruri AS zb
    WHERE zb.id_zboruri = an.id_zboruri
    AND zb.companie = anulariCompanie;
    
    RETURN nr;
 END;
 //
 DELIMITER ;
 SELECT nrAnulariCompanie('Swiss Air');
 SELECT nrAnulariCompanie('1008');
 
 DROP FUNCTION nrAnulariCompanie;


#2.sa se creeze o functie care primeste id calator si returneaza un mesaj de forma nume,prenume, a achitat suma.

DELIMITER //
CREATE FUNCTION vezi_detalii(idA TINYINT) RETURNS VARCHAR(200)
BEGIN
	DECLARE v_valPlata INT;
    DECLARE v_nume VARCHAR(30);
	DECLARE v_prenume VARCHAR(30);
    DECLARE mesaj VARCHAR(300);
    SELECT nume, prenume,valoare_plata INTO v_nume,v_prenume,v_valPlata FROM calatori,plati WHERE id = idA;
    SET mesaj = concat_ws('',v_nume,v_prenume,'a achitat suma',v_valPlata);
    RETURN mesaj;
    END;
    //
    DELIMITER ;
    
    SELECT vezi_detalii(2);

#3. sa se realizeze o functie care sa numere cati calatori avem per companie
DELIMITER //
CREATE FUNCTION nrCalatoriCompanie(companieZboruri VARCHAR(200)) RETURNS int

BEGIN
	DECLARE nr int DEFAULT 0;
    SELECT COUNT(id)INTO nr
    FROM calatori AS cl, zboruri AS zb
    WHERE zb.id_zbor = cl.id_zbor
    AND zb.companie = companieZboruri;
    
    RETURN nr;
    
 END;
 //
 DELIMITER ;
 
 SELECT nrCalatoriCompanie('Tarom');
 DROP FUNCTION nrCalatoriCompanie;
 
 
 
 #4. sa se realizeze o functie care primeste in id de ''reducere bilet de avion'' si un ''pret maxim'' pentru care oferta sa fie acceptata.
 #Daca pretul ofertei < decat pretul maxi, returnal ''oferta acceptata'', in caz contrar returnam ''oferta refuzata''
 
 
 DELIMITER //
 CREATE FUNCTION reducereBiletdeAvion(idReducere int, limita int) RETURNS VARCHAR(100)
 BEGIN
	DECLARE mesaj VARCHAR(100);
    DECLARE valoarePlati DOUBLE(7,2);
   
 SELECT valoare_plata INTO valoarePlati FROM plati WHERE id = idReducere AND limita>3000;
 IF valoarePlati < limita THEN 
			SET mesaj:= 'Oferta Acceptata!';
 else
			SET mesaj := 'Oferta Refuzata!';
END IF;

RETURN mesaj;

END;
//
DELIMITER ;

DROP FUNCTION reducereBiletdeAvion;
SELECT reducereBiletdeAvion(1,1500);
 SELECT reducereBiletdeAvion(1,6000);
 
 # 5.sa se realizeze o functie care primeste ca parametru un id de modalitate plata si un tip de plata care sa fie virament bancar.Daca tipul platii este virament bancar atunci plata este acceptata ,in caz contrar plata este respinsa.
 DELIMITER //
 CREATE FUNCTION PlataAcceptata(idModalitatePlata int, tipPlata int) RETURNS VARCHAR(30)
 BEGIN
 DECLARE mesaj VARCHAR(30)
 DECLARE modPlata VARCHAR(30)
 
 SELECT tip_plata INTO modPlata FROM plati WHERE id = idPlata;
 
IF modPlata = 'virament bancar'
		SET mesaj:= 'Oferta Acceptata!'
ELSE
		SET mesaj:= 'Oferta respinsa!'
END IF
RETURN mesaj;
END;
//
DELIMITER ;

# Sa se creeze o functie in care se da un id de calator ,sa se returneze cea mai mare plata.

DELIMITER //
CREATE FUNCTION plata_max(id_a INT) RETURNS DOUBLE
BEGIN
	DECLARE val_p DOUBLE;
    DECLARE val_max DOUBLE;
    DECLARE id_a_copy INT;
		SET val_max = 0;
        SET id_a_copy = id_a;
        bucla:LOOP
        IF id_a_copy = 1 THEN
        leave bucla;
 END IF;
	SELECT valoare_plata INTO val_p FROM plati WHERE id = id_a_copy;
    IF val_p > val_max THEN 
    SET val_max = val_p;
END IF;
		SET id_a_copy = id_a_copy-1;
 END LOOP bucla;
 RETURN val_max;
 END;
 //
 DELIMITER ;
 
 SELECT plata_max(5);
 SELECT * FROM plati;
 
 
 # Se da un id de zbor. Pentru denumirea companiei corespunzatoare id-ului sa se afiseze o denumire extinsa.
 
 delimiter //
create function extinde_nume(id_zbor varchar(30))
	returns varchar(60)
begin
	declare nume_extins varchar(60);
    declare nume_initial varchar(60);
  
    select acronim
		into nume_initial
	from zboruri
    where id = id_zbor;
 
    case nume_initial
		when 'LH' then 
			set nume_extins = 'Lufthansa';
		when 'SA' then 
			set nume_extins = 'Swiss Air';
		when 'TR' then
			set nume_extins = 'Tarom';
         when 'IB' then
              set nume_extins = 'Iberia';
		when 'AC' then
              set nume_extins = 'Air Canada';
         when 'ED' then 
			set nume_extins = 'Edelweiss';
		when 'KM' then 
			set nume_extins = 'KLM';
		when 'AR' then
			set nume_extins = 'Air France';
        when 'QN' then 
			set nume_extins = 'Qantas';
		when 'AM' then
			set nume_extins = 'Air Malta';
end case;
	return nume_extins;
end;
//
delimiter ;

set global log_bin_trust_function_creators = 1;
select * from zboruri;
select extinde_nume(3);
select extinde_nume(8);

#CURSORI

# 1. Sa se faca o functie care calculeaza media valorii platii biletelor de avion

DELIMITER //
CREATE FUNCTION medie_plata()RETURNS FLOAT(7,2)
BEGIN
	DECLARE v_valoare_plata int;
    DECLARE nr_inreg int;
    DECLARE v_suma int;
    DECLARE stop TINYINT DEFAULT 0;
    DECLARE c1 cursor for SELECT ifnull(valoare_plata,0) AS valoare_plata_c FROM plati;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
		SET STOP = 1;
END;
	SET v_suma = 0;
    SET nr_inreg = 0;
    open c1 ;
    bucla:loop
		fetch c1 into v_valoare_plata;
        if stop =1 THEN 
        leave bucla;
 END IF;
	SET v_suma = v_suma + v_valoare_plata;
    set nr_inreg = nr_inreg + 1;
    end loop bucla;
    close c1;
    return v_suma/nr_inreg;
END;
//
DELIMITER ;

SELECT medie_plata();    

 # 2.  Sa se creeze o functie care sa primeasca ca parametru un oras si sa se afiseze toate destinatiile zborurilor care pornesc din acel oras
  
   ALTER TABLE calatori ADD oras_plecare VARCHAR(50);
   DESCRIBE calatori;
   
   ALTER TABLE calatori ADD oras_sosire VARCHAR(50);
   DESCRIBE calatori;
   
   ALTER TABLE calatori CHANGE data_zbor data_plecare VARCHAR(50);
   DESCRIBE calatori;
   
   ALTER TABLE calatori ADD data_sosire VARCHAR(50);
   DESCRIBE calatori;
   
   
  
   SELECT * FROM calatori;
   
   SET FOREIGN_KEY_CHECKS = 0;
    TRUNCATE calatori;
    SET FOREIGN_KEY_CHECKS = 1;
    SELECT * FROM calatori;
    
  DELIMITER //
  CREATE FUNCTION  info_destinatii(orasplecare VARCHAR(50)) RETURNS VARCHAR(50)
  BEGIN
	DECLARE v_oras_sosire VARCHAR(50);
    DECLARE v_semafor VARCHAR(10) DEFAULT 'verde';
    DECLARE v_desfasurator_destinatii VARCHAR(500);
    DECLARE c  cursor for select oras_sosire FROM calatori WHERE oras_plecare = orasplecare;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
		SET v_semafor = 'rosu';
  END;
  OPEN c;
  destinatii :LOOP
			FETCH c INTO v_oras_sosire;
		IF v_semafor = 'rosu' THEN
            LEAVE destinatii;
            
 else
		SET v_desfasurator_destinatii = concat_ws(',',v_oras_sosire, v_desfasurator_destinatii);
 END IF;
 END LOOP;
 CLOSE c;
 return v_desfasurator_destinatii;
 
 END;
 //
 DELIMITER ;
 
 SELECT info_destinatii('Barcelona');
 SELECT info_destinatii('Osaka');
 SELECT info_destinatii('Cairo');
 
 #  3.  -- Sa se scrie o procedura care primeste ca parametru o data de plecare,si afiseaza orasul de plecare si orasul destinatie, pentru plecarile care sunt programate dupa acea data.

delimiter //
create procedure detalii_plecare(in p_data_plecare date)
begin
	declare v_oras_plecare varchar(20);
    declare v_oras_sosire varchar(20);
    declare v_data_plecare date;
    declare final tinyint default 0;

    declare c1 cursor for select oras_plecare, oras_sosire, data_plecare from calatori;
    
    declare continue handler for not found
    begin
		set final = 1;
	end;
    open c1;
    bucla: loop
            fetch c1 into v_oras_plecare, v_oras_sosire, v_data_plecare;
            if final = 1 then
			leave bucla;
	end if;
           if v_data_plecare > p_data_plecare then    
           select v_oras_plecare, v_oras_sosire;
		end if;
        end loop bucla;
        close c1;
end;
//
delimiter ;

call detalii_plecare('2018-01-01');



#Triggers

# 1. sa se construiasca un trigger carese declanseaza inainte de fiecare adaugare a unui nou calator:
delimiter //
create trigger inserari_noi after insert on calatori
for each row
begin
	declare v_sir_final varchar(200);
   
    set v_sir_final = concat('S-a inserat calatorul ', new.nume,' cu id-ul ',new.nume );
   
	insert into calator_nou
		values(null, v_sir_final, current_date());
end;
//
delimiter ;


INSERT INTO calatori VALUES
(null,'Ianovici','Florin','Revolutiei 4','2020-03-06',4,'0721345678','Bucuresti','LasVegas','2020-03-07');





#varianta a 2-a

DELIMITER //

CREATE TRIGGER before_calatori_insert BEFORE INSERT ON calatori
FOR EACH ROW
BEGIN
	SET NEW.nume = lower(trim(NEW.nume));
    SET NEW.prenume = lower(trim(NEW.prenume));
    
    IF NEW.data_plecare > curdate()THEN
			SET new.data_plecare = curdate();
            END IF;
END;            
//
DELIMITER ; 

INSERT INTO calatori VALUES
(NULL,'Cojocaru','Ioana','Str.Nicolae Ion 14','2018-08-04',9,'0728821265','Detroit','Caracas','2020-02-09');
SELECT * FROM calatori;
SELECT * FROM calator_nou;

  

# 2. Sa se construiasca un trigger care se declanseaza dupa fiecare adaugare de un nou calator.

CREATE TABLE IF NOT EXISTS calator_nou(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_calator TINYINT NOT NULL,
user VARCHAR(50)NOT NULL,
data_adaugare DATE NOT NULL,
detalii VARCHAR(100) NOT NULL,
foreign key(id_calator) REFERENCES calatori(id)
);

DROP TABLE calator_nou;

DELIMITER //
CREATE TRIGGER after_calatori_insert AFTER INSERT ON calatori
FOR EACH ROW
BEGIN
		INSERT INTO calator_nou VALUES(NULL,NEW.id,curdate(),
        concat('Calator_nou:',NEW.nume,'',NEW.prenume));
END;
//
DELIMITER ;

     
INSERT INTO calatori VALUES
(NULL,'Ionescu','Ioana','Str.Nicolae Ion 14','2019-02-39',1,'0728821265','Detroit','Caracas','2019-02-09');

SELECT * FROM calatori;

SELECT * FROM calator_nou; 
 
 # 3. sa se construiasca un trigger care se declanseaza dupa fiecare adaugare si face schimbarea datei de plecare sau a numarului de telefon acolo unde cele doua se modifica.
 
 DELIMITER //
 CREATE TRIGGER after_calatori_update AFTER UPDATE ON calatori
 FOR EACH ROW
 BEGIN
	IF OLD.data_plecare!= NEW.data_plecare THEN
    INSERT INTO calator_nou VALUES
    (NULL,NEW.id,user(),curdate(),
    concat('Schimbare de nume:de la',OLD.nume,'la',NEW.nume));
    END IF;
    
    IF OLD.nr_telefon!= NEW.nr_telefon THEN
		INSERT INTO calator_nou VALUES
        (NULL,NEW.id,user(),curdate(),
        concat('Schimbare numar de telefon:',NEW.nr_telefon - OLD.nr_telefon));
        END IF;
END;
//
DELIMITER ;        

SET sql_safe_updates = 0;
UPDATE calatori SET data_plecare = '2020-01-01',nr_telefon = '0735359876' WHERE id = 2;
SELECT * FROM calatori;
SELECT * FROM calator_nou;
