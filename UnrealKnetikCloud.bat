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
java -jar "%MODULES_FOLDER%\swagger-codegen-cli\target\swagger-codegen-cli.jar" generate -i "%JSON_FILE%" -l cpprest -t "%TEMPLATE_FOLDER%" -DpackageName="com.knetikcloud" %ID_FLAGS% --artifact-id knetikcloud-cpp-unreal-client -o "%OUT_FOLDER%"

REM Remove unneccessary files
del /F "%OUT_FOLDER%\.gitignore"
del /F "%OUT_FOLDER%\.swagger-codegen-ignore"
del /F "%OUT_FOLDER%\ApiClient.cpp"
del /F "%OUT_FOLDER%\ApiClient.h"
del /F "%OUT_FOLDER%\ApiConfiguration.cpp"
del /F "%OUT_FOLDER%\ApiConfiguration.h"
del /F "%OUT_FOLDER%\ApiException.cpp"
del /F "%OUT_FOLDER%\ApiException.h" 
del /F "%OUT_FOLDER%\CMakeLists.txt"
del /F "%OUT_FOLDER%\git_push.sh"
del /F "%OUT_FOLDER%\HttpContent.cpp"
del /F "%OUT_FOLDER%\HttpContent.h"
del /F "%OUT_FOLDER%\IHttpBody.h"
del /F "%OUT_FOLDER%\JsonBody.cpp"
del /F "%OUT_FOLDER%\JsonBody.h"
del /F "%OUT_FOLDER%\ModelBase.cpp"
del /F "%OUT_FOLDER%\ModelBase.h"
del /F "%OUT_FOLDER%\MultipartFormData.cpp"
del /F "%OUT_FOLDER%\MultipartFormData.h"

REM rename classes to be more appropriate 

REM HACK -> FIX THIS IN THE TEMPLATE GENERATION.  Rename files to have valid names
rename "%OUT_FOLDER%\model\ActionContext?object?.cpp" "ActionContextObject.cpp"
rename "%OUT_FOLDER%\model\ActionContext?object?.h" "ActionContextObject.h"

rename "%OUT_FOLDER%\model\Expression?object?.cpp" "ExpressionObject.cpp"
rename "%OUT_FOLDER%\model\Expression?object?.h" "ExpressionObject.h"

rename "%OUT_FOLDER%\model\KeyValuePair?string,string?.cpp" "KeyValuePairStringString.cpp"
rename "%OUT_FOLDER%\model\KeyValuePair?string,string?.h" "KeyValuePairStringString.h"

rename "%OUT_FOLDER%\model\PageResource?AchievementDefinitionResource?.cpp" "PageResourceAchievementDefinitionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?AchievementDefinitionResource?.h" "PageResourceAchievementDefinitionResource.h"

rename "%OUT_FOLDER%\model\PageResource?AggregateCountResource?.cpp" "PageResourceAggregateCountResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?AggregateCountResource?.h" "PageResourceAggregateCountResource.h"

rename "%OUT_FOLDER%\model\PageResource?AggregateInvoiceReportResource?.cpp" "PageResourceAggregateInvoiceReportResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?AggregateInvoiceReportResource?.h" "PageResourceAggregateInvoiceReportResource.h"

rename "%OUT_FOLDER%\model\PageResource?ActivityOccurrenceResource?.cpp" "PageResourceActivityOccurrenceResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ActivityOccurrenceResource?.h" "PageResourceActivityOccurrenceResource.h"

rename "%OUT_FOLDER%\model\PageResource?ArticleResource?.cpp" "PageResourceArticleResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ArticleResource?.h" "PageResourceArticleResource.h"

rename "%OUT_FOLDER%\model\PageResource?ArtistResource?.cpp" "PageResourceArtistResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ArtistResource?.h" "PageResourceArtistResource.h"

rename "%OUT_FOLDER%\model\PageResource?BareActivityResource?.cpp" "PageResourceBareActivityResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?BareActivityResource?.h" "PageResourceBareActivityResource.h"

rename "%OUT_FOLDER%\model\PageResource?BareChallengeActivityResource?.cpp" "PageResourceBareChallengeActivityResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?BareChallengeActivityResource?.h" "PageResourceBareChallengeActivityResource.h"

rename "%OUT_FOLDER%\model\PageResource?BillingReport?.cpp" "PageResourceBillingReport.cpp"
rename "%OUT_FOLDER%\model\PageResource?BillingReport?.h" "PageResourceBillingReport.h"

