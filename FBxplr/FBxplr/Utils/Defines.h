//
//  Defines.h
//  YakimbiIosTest
//
//  Created by andrea gonteri on 3/13/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "DevDefines.h"

#import "AppManager.h"

#define FORCELANDSCAPE NO


#define NAMESPACE @"custom.exception"
#define ERROR_DOMAIN @"custom.error"
#define ERROR_DEFAULT_ERROR_CODE 9000



//#define COOP_ERROR_CODE_TICKET_REQUEST_FAILED 905

//MACROS defined in Target Settings

//enable DEBUG info
#ifndef DEBUG
    #define DEBUG 1
#endif



//Allow USE_GLOBAL_EXCEPTIONS_HANDLER!!
#ifndef USE_GLOBAL_EXCEPTIONS_HANDLER
    #define USE_GLOBAL_EXCEPTIONS_HANDLER 1
#endif


//DEBUG_ON_SCREEN attach a TextView on top, allowing redirect NSLogs call (via "stderr" interception)
#ifndef DEBUG_ON_SCREEN
#define DEBUG_ON_SCREEN 0
#endif


//enable PRODUCTION endpoint
#ifndef PRODUCTION
    #define PRODUCTION 0
#endif

//enable ENABLE_DEBUG_MEM, add Stats Component to AppDelegate
#ifndef ENABLE_DEBUG_MEM
    #define ENABLE_DEBUG_MEM 0
#endif

//enable ENABLE_LOCALIZATION, enable LSTR conversion
#ifndef ENABLE_LOCALIZATION
    #define ENABLE_LOCALIZATION 1
#endif

//enable LOGGING_ENABLED, enable Logging Behavior
#ifndef LOGGING_ENABLED
    #define LOGGING_ENABLED 1
#endif

  
//datetime specs

#define DEFAULT_DATE_UTILS_TIMESTAMP_FORMAT @"yyyy-MM-dd HH:mm:ss"

#define DEFAULT_DATE_UTILS_DATE_FORMAT @"yyyy-MM-dd"

#define DEFAULT_DATE_UTILS_OUT_TIMESTAMP_FORMAT @"EEE MMM d, yyyy HH:mm"


#define DEFAULT_DATE_UTILS_OUT_DATE_FORMAT @"EEE MMM d, yyyy"

#define DEFAULT_FADE_IN_DURATION 0.4
#define DEFAULT_FADE_OUT_DURATION 0.3


#define FAKE_TIMEOUT_SLEEP 2

#define COLOR_THEME_SUBMENU_DARK 0x1b140e
#define COLOR_THEME_SUBMENU_LIGHT 0xf1e1c8 //0Xefdfc5

#define DEFAULT_BOLD_FONT_NAME @"Futura-Medium"
#define DEFAULT_REGULAR_FONT_NAME @"Helvetica"


#define MAX_ALLOWED_ITEM_COUNTER 999

#define DEFAULT_FADE_IN_TIMEOUT 0.4f

#define TIMEOUT_CONNECTION 60

