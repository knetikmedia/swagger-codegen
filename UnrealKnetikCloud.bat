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
del /F "%OUT_FOLDER%\KnetikCloudApiClient.cpp"
del /F "%OUT_FOLDER%\KnetikCloudApiClient.h"
del /F "%OUT_FOLDER%\KnetikCloudApiConfiguration.cpp"
del /F "%OUT_FOLDER%\KnetikCloudApiConfiguration.h"
del /F "%OUT_FOLDER%\KnetikCloudApiException.cpp"
del /F "%OUT_FOLDER%\KnetikCloudApiException.h" 
del /F "%OUT_FOLDER%\KnetikCloudHttpContent.cpp"
del /F "%OUT_FOLDER%\KnetikCloudHttpContent.h"
del /F "%OUT_FOLDER%\KnetikCloudIHttpBody.h"
del /F "%OUT_FOLDER%\KnetikCloudJsonBody.cpp"
del /F "%OUT_FOLDER%\KnetikCloudJsonBody.h"
del /F "%OUT_FOLDER%\KnetikCloudModelBase.cpp"
del /F "%OUT_FOLDER%\KnetikCloudModelBase.h"
del /F "%OUT_FOLDER%\KnetikCloudMultipartFormData.cpp"
del /F "%OUT_FOLDER%\KnetikCloudMultipartFormData.h"
