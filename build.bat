@ECHO OFF 
IF "%1"=="" ( SET "folder=%1" ) ELSE ( SET "folder=%1" )
IF "%2"=="" ( SET "ver=1.0" ) ELSE ( SET "ver=%2" )
 
rem master pom
copy pom.txt pom.xml
copy cpom.txt %folder%\pom.xml
rem copy feature files
mkdir %folder%.feature
copy feature\category.txt feature\category.xml
copy feature\feature.txt feature\feature.xml
copy feature\pom.txt feature\pom.xml
move feature\*.xml %folder%.feature\
copy feature\build.properties %folder%.feature\build.properties
copy %folder%\META-INF\MANIFEST.txt %folder%\META-INF\MANIFEST.MF /Y
rem backup site
mkdir updatesite
copy site\category.txt site\category.xml
copy site\pom.txt site\pom.xml
move site\*.xml updatesite\
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dpn0.ps1' -compID %folder% -version %ver%"
mvn clean install