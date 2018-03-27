#!/bin/bash
if [ $# -lt 2 ]; then
  echo "USAGE:  JsapiUnityGenerate.sh swagger_doc_url version_number"
  exit 1
fi

JSON_FILE="$1"
VERSION_NUMBER="$2"
BASE_JAR="modules/swagger-codegen-cli/target/swagger-codegen-cli.jar"
GIT_USERNAME="stoutfiles"
GIT_EMAIL="shawn.stout@knetik.com"
DEV_NAME="Shawn Stout"
DEV_EMAIL="admin@knetikcloud.com"
DEV_ORG="Knetik"
DEV_ORG_URL="knetikcloud.com"
BRANCH="auto_gen2"
BR_2="\n  "
BR_4="\n    "
BR_6="\n      "
POM_ORIGINAL="</scm>"
#POM_REPLACEMENT="</scm>$BR_2<licenses>$BR_4<license>$BR_6<name>The Apache Software License, Version 2.0</name>$BR_6<url>http://www.apache.org/licenses/LICENSE-2.0.txt</url>$BR_4</license>$BR_2</licenses>$BR_2"
POM_REPLACEMENT="</scm>$BR_2<developers>$BR_4<developer>$BR_6<name>$DEV_NAME</name>$BR_6<email>$DEV_EMAIL</email>$BR_6<organization>$DEV_ORG</organization>$BR_6<organizationUrl>$DEV_ORG_URL</organizationUrl>$BR_4</developer>$BR_2</developers>"
README_ORIGINAL="## Getting Started"
README_ORIGINAL_PERL="# GETTING STARTED"
README_REPLACEMENT="## Getting Started \n\n KnetikCloud (JSAPI) uses a strict Oauth 2.0 implementation with the following grant types: \n\n"
README_REPLACEMENT+="* **Password grant**: Used for user authentication, usually from an unsecured web or mobile client when a fully authenticated user account is required to perform actions. ex: \n\n"
README_REPLACEMENT+="\`\`\`curl \nPOST /oauth/token?grant_type=password\&client_id=web\&username=jdoe\&password=68a4sd3sd\n \`\`\` \n\n"
README_REPLACEMENT+="* **Client credentials grant**: \n Used for server authentication or secured clients when the secret key cannot be discovered. This kind of grant is typically used for administrative tasks on the application itself or to access other user's account information. \n\n"
README_REPLACEMENT+="\`\`\`curl \nPOST /oauth/token grant_type=client_credentials\&client_id=server-client-id\&client_secret=1s31dfas65d4f3sa651c3s54f \n\`\`\`  \n\n"
README_REPLACEMENT+="The endpoint will return a response containing the authentication token as follows: \n"
README_REPLACEMENT+="\`\`\`json: \n"
README_REPLACEMENT+="{\"access_token\":\"25a0659c-6f4a-40bd-950e-0ba4af7acf0f\",\"token_type\":\"bearer\",\"expires_in\":2145660769,\"scope\":\"write read\"}\n"
README_REPLACEMENT+="\`\`\` \n\n"
README_REPLACEMENT+="Use the provided access_token in sub-sequent requests to authenticate (see code below). Make sure you refresh your token before it expires to avoid having to re-authenticate."
UNITY_TEMPLATE_FOLDER="modules\swagger-codegen\src\main\resources\CsharpUnity"

ID_FLAGS="--group-id com.knetikcloud --artifact-version $VERSION_NUMBER -DprojectVersion=$VERSION_NUMBER"

SDK_DIR=../../../knetikcloud-unity-sdk
#SDK_DIR=/DEV/splyt/splyt-unity-client

mkdir -p $SDK_DIR
chmod 777 $SDK_DIR
pushd $SDK_DIR
git init
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git remote add origin git@github.com:knetikmedia/knetikcloud-unity-sdk.git
git reset --hard
git clean -f
git checkout $BRANCH
git pull origin $BRANCH
rm -r *
popd

mkdir -p sdk
chmod 777 sdk


#CSharp Unity
rm -rf sdk/csharp-unity
mkdir -p sdk/csharp-unity
chmod 777 sdk/csharp-unity

java -jar $BASE_JAR generate -i $JSON_FILE -l CsharpUnity -t "$UNITY_TEMPLATE_FOLDER" -DpackageName="com.knetikcloud" $ID_FLAGS --artifact-id knetikcloud-unity-client -o sdk/csharp-unity
cd sdk/csharp-unity

sed -i -e 's~'"$README_ORIGINAL"'~'"$README_REPLACEMENT"'~g' README.md

chmod +x ../../JsapiUnityFilesSynch.sh

../../JsapiUnityFilesSynch.sh src/main/CsharpUnity/com/knetikcloud/Api $SDK_DIR/Assets/ThirdParty/KnetikCloud/Api
../../JsapiUnityFilesSynch.sh src/main/CsharpUnity/com/knetikcloud/Model $SDK_DIR/Assets/ThirdParty/KnetikCloud/Model

cp README.md $SDK_DIR/
rm $SDK_DIR/docs/*
cp docs/* $SDK_DIR/docs/
cp vendor/packages.config $SDK_DIR/vendor/packages.config

pushd $SDK_DIR/
git add -A
git commit -m "JSAPI Unity API update"
git push -u origin $BRANCH
popd

cd ../..
