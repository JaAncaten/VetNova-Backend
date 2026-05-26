@echo off
title VetNova Backend - Iniciar Servicios

echo ========================================
echo Iniciando microservicios VetNova...
echo ========================================

start "Auth Service" cmd /k "cd /d %~dp0AuthService\vetnova-auth-service && mvnw.cmd spring-boot:run"

start "Usuario Service" cmd /k "cd /d %~dp0Usuario_Service\vetnova-usuario-service\vetnova-usuario-service && mvnw.cmd spring-boot:run"

start "Mascota Service" cmd /k "cd /d %~dp0Mascota_Service\vetnova-mascota-service\vetnova-mascota-service && mvnw.cmd spring-boot:run"

start "Atencion Service" cmd /k "cd /d %~dp0Atencion_Service\vetnova-atencion-service\vetnova-atencion-service && mvnw.cmd spring-boot:run"

start "Agenda Service" cmd /k "cd /d %~dp0Agenda_Service\vetnova-agenda-service\vetnova-agenda-service && mvnw.cmd spring-boot:run"

start "Ficha Clinica Service" cmd /k "cd /d %~dp0FichaClinica-Service\vetnova-fichaclinica-service\vetnova-fichaclinica-service && mvnw.cmd spring-boot:run"

start "Catalogo Service" cmd /k "cd /d %~dp0Catalogo-Service\vetnova-catalogo-service\vetnova-catalogo-service && mvnw.cmd spring-boot:run"

start "Inventario Service" cmd /k "cd /d %~dp0VetNova-Inventario\vetnova-inventario-service\vetnova-inventario-service && mvnw.cmd spring-boot:run"

start "Ventas Service" cmd /k "cd /d %~dp0Venta-Service\vetnova-ventas-service\vetnova-ventas-service && mvnw.cmd spring-boot:run"

start "Pago Service" cmd /k "cd /d %~dp0Pago-Service\vetnova-pago-service\vetnova-pago-service && mvnw.cmd spring-boot:run"

start "Soporte Service" cmd /k "cd /d %~dp0Soporte-Service\vetnova-soporte-service\vetnova-soporte-service && mvnw.cmd spring-boot:run"

start "Valoracion Service" cmd /k "cd /d %~dp0Valoracion-Service\vetnova-valoracion-service\vetnova-valoracion-service && mvnw.cmd spring-boot:run"

start "Notificacion Service" cmd /k "cd /d %~dp0Notificacion-Service\vetnova-notificacion-service\vetnova-notificacion-service && mvnw.cmd spring-boot:run"

echo.
echo Esperando 20 segundos antes de iniciar el Gateway...
timeout /t 20 /nobreak

start "Gateway Service" cmd /k "cd /d %~dp0VetNova-API\vetnova-gateway-service\vetnova-gateway-service && mvnw.cmd spring-boot:run"

echo.
echo ========================================
echo Servicios iniciandose...
echo ========================================
pause