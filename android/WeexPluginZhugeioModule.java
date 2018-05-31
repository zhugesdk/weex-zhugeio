package com.weex.app;

import android.util.Log;

import com.alibaba.weex.plugin.annotation.WeexModule;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.common.WXModule;
import com.zhuge.analysis.stat.ZhugeSDK;

import org.json.JSONObject;

import java.util.Map;

@WeexModule(name = "WeexPluginZhugeio")
public class WeexPluginZhugeioModule extends WXModule {

   @JSMethod (uiThread = true)
    public void openLog() {
        ZhugeSDK.getInstance().openLog();
    }
   @JSMethod
    public void openDebug(){
        ZhugeSDK.getInstance().openDebug();
    }

   @JSMethod
    public void identify(String uid , Map<String,Object> pro){
        debug("identify "+uid);
        ZhugeSDK.getInstance().identify(null,uid,convertToJSONObject(pro));
    }

   @JSMethod
    public void track(String name, Map<String,Object> pro){
        debug("track "+name);
        ZhugeSDK.getInstance().track(null,name,convertToJSONObject(pro));
    }

   @JSMethod
    public void startTrack(String name){
        debug("startTrack "+name);
        ZhugeSDK.getInstance().startTrack(name);
    }

   @JSMethod
    public void endTrack(String name, Map<String,Object> pro){
        debug("endTrack : "+name);
        ZhugeSDK.getInstance().endTrack(name,convertToJSONObject(pro));
    }

    /**
     * Map转换成JSONObject
     */
    private JSONObject convertToJSONObject(Map<String, Object> properties) {
        JSONObject json = new JSONObject();
        if (properties == null) {
            return json;
        }
        try {
            for (String key : properties.keySet()) {
                if (key == null) {
                    return json;
                }
                Object value = properties.get(key);
                if (value != null) {
                    json.put(key, value);
                }
            }
        }catch (Exception e){
            Log.e("Zhugeio","convert to json error.");
            e.printStackTrace();
        }
        return json;
    }

    private void debug(String info){
       if (BuildConfig.DEBUG){
        Log.d("Zhugeio",info);
       }
    }
}