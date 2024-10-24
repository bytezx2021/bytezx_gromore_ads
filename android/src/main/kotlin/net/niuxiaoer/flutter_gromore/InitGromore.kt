package net.niuxiaoer.flutter_gromore

import android.content.Context
import android.util.Log
import com.bytedance.sdk.openadsdk.TTAdConfig
import com.bytedance.sdk.openadsdk.TTAdSdk
import com.bytedance.sdk.openadsdk.TTCustomController
import com.bytedance.sdk.openadsdk.mediation.init.MediationPrivacyConfig
import io.flutter.BuildConfig
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import net.niuxiaoer.flutter_gromore.utils.AppUtils

class InitGromore(private val context: Context) {

    private val TAG: String = "InitGromore"

    private lateinit var initResult: MethodChannel.Result

    // 由于失败后会进行重试，可能会回调多次。这个flag标识是否调用
    private var resultCalled: Boolean = false

    /**
     * 初始化广告
     */
    fun initAd(call: MethodCall, result: MethodChannel.Result) {
        if (TTAdSdk.isSdkReady()) {
            resultCalled = true
            result.success(true)
            return
        }
        initResult = result

        val appId = call.argument<String>("appId")
        val appName = call.argument<String>("appName")
        val useMediation = call.argument<Boolean>("useMediation")
        val themeStatus = call.argument<Int>("themeStatus")
        val multiProcess = call.argument<Boolean>("multiProcess")
        val isCanUseLocation = call.argument<Boolean>("isCanUseLocation")
        val isCanUsePhoneState = call.argument<Boolean>("isCanUsePhoneState")
        val isCanUseWifiState = call.argument<Boolean>("isCanUseWifiState")
        val isCanUseWriteExternal = call.argument<Boolean>("isCanUseWriteExternal")
        val isCanUseAndroidId = call.argument<Boolean>("isCanUseAndroidId")
        val isLimitPersonalAds = call.argument<Boolean>("isLimitPersonalAds")
        val isProgrammaticRecommend = call.argument<Boolean>("isProgrammaticRecommend")
        if(appId.isNullOrEmpty()){
            result.success(false)
            return
        }
        TTAdSdk.init(
            context, buildConfig(
                appId,
                appName ?: "${AppUtils.getAppName(context = context)}_Android",
                useMediation ?: true,
                themeStatus ?: 0,
                multiProcess ?: false,
                isCanUseLocation ?: false,
                isCanUsePhoneState ?: false,
                isCanUseWifiState ?: false,
                isCanUseWriteExternal ?: false,
                isCanUseAndroidId ?: false,
                isLimitPersonalAds ?: false,
                isProgrammaticRecommend ?: true,
            )
        )
        TTAdSdk.start(object : TTAdSdk.Callback {
            override fun success() {
                Log.d(TAG, "initAd-success")
                if (resultCalled) {
                    return
                }
                resultCalled = true
                initResult.success(true)
            }
            override fun fail(code: Int, msg: String?) {
                Log.e(TAG, "TTAdSdk init start Error code:$code msg:$msg")
                if (resultCalled) {
                    return
                }
                resultCalled = true
                initResult.error(code.toString(), msg,msg)
//                result.error(code.toString(), msg,msg)
            }
        })
    }


    // 构造TTAdConfig
    private fun buildConfig(
        appId: String,
        appName: String,
        useMediation: Boolean,
        themeStatus: Int ,
        multiProcess: Boolean,
        isCanUseLocation: Boolean,
        isCanUsePhoneState: Boolean,
        isCanUseWifiState: Boolean,
        isCanUseWriteExternal: Boolean,
        isCanUseAndroidId: Boolean,
        isLimitPersonalAds: Boolean,
        isProgrammaticRecommend: Boolean,
    ): TTAdConfig {
        return TTAdConfig.Builder()
            .appId(appId) //APP ID
            .appName(appName) //APP Name
            .useMediation(useMediation)  //开启聚合功能
            .debug(BuildConfig.DEBUG)  //关闭debug开关
            .themeStatus(themeStatus)  //正常模式  0是正常模式；1是夜间模式；
            /**
             * 多进程增加注释说明：V>=5.1.6.0支持多进程，如需开启可在初始化时设置.supportMultiProcess(true) ，默认false；
             * 注意：开启多进程开关时需要将ADN的多进程也开启，否则广告展示异常，影响收益。
             * CSJ、gdt无需额外设置，KS、baidu、Sigmob、Mintegral需要在清单文件中配置各家ADN激励全屏xxxActivity属性android:multiprocess="true"
             */
            .supportMultiProcess(multiProcess)  //不支持
            .customController(
                getTTCustomController(
                    isCanUseLocation,
                    isCanUsePhoneState,
                    isCanUseWifiState,
                    isCanUseWriteExternal,
                    isCanUseAndroidId,
                    isLimitPersonalAds,
                    isProgrammaticRecommend,
                )
            )  //设置隐私权
            .build()
    }

    //设置隐私合规
    private fun getTTCustomController(
        isCanUseLocation: Boolean,
        isCanUsePhoneState: Boolean,
        isCanUseWifiState: Boolean,
        isCanUseWriteExternal: Boolean,
        isCanUseAndroidId: Boolean,
        isLimitPersonalAds: Boolean,
        isProgrammaticRecommend: Boolean,
    ): TTCustomController {
        return object : TTCustomController() {
            override fun isCanUseLocation(): Boolean {  //是否授权位置权限
                return isCanUseLocation
            }

            override fun isCanUsePhoneState(): Boolean {  //是否授权手机信息权限
                return isCanUsePhoneState
            }

            override fun isCanUseWifiState(): Boolean {  //是否授权wifi state权限
                return isCanUseWifiState
            }

            override fun isCanUseWriteExternal(): Boolean {  //是否授权写外部存储权限
                return isCanUseWriteExternal
            }

            override fun isCanUseAndroidId(): Boolean {  //是否授权Android Id权限
                return isCanUseAndroidId
            }

            override fun getMediationPrivacyConfig(): MediationPrivacyConfig {
                return object : MediationPrivacyConfig() {
                    override fun isLimitPersonalAds(): Boolean {  //是否限制个性化广告
                        return isLimitPersonalAds
                    }

                    override fun isProgrammaticRecommend(): Boolean {  //是否开启程序化广告推荐
                        return isProgrammaticRecommend
                    }
                }
            }
        }
    }
}