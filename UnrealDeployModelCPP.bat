
SET SDK_FOLDER=%~dp0sdk\knetikcloud-unreal\
SET DEST_FOLDER=%~dp0..\knetikcloud-unreal-sdk\KnetikCloudSDK\Source\KnetikCloudSDK\model\

cd "%SDK_FOLDER%model\"
xcopy *.cpp "%DEST_FOLDER%" /U
cd %~dp0

del /F "%DEST_FOLDER%\Property.cpp"
del /F "%DEST_FOLDER%\DoubleProperty.cpp"
del /F "%DEST_FOLDER%\MapProperty.cpp"
del /F "%DEST_FOLDER%\TextProperty.cpp"
