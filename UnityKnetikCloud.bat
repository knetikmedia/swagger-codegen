@ECHO OFF

SET JSON_FILE=https://sandbox.knetikcloud.com/swagger-doc
SET VERSION_NUMBER=3.0.7

SET ID_FLAGS=--group-id com.knetikcloud --artifact-version %VERSION_NUMBER% -DprojectVersion=%VERSION_NUMBER%

SET MODULES_FOLDER=%~dp0modules
SET UNITY_TEMPLATE_FOLDER=modules\swagger-codegen\src\main\resources\CsharpUnity
SET SDK_FOLDER=%~dp0sdk

SET OUT_FOLDER=%SDK_FOLDER%\knetikcloud-unity
SET UNITY_FOLDER=%OUT_FOLDER%\unity

SET UNITY_ASSETS_FOLDER=%UNITY_FOLDER%\Assets
SET UNITY_THIRD_PARTY_FOLDER=%UNITY_ASSETS_FOLDER%\ThirdParty
SET UNITY_KNETIK_FOLDER=%UNITY_THIRD_PARTY_FOLDER%\KnetikCloud

REM Clean up previous generations
rd /S /Q "%OUT_FOLDER%\"

REM Make folders
mkdir "%SDK_FOLDER%\"
mkdir "%OUT_FOLDER%\"

REM Generate code
java -jar "%MODULES_FOLDER%\swagger-codegen-cli\target\swagger-codegen-cli.jar" generate -i "%JSON_FILE%" -l CsharpUnity -t "%UNITY_TEMPLATE_FOLDER%" -DpackageName="com.knetikcloud" %ID_FLAGS% --artifact-id knetikcloud-csharp-unity-client -o "%OUT_FOLDER%"

mkdir "%UNITY_FOLDER%\"
mkdir "%UNITY_ASSETS_FOLDER%\"
mkdir "%UNITY_THIRD_PARTY_FOLDER%\"
mkdir "%UNITY_KNETIK_FOLDER%\"

REM Copy code to the proper Unity layout
XCOPY "%OUT_FOLDER%\src\main\CsharpUnity\com\knetikcloud\*" "%UNITY_KNETIK_FOLDER%\" /S /Y
rd /S /Q "%OUT_FOLDER%\src\"

REM Remove unneccessary files
del /F "%OUT_FOLDER%\compile-mono.sh"
del /F "%UNITY_KNETIK_FOLDER%\Client\ApiClient.cs"
del /F "%UNITY_KNETIK_FOLDER%\Client\ApiException.cs"
del /F "%UNITY_KNETIK_FOLDER%\Client\Configuration.cs"
