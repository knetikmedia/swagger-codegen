
SET SDK_FOLDER=%~dp0sdk\knetikcloud-unreal\
SET DEST_FOLDER=%~dp0..\knetikcloud-unreal-sdk\KnetikCloudSDK\Source\KnetikCloudSDK\model\

cd "%SDK_FOLDER%model\"
xcopy *.h "%DEST_FOLDER%" /U
cd %~dp0

del /F "%DEST_FOLDER%\Property.h"
del /F "%DEST_FOLDER%\DoubleProperty.h"
del /F "%DEST_FOLDER%\MapProperty.h"
del /F "%DEST_FOLDER%\TextProperty.h"
