
SET SDK_FOLDER=%~dp0sdk\knetikcloud-unreal\
SET DEST_FOLDER=%~dp0..\knetikcloud-unreal-sdk\KnetikCloudSDK\Source\KnetikCloudSDK\api\

cd "%SDK_FOLDER%api\"
xcopy *.cpp "%DEST_FOLDER%" /U
cd %~dp0
