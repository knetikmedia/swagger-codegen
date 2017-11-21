@ECHO OFF

SET JSON_FILE=https://api.knetik.io/swagger-doc?group=apiv2
SET VERSION_NUMBER=3.0.7

SET ID_FLAGS=--group-id com.splytanalytics --artifact-version %VERSION_NUMBER% -DprojectVersion=%VERSION_NUMBER%

SET MODULES_FOLDER=%~dp0modules
SET UNITY_TEMPLATE_FOLDER=modules\swagger-codegen\src\main\resources\CsharpUnitySplyt
SET SDK_FOLDER=%~dp0sdk

SET OUT_FOLDER=%SDK_FOLDER%\splytanalytics-unity
SET UNITY_FOLDER=%OUT_FOLDER%\unity
SET VENDOR_FOLDER=%OUT_FOLDER%\vendor

SET UNITY_ASSETS_FOLDER=%UNITY_FOLDER%\Assets
SET UNITY_PLUGIN_FOLDER=%UNITY_ASSETS_FOLDER%\Plugin
SET UNITY_THIRD_PARTY_FOLDER=%UNITY_ASSETS_FOLDER%\ThirdParty
SET UNITY_KNETIK_FOLDER=%UNITY_THIRD_PARTY_FOLDER%\SplytAnalytics

REM Clean up previous generations
rd /S /Q "%OUT_FOLDER%\"

REM Make folders
mkdir "%SDK_FOLDER%\"
mkdir "%OUT_FOLDER%\"

REM Generate code
java -jar "%MODULES_FOLDER%\swagger-codegen-cli\target\swagger-codegen-cli.jar" generate -i "%JSON_FILE%" -l CsharpUnity -t "%UNITY_TEMPLATE_FOLDER%" -DpackageName="com.splytanalytics" %ID_FLAGS% --artifact-id splytanalytics-unity-client -o "%OUT_FOLDER%"

mkdir "%UNITY_FOLDER%\"
mkdir "%UNITY_ASSETS_FOLDER%\"
mkdir "%UNITY_PLUGIN_FOLDER%\"
mkdir "%UNITY_THIRD_PARTY_FOLDER%\"
mkdir "%UNITY_KNETIK_FOLDER%\"

REM Copy code to the proper Unity layout
XCOPY "%OUT_FOLDER%\src\main\CsharpUnity\com\splytanalytics\*" "%UNITY_KNETIK_FOLDER%\" /S /Y
rd /S /Q "%OUT_FOLDER%\src\"

REM Pull required plugins
wget -nc https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
nuget.exe install "%VENDOR_FOLDER%\packages.config" -o "%VENDOR_FOLDER%"

REM Copy plugins to the proper Unity folder
XCOPY "%VENDOR_FOLDER%\RestSharp-Unity-NET-2.0.105.1\lib\net20\RestSharp.dll" "%UNITY_PLUGIN_FOLDER%\" /S /Y
XCOPY "%VENDOR_FOLDER%\Unity.Newtonsoft.Json.7.0.0.0\lib\net35-Client\Unity.Newtonsoft.Json.dll" "%UNITY_PLUGIN_FOLDER%\" /S /Y
rd /S /Q "%VENDOR_FOLDER%\"

REM Remove unneccessary files
del /F "%UNITY_KNETIK_FOLDER%\Client\Configuration.cs"
del /F "%UNITY_KNETIK_FOLDER%\Client\ApiException.cs"

REM Rename the client classes to be more unique within the context of a Unity project
rename "%UNITY_KNETIK_FOLDER%\Client\ApiClient.cs" SplytAnalyticsClient.cs
