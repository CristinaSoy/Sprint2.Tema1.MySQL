# Estructura de Dades - MySQL (Tema 1)

## 📄 Descripció

Aquest projecte conté la resolució d'exercicis sobre modelatge de bases de dades utilitzant **diagrames entitat-relació** i estructures relacionals. S'han creat models per a dos casos pràctics: una òptica i una pizzeria.

---

## 💻 Exercicis

### **Nivell 1**

1. **Òptica - "Cul d'Ampolla"**:
   - Modelar la base de dades per gestionar clients/es, vendes i proveïdors d'ulleres.
   - Inclou informació sobre clients/es, empleats/des, ulleres, marques i vendes.

2. **Pizzeria - Sistema de comandes**:
   - Dissenyar una base de dades per gestionar comandes de menjar a domicili.
   - Inclou informació de clients/es, comandes, productes, categories, botigues i empleats/des.

---
## Bones pràctiques de diseny i nomenclatura 
A falta d'una convenció oficial universalment acceptada, he triat aquestes práctiques per donar consistència al diseny i nomenclatura de les meves bbdd. Tot pot canviar segons vagi avançant en el coneixement de MySQL. Potser algunes pràctiques no estan totalment implementades als exercicis per que s'han anat afegint sobre la marxa:

0. En general: 
    - minúscules, 
    - paraules separades amb guió baix, 
    - s'accepten abreviacions universals en paraules innecessàriament llargues o que s'han de combinar amb un altra paraula (3 sil.labes o més). P.e. tel, dpto, cristal_izdo, cristal_dcho, num_factura, cat, etc.

1. Taules: 
    - singular vs plural. He vist que hi ha debat sobre això. Em decanto per la naturalitat: 
        Taules mestres: pe. mestre de proveïdors, mestre de clients, cataleg de productes. Taules que aglutinen una colecció d'elements amb sentit propi. 
    - noms de taules de transaccions: ventes, matricules, pedidos
    - noms de taules de relacions n:m: 
        - trobar un nom propi prou descriptiu: matricules - ja s'enten que una matricula equival a un alumne-curs (o la unitat de matriculació que operi)
        - si no existeix un nom propi prou precís: fer servir una combinació natural del nom de les dues taules: productos_pedidos, gafas_vendidas (millor que gafas_ventas)


2. Claus primàries: pk
    A) Claus primaries simples: només id. És curt, senzill i no és ambigu. Simplifica queries. Afegir el nom de la taula és redundant.

    B) Claus primàries compostes: quan la pk sigui composta no es crearà una id pk ai addicional (no aporta res), si no que es farà servir una pk composta. En aquests casos, per seguir els standars angloxaxons. el nom serà el nom de la taula on la clau es pk seguit del prefixe _id:
            CREATE TABLE team_member (
                team_id       bigint NOT NULL REFERENCES team(id),
                person_id     bigint NOT NULL REFERENCES person(id),
            CONSTRAINT team_member_pkey PRIMARY KEY (team_id, person_id));

3. Claus foranies: fk
    A) de la columna: 
        1) nom de l'element que identifica (taula font en singular) seguit de _id: 
            producto_id
        
        2) si la taula aplica només a un subconjunt d'items de la taula font, llavors es fa servir el nom del subconjunt.
            pizza_id
    B) A l'apartat foreign keys: fk_aliastaula_nomcolumna:
            fk_producto_id
            fk_pizzas_id 
        
4. Resta de camps: el més descriptiu i simple possible, sense menció a la taula si no aporta info necessària.

5. Indexos: 
    A) en general: prefixe ix_aliastaula_columna:
            ix_c_pizza_pizza_id
        si la taula és associativa y, per tant, amb nomb compost es faran servir els alies de les dues taules que li donen nom:
            ix_ppe_producto_id 

        on ppe = producto_pedido
        sí, es verdad, puede haber una ambigüedad pero es un ejercicio de clase, no ens flipem!
    
    B) indexos creats automaticament per que son unics:
            nombre_UNIQUE

6. Alias: inicial de la taula, si ja está ocupada 2 primeres lletres. Quan hi hagi inicials repetides es detallarà l'alies de les taules amb inicials repetides als comentaris.


## 🛠️ Execució

1. Clona el repositori al teu ordinador:
   
   git clone 
   

2. Importa i executa els fitxers SQL que defineixen les estructures de les bases de dades al teu servidor MySQL.


## 📂 Estructura del repositori
model_relacional_optica.png: Model entitat-relació per a l'òptica.
model_relacional_pizzeria.png: Model entitat-relació per a la pizzeria.
bbdd_optica.sql: Script SQL per crear, poblar i fes les consultes de test de l'òptica.
bbdd_pizzeria.sql: Script SQL per crear, poblar i fes les consultes de test de la pizzeria.
