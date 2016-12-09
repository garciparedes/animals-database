#!/bin/bash

#
# Descrition: Merge all sql files into master.sql.
#
# Author:   Sergio García Prado
#           garciparedes.me
#

tables='definitions/tables/'
views='definitions/views/'
populations='populations/'
queries='queries/'


echo
echo '/*'
echo 'PRACTICA ANALISIS Y DISENO DE BASE DE DATOS: ANIMALES'
echo
echo 'AUTORES:'
echo 'SERGIO GARCIA PRADO (garciparedes.me)'
echo 'FERNANDO URBON DOMINGUEZ'
echo 'SERGIO MUNOZ GOZALO'
echo '*/'
echo

echo
echo '/*'
echo 'DROP DE ANTIGUAS TABLAS'
echo '*/'
echo


cat 'drop.sql'
echo
echo


echo
echo '/*'
echo 'DEFINICION DE TABLAS'
echo '*/'
echo


cat ${tables}'animal.sql'
echo
echo
cat ${tables}'animal_censado.sql'
echo
echo
cat ${tables}'vacuna.sql'
echo
echo
cat ${tables}'responsable.sql'
echo
echo
cat ${tables}'persona.sql'
echo
echo
cat ${tables}'organizacion.sql'
echo
echo
cat ${tables}'licencia.sql'
echo
echo
cat ${tables}'propiedad.sql'
echo
echo
cat ${tables}'incidencia.sql'
echo
echo



echo
echo '/*'
echo 'DEFINICION DE VISTAS'
echo '*/'
echo

cat ${views}'view_animal_censado.sql'
echo
echo

cat ${views}'view_organizacion.sql'
echo
echo

cat ${views}'view_persona.sql'
echo
echo

cat ${views}'view_infraccion.sql'
echo
echo

cat ${views}'view_perdida.sql'
echo
echo

cat ${views}'view_robo.sql'
echo
echo

cat ${views}'view_animal_potencialmente_peligroso.sql'
echo
echo

cat ${views}'view_ficha_censo.sql'
echo
echo



echo
echo '/*'
echo 'POBLACION DE TABLAS'
echo '*/'
echo

cat ${populations}'animal.sql'
echo
echo
cat ${populations}'animal_censado.sql'
echo
echo
cat ${populations}'vacuna.sql'
echo
echo
cat ${populations}'persona.sql'
echo
echo
cat ${populations}'organizacion.sql'
echo
echo
cat ${populations}'licencia.sql'
echo
echo
cat ${populations}'propiedad.sql'
echo
echo
cat ${populations}'incidencia.sql'
echo
echo


echo
echo '/*'
echo 'CONSULTAS'
echo '*/'
echo

cat ${queries}'query-01.sql'
echo
echo
cat ${queries}'query-02.sql'
echo
echo
cat ${queries}'query-03.sql'
echo
echo
cat ${queries}'query-04.sql'
echo
echo
cat ${queries}'query-05.sql'
echo
echo
cat ${queries}'query-06.sql'
echo
echo
cat ${queries}'query-07.sql'
echo
echo
cat ${queries}'query-08.sql'
echo
echo
cat ${queries}'query-09.sql'
echo
echo
cat ${queries}'query-10.sql'
echo
echo
cat ${queries}'query-11.sql'
echo
echo
cat ${queries}'query-12.sql'
echo
echo
