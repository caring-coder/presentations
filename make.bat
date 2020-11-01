@echo off

echo.== found ==
dir /b src
echo.

for /f %%G in ('dir /b src') do @(
	echo.== treating %%G ==
	if not exist "target\%%G\" (
		mkdir "target\%%G"
	)
	
	if exist "externals\" (
		xcopy /E /Y externals "target\%%G" > NUL
	)
	
	bundle exec asciidoctor-revealjs "src\%%G"\presentation.adoc -D "target\%%G" --out-file presentation.html

	if exist "target\%%G\assets\" (
		xcopy /e /q /y "src\%%G\assets" "target\%%G\assets\"
	)
)