rename "%OUT_FOLDER%\model\PageResource?BreCategoryResource?.cpp" "PageResourceBreCategoryResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?BreCategoryResource?.h" "PageResourceBreCategoryResource.h"

rename "%OUT_FOLDER%\model\PageResource?BreEventLog?.cpp" "PageResourceBreEventLog.cpp"
rename "%OUT_FOLDER%\model\PageResource?BreEventLog?.h" "PageResourceBreEventLog.h"

rename "%OUT_FOLDER%\model\PageResource?BreGlobalResource?.cpp" "PageResourceBreGlobalResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?BreGlobalResource?.h" "PageResourceBreGlobalResource.h"

rename "%OUT_FOLDER%\model\PageResource?BreRule?.cpp" "PageResourceBreRule.cpp"
rename "%OUT_FOLDER%\model\PageResource?BreRule?.h" "PageResourceBreRule.h"

rename "%OUT_FOLDER%\model\PageResource?BreTriggerResource?.cpp" "PageResourceBreTriggerResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?BreTriggerResource?.h" "PageResourceBreTriggerResource.h"

rename "%OUT_FOLDER%\model\PageResource?CampaignResource?.cpp" "PageResourceCampaignResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?CampaignResource?.h" "PageResourceCampaignResource.h"

rename "%OUT_FOLDER%\model\PageResource?CartSummary?.cpp" "PageResourceCartSummary.cpp"
rename "%OUT_FOLDER%\model\PageResource?CartSummary?.h" "PageResourceCartSummary.h"

rename "%OUT_FOLDER%\model\PageResource?CatalogSale?.cpp" "PageResourceCatalogSale.cpp"
rename "%OUT_FOLDER%\model\PageResource?CatalogSale?.h" "PageResourceCatalogSale.h"

rename "%OUT_FOLDER%\model\PageResource?CategoryResource?.cpp" "PageResourceCategoryResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?CategoryResource?.h" "PageResourceCategoryResource.h"

rename "%OUT_FOLDER%\model\PageResource?ChallengeEventParticipantResource?.cpp" "PageResourceChallengeEventParticipantResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ChallengeEventParticipantResource?.h" "PageResourceChallengeEventParticipantResource.h"

rename "%OUT_FOLDER%\model\PageResource?ChallengeEventResource?.cpp" "PageResourceChallengeEventResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ChallengeEventResource?.h" "PageResourceChallengeEventResource.h"

rename "%OUT_FOLDER%\model\PageResource?ChallengeResource?.cpp" "PageResourceChallengeResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ChallengeResource?.h" "PageResourceChallengeResource.h"

rename "%OUT_FOLDER%\model\PageResource?ChatMessageResource?.cpp" "PageResourceChatMessageResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ChatMessageResource?.h" "PageResourceChatMessageResource.h"

rename "%OUT_FOLDER%\model\PageResource?ChatUserThreadResource?.cpp" "PageResourceChatUserThreadResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ChatUserThreadResource?.h" "PageResourceChatUserThreadResource.h"

rename "%OUT_FOLDER%\model\PageResource?ClientResource?.cpp" "PageResourceClientResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ClientResource?.h" "PageResourceClientResource.h"

rename "%OUT_FOLDER%\model\PageResource?CommentResource?.cpp" "PageResourceCommentResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?CommentResource?.h" "PageResourceCommentResource.h"

rename "%OUT_FOLDER%\model\PageResource?Config?.cpp" "PageResourceConfig.cpp"
rename "%OUT_FOLDER%\model\PageResource?Config?.h" "PageResourceConfig.h"

rename "%OUT_FOLDER%\model\PageResource?CountryTaxResource?.cpp" "PageResourceCountryTaxResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?CountryTaxResource?.h" "PageResourceCountryTaxResource.h"

rename "%OUT_FOLDER%\model\PageResource?CurrencyResource?.cpp" "PageResourceCurrencyResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?CurrencyResource?.h" "PageResourceCurrencyResource.h"

rename "%OUT_FOLDER%\model\PageResource?DeviceResource?.cpp" "PageResourceDeviceResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?DeviceResource?.h" "PageResourceDeviceResource.h"

rename "%OUT_FOLDER%\model\PageResource?DispositionResource?.cpp" "PageResourceDispositionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?DispositionResource?.h" "PageResourceDispositionResource.h"

