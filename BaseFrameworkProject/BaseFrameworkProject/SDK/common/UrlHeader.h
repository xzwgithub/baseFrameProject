
#ifndef UrlHeader_h
#define URLHEADER_H


// setRequestDeBug 设置网络请求是否为 调试模式
#define IS_DEBUG 0
/////////////////////////////////////////////////

/*******************不同环境打包配置，修改下面参数**********************/
#define BUILD_VERSION  1
// 0：新测试环境
// 1：新开发环境
#if (BUILD_VERSION == 0) //新测试环境
#define kGtAppId          @"TYOO36ZvvH6JCJWoPn3xE3"
#define kGtAppKey         @"PJmaDgjais5hLZvUJyACo5"
#define kGtAppSecret      @"1dCkAdC9uU5ePALiKAuVj2"
#define IP_PORT @"http://shipper.sxyunju.com"

#elif (BUILD_VERSION == 1) //新开发环境
#define kGtAppId           @"Si7u8OdQgA6VV4ZAE1vrH1"
#define kGtAppKey          @"wD2rytbqsd8TAeFtcKWyo5"
#define kGtAppSecret       @"aRcJvmJc5A9dqEV2QngSO5"
#define IP_PORT @"http://180.76.161.252:8220"

#endif


#define DROOTURL  IP_PORT@"/shipper/mvc"//货主


/*******************首页**********************/
/**
  * 例如
 */
#define HOME_GET_CAROUSEL_ADLIST DROOTURL@"/adsposition/getCarouselAdList.json"




#endif /* UrlHeader_h */
