@ECHO OFF
rem master pom
copy pom.txt pom.xml
copy cpom.txt %1\pom.xml
rem copy feature files
mkdir %1.feature
copy feature\category.txt feature\category.xml
copy feature\feature.txt feature\feature.xml
copy feature\pom.txt feature\pom.xml
move feature\*.xml %1.feature\
copy feature\build.properties %1.feature\build.properties
copy %1\META-INF\MANIFEST.txt %1\META-INF\MANIFEST.MF /Y
rem backup site
mkdir updatesite
copy site\category.txt site\category.xml
copy site\pom.txt site\pom.xml
move site\*.xml updatesite\
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dpn0.ps1' -compID %1 -version %2"
mvn clean install
copy updatesite\target\Suite-%2.0.zip Suite-%2.0.zip