rename "%OUT_FOLDER%\model\PageResource?EntitlementItem?.cpp" "PageResourceEntitlementItem.cpp"
rename "%OUT_FOLDER%\model\PageResource?EntitlementItem?.h" "PageResourceEntitlementItem.h"

rename "%OUT_FOLDER%\model\PageResource?FlagReportResource?.cpp" "PageResourceFlagReportResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?FlagReportResource?.h" "PageResourceFlagReportResource.h"

rename "%OUT_FOLDER%\model\PageResource?FlagResource?.cpp" "PageResourceFlagResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?FlagResource?.h" "PageResourceFlagResource.h"

rename "%OUT_FOLDER%\model\PageResource?ForwardLog?.cpp" "PageResourceForwardLog.cpp"
rename "%OUT_FOLDER%\model\PageResource?ForwardLog?.h" "PageResourceForwardLog.h"

rename "%OUT_FOLDER%\model\PageResource?FulfillmentType?.cpp" "PageResourceFulfillmentType.cpp"
rename "%OUT_FOLDER%\model\PageResource?FulfillmentType?.h" "PageResourceFulfillmentType.h"

rename "%OUT_FOLDER%\model\PageResource?GroupMemberResource?.cpp" "PageResourceGroupMemberResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?GroupMemberResource?.h" "PageResourceGroupMemberResource.h"

rename "%OUT_FOLDER%\model\PageResource?GroupResource?.cpp" "PageResourceGroupResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?GroupResource?.h" "PageResourceGroupResource.h"

rename "%OUT_FOLDER%\model\PageResource?ImportJobResource?.cpp" "PageResourceImportJobResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ImportJobResource?.h" "PageResourceImportJobResource.h"

rename "%OUT_FOLDER%\model\PageResource?InvoiceLogEntry?.cpp" "PageResourceInvoiceLogEntry.cpp"
rename "%OUT_FOLDER%\model\PageResource?InvoiceLogEntry?.h" "PageResourceInvoiceLogEntry.h"

rename "%OUT_FOLDER%\model\PageResource?InvoiceResource?.cpp" "PageResourceInvoiceResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?InvoiceResource?.h" "PageResourceInvoiceResource.h"

rename "%OUT_FOLDER%\model\PageResource?ItemTemplateResource?.cpp" "PageResourceItemTemplateResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ItemTemplateResource?.h" "PageResourceItemTemplateResource.h"

rename "%OUT_FOLDER%\model\PageResource?LevelingResource?.cpp" "PageResourceLevelingResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?LevelingResource?.h" "PageResourceLevelingResource.h"

rename "%OUT_FOLDER%\model\PageResource?LocationLogResource?.cpp" "PageResourceLocationLogResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?LocationLogResource?.h" "PageResourceLocationLogResource.h"

rename "%OUT_FOLDER%\model\PageResource?MessageTemplateResource?.cpp" "PageResourceMessageTemplateResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?MessageTemplateResource?.h" "PageResourceMessageTemplateResource.h"

rename "%OUT_FOLDER%\model\PageResource?NotificationTypeResource?.cpp" "PageResourceNotificationTypeResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?NotificationTypeResource?.h" "PageResourceNotificationTypeResource.h"

rename "%OUT_FOLDER%\model\PageResource?NotificationUserTypeResource?.cpp" "PageResourceNotificationUserTypeResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?NotificationUserTypeResource?.h" "PageResourceNotificationUserTypeResource.h"

rename "%OUT_FOLDER%\model\PageResource?OauthAccessTokenResource?.cpp" "PageResourceOauthAccessTokenResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?OauthAccessTokenResource?.h" "PageResourceOauthAccessTokenResource.h"

rename "%OUT_FOLDER%\model\PageResource?ObjectResource?.cpp" "PageResourceObjectResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?ObjectResource?.h" "PageResourceObjectResource.h"

rename "%OUT_FOLDER%\model\PageResource?PaymentMethodTypeResource?.cpp" "PageResourcePaymentMethodTypeResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?PaymentMethodTypeResource?.h" "PageResourcePaymentMethodTypeResource.h"

rename "%OUT_FOLDER%\model\PageResource?PermissionResource?.cpp" "PageResourcePermissionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?PermissionResource?.h" "PageResourcePermissionResource.h"

rename "%OUT_FOLDER%\model\PageResource?PollResource?.cpp" "PageResourcePollResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?PollResource?.h" "PageResourcePollResource.h"

