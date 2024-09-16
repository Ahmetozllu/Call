/*// NativeBridge.kt

package com.example.arama_app

import android.content.Context
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import io.flutter.plugin.common.EventChannel

class NativeBridge(private val context: Context) : EventChannel.StreamHandler {

    private var eventSink: EventChannel.EventSink? = null

    fun startCallStatusListener() {
        val phoneStateListener = object : PhoneStateListener() {
            override fun onCallStateChanged(state: Int, phoneNumber: String?) {
                super.onCallStateChanged(state, phoneNumber)
                when (state) {
                    TelephonyManager.CALL_STATE_IDLE -> {
                        eventSink?.success("Arama Bitti")
                        if(phoneNumber !=null){
                            eventSink?.success(phoneNumber)
                        }
                    }
                    TelephonyManager.CALL_STATE_RINGING -> {
                        eventSink?.success("Çalıyor")
                        if(phoneNumber !=null){
                            eventSink?.success(phoneNumber)
                        }
                    }
                    TelephonyManager.CALL_STATE_OFFHOOK -> {
                        eventSink?.success("Arama Başladı")
                        if(phoneNumber !=null){
                            eventSink?.success(phoneNumber)
                        }
                    }
                }

                /*if (state == TelephonyManager.CALL_STATE_RINGING && phoneNumber != null) {
                    eventSink?.success(phoneNumber)
                }
            }
        }

        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
        startCallStatusListener()
    }

    override fun onCancel(arguments: Any?) {
        // Dinleme iptal edildiğinde burada gerekirse temizlik işlemleri yapabilirsiniz.
    }
}
*/