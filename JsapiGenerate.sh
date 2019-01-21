#!/bin/bash
if [ $# -lt 2 ]; then
  echo "USAGE:  JsapiGenerate.sh swagger_doc_url version_number"
  exit 1
fi

JSON_FILE="$1"
VERSION_NUMBER="$2"
BASE_JAR="modules/swagger-codegen-cli/target/swagger-codegen-cli.jar"
GIT_USERNAME="Tyler Novotny"
GIT_EMAIL="tyler@knetik.com"
DEV_NAME="Tyler Novotny"
DEV_EMAIL="admin@knetikcloud.com"
DEV_ORG="Knetik"
DEV_ORG_URL="knetikcloud.com"
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

ID_FLAGS="--group-id com.knetikcloud --artifact-version $VERSION_NUMBER -DprojectVersion=$VERSION_NUMBER"

mkdir -p sdk
chmod 777 sdk

#Android
mkdir -p sdk/android
chmod 777 sdk/android
cd sdk/android

git init
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git remote add origin git@github.com:knetikcloud/knetikcloud-android-client.git
git pull origin master
rm -r *

cd ../..
java -jar $BASE_JAR generate -i $JSON_FILE -DinvokerPackage="com.knetikcloud.client",modelPackage="com.knetikcloud.model",apiPackage="com.knetikcloud.api" -l java $ID_FLAGS --artifact-id knetikcloud-android-client --library=retrofit2 -o sdk/android
cd sdk/android

sed -i -e 's~'"$README_ORIGINAL"'~'"$README_REPLACEMENT"'~g' README.md

git add -A
git commit -m "JSAPI Android API update"
git push -u origin master
cd ../..

#Java
mkdir -p sdk/java
chmod 777 sdk/java
cd sdk/java

git init
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git remote add origin git@github.com:knetikcloud/knetikcloud-java-client.git
git pull origin master
rm -r *

cd ../..
java -jar $BASE_JAR generate -i $JSON_FILE -DinvokerPackage="com.knetikcloud.client",modelPackage="com.knetikcloud.model",apiPackage="com.knetikcloud.api" -l java $ID_FLAGS --artifact-id knetikcloud-java-client --library jersey2 -o sdk/java
cd sdk/java

sed -i -e 's~'"$README_ORIGINAL"'~'"$README_REPLACEMENT"'~g' README.md

git add -A
git commit -m "JSAPI Java API update"
git push -u origin master
cd ../..

#Javascript
mkdir -p sdk/javascript
chmod 777 sdk/javascript
cd sdk/javascript

git init
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git remote add origin git@github.com:knetikcloud/knetikcloud-javascript-client.git
git pull origin master
rm -r *

cd ../..
java -jar $BASE_JAR generate -i $JSON_FILE -l javascript -c jsapi.javascript.config.json $ID_FLAGS --artifact-id knetikcloud-javascript-client -o sdk/javascript
cd sdk/javascript

sed -i -e 's~'"$README_ORIGINAL"'~'"$README_REPLACEMENT"'~g' README.md

git add -A
git commit -m "JSAPI Javascript API update"
git push -u origin master
cd ../..

#Objective C	
mkdir -p sdk/objc	
chmod 777 sdk/objc	
cd sdk/objc	
	
git init	
git config user.name "$GIT_USERNAME"	
git config user.email "$GIT_EMAIL"	
git remote add origin git@github.com:knetikcloud/knetikcloud-objc-client.git	
git pull origin master	
rm -r *	
	
cd ../..	
java -jar $BASE_JAR generate -i $JSON_FILE -l objc -DpodName="JSAPI",classPrefix="JSAPI",gitRepoUrl="https://github.com/knetikcloud/knetikcloud-objc-client" $ID_FLAGS --artifact-id knetikcloud-objc-client -o sdk/objc	
cd sdk/objc	
	
sed -i -e 's~'"$README_ORIGINAL"'~'"$README_REPLACEMENT"'~g' README.md	
	
git add -A	
git commit -m "JSAPI Objective C API update"	
git push -u origin master	
cd ../..

#Typescript-Angular2
mkdir -p sdk/typescript-angular2
chmod 777 sdk/typescript-angular2
cd sdk/typescript-angular2

git init
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git remote add origin git@github.com:knetikmedia/knetikcloud-typescript-angular2-client.git
git pull origin master
rm -r *

cd ../..
java -jar $BASE_JAR generate -i $JSON_FILE -l typescript-angular $ID_FLAGS --artifact-id knetikcloud-typescript-angular2-client -o sdk/typescript-angular2
cd sdk/typescript-angular2

git add -A
git commit -m "JSAPI Typescript-Angular2 API update"
git push -u origin master
cd ../..