rename "%OUT_FOLDER%\model\PageResource?QuestionResource?.cpp" "PageResourceQuestionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?QuestionResource?.h" "PageResourceQuestionResource.h"

rename "%OUT_FOLDER%\model\PageResource?QuestionTemplateResource?.cpp" "PageResourceQuestionTemplateResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?QuestionTemplateResource?.h" "PageResourceQuestionTemplateResource.h"

rename "%OUT_FOLDER%\model\PageResource?RevenueCountryReportResource?.cpp" "PageResourceRevenueCountryReportResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?RevenueCountryReportResource?.h" "PageResourceRevenueCountryReportResource.h"

rename "%OUT_FOLDER%\model\PageResource?RevenueProductReportResource?.cpp" "PageResourceRevenueProductReportResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?RevenueProductReportResource?.h" "PageResourceRevenueProductReportResource.h"

rename "%OUT_FOLDER%\model\PageResource?RewardSetResource?.cpp" "PageResourceRewardSetResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?RewardSetResource?.h" "PageResourceRewardSetResource.h"

rename "%OUT_FOLDER%\model\PageResource?RoleResource?.cpp" "PageResourceRoleResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?RoleResource?.h" "PageResourceRoleResource.h"

rename "%OUT_FOLDER%\model\PageResource?SavedAddressResource?.cpp" "PageResourceSavedAddressResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?SavedAddressResource?.h" "PageResourceSavedAddressResource.h"

rename "%OUT_FOLDER%\model\PageResource?SimpleReferenceResource?object??.cpp" "PageResourceSimpleReferenceResourceObject.cpp"
rename "%OUT_FOLDER%\model\PageResource?SimpleReferenceResource?object??.h" "PageResourceSimpleReferenceResourceObject.h"

rename "%OUT_FOLDER%\model\PageResource?SimpleUserResource?.cpp" "PageResourceSimpleUserResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?SimpleUserResource?.h" "PageResourceSimpleUserResource.h"

rename "%OUT_FOLDER%\model\PageResource?SimpleWallet?.cpp" "PageResourceSimpleWallet.cpp"
rename "%OUT_FOLDER%\model\PageResource?SimpleWallet?.h" "PageResourceSimpleWallet.h"

rename "%OUT_FOLDER%\model\PageResource?StateTaxResource?.cpp" "PageResourceStateTaxResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?StateTaxResource?.h" "PageResourceStateTaxResource.h"

rename "%OUT_FOLDER%\model\PageResource?StoreItem?.cpp" "PageResourceStoreItem.cpp"
rename "%OUT_FOLDER%\model\PageResource?StoreItem?.h" "PageResourceStoreItem.h"

rename "%OUT_FOLDER%\model\PageResource?StoreItemTemplateResource?.cpp" "PageResourceStoreItemTemplateResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?StoreItemTemplateResource?.h" "PageResourceStoreItemTemplateResource.h"

rename "%OUT_FOLDER%\model\PageResource?string?.cpp" "PageResourceString.cpp"
rename "%OUT_FOLDER%\model\PageResource?string?.h" "PageResourceString.h"

rename "%OUT_FOLDER%\model\PageResource?SubscriptionResource?.cpp" "PageResourceSubscriptionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?SubscriptionResource?.h" "PageResourceSubscriptionResource.h"

rename "%OUT_FOLDER%\model\PageResource?SubscriptionTemplateResource?.cpp" "PageResourceSubscriptionTemplateResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?SubscriptionTemplateResource?.h" "PageResourceSubscriptionTemplateResource.h"

rename "%OUT_FOLDER%\model\PageResource?TemplateResource?.cpp" "PageResourceTemplateResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?TemplateResource?.h" "PageResourceTemplateResource.h"

rename "%OUT_FOLDER%\model\PageResource?TopicResource?.cpp" "PageResourceTopicResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?TopicResource?.h" "PageResourceTopicResource.h"

rename "%OUT_FOLDER%\model\PageResource?TopicSubscriberResource?.cpp" "PageResourceTopicSubscriberResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?TopicSubscriberResource?.h" "PageResourceTopicSubscriberResource.h"

rename "%OUT_FOLDER%\model\PageResource?TransactionResource?.cpp" "PageResourceTransactionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?TransactionResource?.h" "PageResourceTransactionResource.h"

