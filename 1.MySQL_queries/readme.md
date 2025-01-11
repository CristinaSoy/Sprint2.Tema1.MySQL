# Sprint 2 - Tema 1 - MySQL

## 📄 Descripció

Aquest repositori conté l primera entrega del Tema 1 del Sprint 2 amb les consultes SQL de les bbdd "tienda" i "universistat" utilitzant bases de dades relacionals. Es treballa amb les bases de dades **"Tienda"** i **"Universidad"**, aplicant diverses operacions com seleccions, conversions i manipulacions de dades.

---

## 💻 Tecnologies Utilitzades

- **MySQL 9.1**
- **Workbench 8.0**

---

## 📋 Exercicis

### **Base de dades "Tienda"**
1. Llistar el nom de tots els productes de la taula `producto`.
2. Llistar els noms i preus de tots els productes de la taula `producto`.
3. Llistar totes les columnes de la taula `producto`.
4. Mostrar el nom dels productes, el preu en euros i el preu en dòlars nord-americans (USD) amb un càlcul (`TC USD/EUR * 1.03`).
5. Mostrar el nom dels productes amb àlies personalitzats: "euros" per al preu en euros i "dòlars nord-americans" per al preu en USD.
6. Mostrar els noms i els preus dels productes convertint els noms a majúscules (`UPPER(nombre)`).
7. Mostrar els noms i els preus dels productes convertint els noms a minúscules (`LOWER(nombre)`).

### **Base de dades "Universidad"**
1. Llistar el primer cognom, segon cognom i nom de tots els alumnes, ordenant-los alfabèticament pel primer cognom, segon cognom i nom.
2. Mostrar el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon.
3. Llistar els alumnes nascuts l'any 1999.
4. [Resta dels consultes específiques segons el fitxer `schema_universidad.sql`].

---
## 📂 Estructura del repositori
A la carpeta *bbdd*: executables per crear les bases de dades
- schema_tienda.sql
- schema_universidad.sql

A la carpeta *consultes*: resolució exercicis
- al fitxer : consultes_tema1_ofuscades.sql

A més a més es presenten les consultes no ofuscades amb enunciats:

- Queries_tienda_1_20.sql: consultes 1 a 20 sobre la base de dades "Tienda".
- Queries_tienda_21_39.sql: consultes 21 a 39 sobre la base de dades "Tienda".

- Queries_universidad.sql: consultes 1 a 9 i 1 a 6 (clàusules LEFT JOIN i RIGHT JOIN)
- Queries_universidad_resumen.sql: consultes d'acregació 1 a 10 amb excepció de la 9.


## 🛠️ Execució

1. Clona el repositori al teu ordinador: https://github.com/CristinaSoy/Sprint2.Tema1.MySQL.git

2. Crea les bases de dades a partir dels fitxers a la carpeta *bbdd*:
"Tienda": importa i executa el fitxer schema_tienda.sql al teu servidor MySQL.
"Universidad": importa i executa el fitxer schema_universidad.sql al teu servidor MySQL.

3. Executa les consultes de la carpeta *consultes* des del MySQL Workbench o terminal.


**Desplegament:** aquest projecte no requereix desplegament a producció, ja que és un conjunt d'exercicis pràctics. 

**Contribucions:** les contribucions són benvingudes! Si tens suggeriments o vols millorar el projecte:
1.Fes un fork d'aquest repositori.
2.Crea una branca per afegir les teves millores
3.Fes un commit amb els teus canvis:
4.Puja els canvis
5.Obre un Pull Request.

