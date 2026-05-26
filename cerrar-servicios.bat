@echo off
title VetNova Backend - Cerrar Servicios

echo ========================================
echo Cerrando microservicios VetNova...
echo ========================================

taskkill /F /FI "WINDOWTITLE eq Auth Service*" /T
taskkill /F /FI "WINDOWTITLE eq Usuario Service*" /T
taskkill /F /FI "WINDOWTITLE eq Mascota Service*" /T
taskkill /F /FI "WINDOWTITLE eq Atencion Service*" /T
taskkill /F /FI "WINDOWTITLE eq Agenda Service*" /T
taskkill /F /FI "WINDOWTITLE eq Ficha Clinica Service*" /T
taskkill /F /FI "WINDOWTITLE eq Catalogo Service*" /T
taskkill /F /FI "WINDOWTITLE eq Inventario Service*" /T
taskkill /F /FI "WINDOWTITLE eq Ventas Service*" /T
taskkill /F /FI "WINDOWTITLE eq Pago Service*" /T
taskkill /F /FI "WINDOWTITLE eq Soporte Service*" /T
taskkill /F /FI "WINDOWTITLE eq Valoracion Service*" /T
taskkill /F /FI "WINDOWTITLE eq Notificacion Service*" /T
taskkill /F /FI "WINDOWTITLE eq Gateway Service*" /T

echo.
echo Servicios y ventanas CMD cerradas.
echo ========================================
pause