rename "%OUT_FOLDER%\model\PageResource?UsageInfo?.cpp" "PageResourceUsageInfo.cpp"
rename "%OUT_FOLDER%\model\PageResource?UsageInfo?.h" "PageResourceUsageInfo.h"

rename "%OUT_FOLDER%\model\PageResource?UserAchievementGroupResource?.cpp" "PageResourceUserAchievementGroupResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserAchievementGroupResource?.h" "PageResourceUserAchievementGroupResource.h"

rename "%OUT_FOLDER%\model\PageResource?UserActionLog?.cpp" "PageResourceUserActionLog.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserActionLog?.h" "PageResourceUserActionLog.h"

rename "%OUT_FOLDER%\model\PageResource?UserBaseResource?.cpp" "PageResourceUserBaseResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserBaseResource?.h" "PageResourceUserBaseResource.h"

rename "%OUT_FOLDER%\model\PageResource?UserInventoryResource?.cpp" "PageResourceUserInventoryResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserInventoryResource?.h" "PageResourceUserInventoryResource.h"

rename "%OUT_FOLDER%\model\PageResource?UserItemLogResource?.cpp" "PageResourceUserItemLogResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserItemLogResource?.h" "PageResourceUserItemLogResource.h"

rename "%OUT_FOLDER%\model\PageResource?UserLevelingResource?.cpp" "PageResourceUserLevelingResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserLevelingResource?.h" "PageResourceUserLevelingResource.h"

rename "%OUT_FOLDER%\model\PageResource?UserNotificationResource?.cpp" "PageResourceUserNotificationResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserNotificationResource?.h" "PageResourceUserNotificationResource.h"

rename "%OUT_FOLDER%\model\PageResource?UserRelationshipResource?.cpp" "PageResourceUserRelationshipResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?UserRelationshipResource?.h" "PageResourceUserRelationshipResource.h"

rename "%OUT_FOLDER%\model\PageResource?VendorResource?.cpp" "PageResourceVendorResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?VendorResource?.h" "PageResourceVendorResource.h"

rename "%OUT_FOLDER%\model\PageResource?VideoRelationshipResource?.cpp" "PageResourceVideoRelationshipResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?VideoRelationshipResource?.h" "PageResourceVideoRelationshipResource.h"

rename "%OUT_FOLDER%\model\PageResource?VideoResource?.cpp" "PageResourceVideoResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?VideoResource?.h" "PageResourceVideoResource.h"

rename "%OUT_FOLDER%\model\PageResource?WalletTotalResponse?.cpp" "PageResourceWalletTotalResponse.cpp"
rename "%OUT_FOLDER%\model\PageResource?WalletTotalResponse?.h" "PageResourceWalletTotalResponse.h"

rename "%OUT_FOLDER%\model\PageResource?WalletTransactionResource?.cpp" "PageResourceWalletTransactionResource.cpp"
rename "%OUT_FOLDER%\model\PageResource?WalletTransactionResource?.h" "PageResourceWalletTransactionResource.h"

rename "%OUT_FOLDER%\model\SimpleReferenceResource?int?.cpp" "SimpleReferenceResourceInt.cpp"
rename "%OUT_FOLDER%\model\SimpleReferenceResource?int?.h" "SimpleReferenceResourceInt.h"

rename "%OUT_FOLDER%\model\SimpleReferenceResource?long?.cpp" "SimpleReferenceResourceLong.cpp"
rename "%OUT_FOLDER%\model\SimpleReferenceResource?long?.h" "SimpleReferenceResourceLong.h"

rename "%OUT_FOLDER%\model\SimpleReferenceResource?object?.cpp" "SimpleReferenceResourceObject.cpp"
rename "%OUT_FOLDER%\model\SimpleReferenceResource?object?.h" "SimpleReferenceResourceObject.h"

rename "%OUT_FOLDER%\model\SimpleReferenceResource?string?.cpp" "SimpleReferenceResourceString.cpp"
rename "%OUT_FOLDER%\model\SimpleReferenceResource?string?.h" "SimpleReferenceResourceString.h"

rename "%OUT_FOLDER%\model\ValueWrapper?boolean?.cpp" "ValueWrapperBoolean.cpp"
rename "%OUT_FOLDER%\model\ValueWrapper?boolean?.h" "ValueWrapperBoolean.h"

rename "%OUT_FOLDER%\model\ValueWrapper?string?.cpp" "ValueWrapperString.cpp"
rename "%OUT_FOLDER%\model\ValueWrapper?string?.h" "ValueWrapperString.h"
