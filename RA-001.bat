@echo off
for /f "tokens=2 delims=:." %%x in ('chcp') do set cp=%%x
chcp 1252>nul

setlocal enabledelayedexpansion 
echo Trabajando, espere un momento...
echo a.- Reconocer como Asuntos a los temas especificos que sea de interes del funcionario entrante para consultarlos o continuar con su desarrollo>> "%userprofile%\Desktop\carpetas.csv"
echo b.- Identificar la carpeta que contiene el asunto que desea presentar>> "%userprofile%\Desktop\carpetas.csv"
echo c.- Agregar una fila despues de la ultima carpeta dentro de la identificada>> "%userprofile%\Desktop\carpetas.csv"
echo d.- Sumar todos los valores de la columna A en esa fila nueva desde la de asunto hasta la ultima hija>> "%userprofile%\Desktop\carpetas.csv"
echo e.- Copiar este valor obtenido en la celda A de la fila identificada en el punto a>> "%userprofile%\Desktop\carpetas.csv"
echo f.- Eliminar las filas de las carpetas hijas>> "%userprofile%\Desktop\carpetas.csv"
echo g.- Continuar con el siguiente Asunto.>> "%userprofile%\Desktop\carpetas.csv"
echo '----------------------->> "%userprofile%\Desktop\carpetas.csv"
echo Alexander Melendez 2022>> "%userprofile%\Desktop\carpetas.csv"
echo '----------------------->> "%userprofile%\Desktop\carpetas.csv"

:treeProcess
:treeProcess
echo %~1 
pushd %~1

	set "folder=%~1"
	set "folder=%folder:^=^^%"
	set "folder=%folder:&=^&%"
	set "folder=%folder:(=^(%"
	set "folder=%folder:)=^)%"
	REM set "folder=%folder:,=^,%"
	echo %folder%

	set /A "size=0"
	set "ext="
	set "exts= "
	for /f "delims=" %%a in ('dir /a:a /b') do (
		if not [%%a] == [] (
			REM echo "-------"%%~a
			REM echo "-------"!size!
			REM echo "-------"%%~za
			echo "-------"%%~xa
			set /A "size+=%%~za"
			set ext=%%~xa
			echo !ext!
			set exts=!exts:%%~xa=!
			set "exts=!exts!!ext! "
			echo !exts!
		)
	)
	if not %size% == 0 (
		echo %exts%, %size%,"%~1" >> "%userprofile%\Desktop\carpetas.csv"
	)

	for /f "delims=" %%d in ('dir /a:d /b') do (
		cd "%%~fd"
		call:treeProcess "%%~fd"
		cd ..
	)
	popd
	goto:eof

chcp %cp%>nul
