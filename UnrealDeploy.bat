
SET SDK_FOLDER=%~dp0sdk\knetikcloud-unreal
SET DEST_FOLDER=%~dp0..\knetikcloud-unreal-sdk\KnetikCloudSDK\Source\KnetikCloudSDK

cd "%SDK_FOLDER%\api\"
xcopy *.* "%DEST_FOLDER%\api" /U

cd "%SDK_FOLDER%\model\"
xcopy *.* "%DEST_FOLDER%\model" /U

cd %~dp0
