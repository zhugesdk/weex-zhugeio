## 1.在 weex 上集成iOS SDK

### 1.1. 集成iOS SDK

在weex项目下，找到iOS平台目录，编辑Podfile文件，Podfile所在目录：

```
$yourWeexProject/platforms/ios/Podfile
```

打开Podfile，添加如下代码：

```
  target 'youProject' do
    pod 'Zhugeio'
  end

```
编辑完毕之后，在Podfile所在目录下执行命令```pod install```

### 1.2. 添加诸葛模块文件

下载WeexPluginZhugeioModule文件，并将WeexPluginZhugeioModule.h和WeexPluginZhugeioModule.m文件添加到项目中

![image](https://github.com/jiaokang/remotePic/blob/master/weex/weexiOS.png?raw=true)

### 1.3.初始化SDK并注册神策组件

在AppDelegate.m文件中的```didFinishLaunchingWithOptions```初始化诸葛SDK并注册诸葛组件，示例代码如下:

```

#import <Zhugeio/Zhuge.h>
#import "WeexPluginZhugeioModule.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化诸葛 SDK
    [[Zhuge sharedInstance]startWithAppKey:@"诸葛appkey" launchOptions:launchOptions];
    //初始化 weex
    [WeexSDKManager setup];
    // 注册诸葛 weex 插件
    [WXSDKEngine registerModule:@"WeexPluginZhugeio" withClass:[WeexPluginZhugeioModule class]];
    ....
    ....
    return YES;
}

```

## 2. 在weex上集成Android SDK

### 2.1. 集成android SDK

在weex项目下，找到android平台目录，按照如下路径打开文件build.gradle：

```
 $yourProject/platforms/android/app/build.gradle

```
找到```dependencies```节点添加如下代码:

```
    compile 'com.zhuge.analysis:zhugeio:latest.integration'

```
最终结果类似于:

```
dependencies {
    compile fileTree(include: ['*.jar'], dir: 'libs')
    //诸葛android SDK
    compile 'com.zhuge.analysis:zhugeio:latest.integration' 
    //more lib
}

```
### 2.2 添加WeexPluginZhugeioModule文件

下载WeexPluginZhugeioModule.java文件，并复制该文件到android应用目录下，具体位置：

```
 $yourProject/platforms/android/app/src/main/java/com/weex/app/
```

### 2.3 初始化SDK并注册诸葛模块
找到```WXApplication.java```文件，地址一般在
```
$yourProject/platforms/android/app/src/main/java/com/weex/app/WXApplication.java
```
找到```onCreate()```方法，添加如下代码:

```
public class WXApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();
    //初始化诸葛SDK
    ZhugeSDK.getInstance().init(this,"youAppKey","youAppChannel");
    

    try {
      //注册WeexPluginZhugeioModule给Weex
      WXSDKEngine.registerModule("WeexPluginZhugeio", WeexPluginZhugeioModule.class);
    } catch (WXException e) {
      e.printStackTrace();
    }
    //more code
  }
  
  
}
```


##  3. 在weex中使用

### 3.1 在具体需要使用诸葛的js文件中获取诸葛模块，示例如下：

```
 const Zhugeio = weex.requireModule('WeexPluginZhugeio')

```

### 3.2 具体接口

* track追踪事件

   ```
    Zhugeio.track('事件名称',{'属性1':'值1','属性2':'值2'});

   ```

* identify标记用户

   ```
    Zhugeio.identify('用户ID',{'用户属性':'用户值'})

   ```

* 时长事件统计

   使用```startTrack()```开始事件

   ```
     Zhugeio.startTrack('事件名称');
   ```

   使用```endTrack()```来结束具有相同事件名称的事件

   ```
     Zhugeio.endTrack('事件名称'，{'属性1':'值1'});
   ```

   ```startTrack()``` 与```endTrack()```需成对出现，单独使用没有效果。

* 开启实时调试

   ```
     Zhugeio.openDebug();

   ```

* 开启日志输出

  该方法仅对Android平台可用，iOS平台请参阅 [iOS集成文档](http://docs.zhugeio.com/dev/iOS.html)

  ```
    Zhugeio.openLog();
  ```