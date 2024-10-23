package net.niuxiaoer.flutter_gromore.utils

import android.content.Context

object AppUtils {

    fun getAppName(context: Context):String{
        return context.applicationContext.applicationInfo.loadLabel(context.packageManager).toString();
    }
}