@ECHO OFF

SET JSON_FILE=https://sandbox.knetikcloud.com/swagger-doc
SET VERSION_NUMBER=3.0.7

SET ID_FLAGS=--group-id com.knetikcloud --artifact-version %VERSION_NUMBER% -DprojectVersion=%VERSION_NUMBER%

SET MODULES_FOLDER=%~dp0modules
SET TEMPLATE_FOLDER=modules\swagger-codegen\src\main\resources\cppUnreal
SET SDK_FOLDER=%~dp0sdk

SET OUT_FOLDER=%SDK_FOLDER%\knetikcloud-unreal
SET UNREAL_FOLDER=%OUT_FOLDER%\Unreal

REM Clean up previous generations
rd /S /Q "%OUT_FOLDER%\"

REM Make folders
mkdir "%SDK_FOLDER%\"
mkdir "%OUT_FOLDER%\"

REM Generate code
java -jar "%MODULES_FOLDER%\swagger-codegen-cli\target\swagger-codegen-cli.jar" generate -i "%JSON_FILE%" -l cppunreal  -t "%TEMPLATE_FOLDER%" -DpackageName="com.knetikcloud" %ID_FLAGS% --artifact-id knetikcloud-cpp-unreal-client -o "%OUT_FOLDER%"

REM Remove unneccessary files
del /F "%OUT_FOLDER%\.swagger-codegen-ignore"
del /F "%OUT_FOLDER%\ApiClient.cpp"
del /F "%OUT_FOLDER%\ApiClient.h"
del /F "%OUT_FOLDER%\ApiConfiguration.cpp"
del /F "%OUT_FOLDER%\ApiConfiguration.h"
del /F "%OUT_FOLDER%\ApiException.cpp"
del /F "%OUT_FOLDER%\ApiException.h" 
del /F "%OUT_FOLDER%\HttpContent.cpp"
del /F "%OUT_FOLDER%\HttpContent.h"
del /F "%OUT_FOLDER%\IHttpBody.h"
del /F "%OUT_FOLDER%\JsonBody.cpp"
del /F "%OUT_FOLDER%\JsonBody.h"
del /F "%OUT_FOLDER%\ModelBase.cpp"
del /F "%OUT_FOLDER%\ModelBase.h"
del /F "%OUT_FOLDER%\MultipartFormData.cpp"
del /F "%OUT_FOLDER%\MultipartFormData.h"
