/**
 * @file XSLocalizedLanguage.h
 * @brief XSLocalizedLanguage Class
 */

#import <Foundation/Foundation.h>

#define NOTIFICATION_LANGUAGE_CHANGED @"NOTIFICATION_LANGUAGE_CHANGED"


/** This enumeration is used to indicates the localized language. It can be used as the value of the {@link langeType} parameter.
 * It can be used as an input parameter of the XSLocalizedLanguage::setLanguageType method.
 */
typedef enum tag_EN_LANGUAGE_TYPE
{
    EN_LANGUAGE_ENGLISH = 1,        /**< @brief The localized language is English. */
    EN_LANGUAGE_CHINESE,            /**< @brief The localized language is Chinese. */
}EN_LANGUAGE_TYPE;

@interface XSLocalizedLanguage : NSObject

/**
 * <b>Description:</b> This method is used to get the localized language string by a key string.
 * <br><b>Purpose:</b> Developer invokes this method to get the localized language string for display.
 * @param keys Specifies the key string for the localized language string.
 * @param comment Specifies the comment for the localized language string. It can be nil.
 * @return The value indicates the localized string.
 */
+ (NSString *)XSLocalizedString:(NSString *)keys comments:(NSString *)comment;

/**
 * <b>Description:</b> This method is used to get the localized language type for the app currently.
 * <br><b>Purpose:</b> Developer invokes this method to get the localized language type for the app currently.
 * @return The value indicates the localized language type. See {@link EN_LANGUAGE_TYPE}.
 */
+ (int)getLanguageType;

/**
 * <b>Description:</b> This method is used to set the localized language type.
 * <br><b>Purpose:</b> Developer invokes this method to set the localized language type.
 * @param languageType Specifies the language type for the current localized language. See {@link EN_LANGUAGE_TYPE}.
 */
+ (void)setLanguageType:(EN_LANGUAGE_TYPE)languageType;
@end
