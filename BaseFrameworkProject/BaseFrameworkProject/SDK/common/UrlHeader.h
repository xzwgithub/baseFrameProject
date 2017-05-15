
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

#elif (BUILD_VERSION == 1) //百度开发新
#define kGtAppId           @"vRiQ6OOhzk9gyWWxpE0oL8"
#define kGtAppKey          @"7LBVmOUoWS8ddidSvchN26"
#define kGtAppSecret       @"vhihO8btlT8ddhmMMUpsm9"
#define IP_PORT @"http://180.76.143.51:8090"

#endif


#define DROOTURL  IP_PORT@"/driver/mvc"//货主


/*******************首页**********************/
/**
 *  3.1.1 登录
 *  username 用户名/手机号码/企业名称 password 密码，使用MD5加密
 */
#define DURL_LOGIN_LOGIN DROOTURL@"/login/api/dlogin/login.json"

/**
 *  3.1.1 注销
 *  loginToken 登录成功令牌
 */
#define DURL_LOGIN_LOGOUT DROOTURL@"/logout/api/dlogout/logout.json"

/**
 *  获取更新条数
 */
#define DHOME_GET_STATISTIC_COUNT   DROOTURL@"/order/list/api/orderlist/getStatisticCount.json"


#endif /* UrlHeader_h */
