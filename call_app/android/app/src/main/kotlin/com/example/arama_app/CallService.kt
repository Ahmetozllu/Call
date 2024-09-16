// CallService.kt
/* 
package com.example.arama_app

import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import io.flutter.plugin.common.EventChannel

class CallService : Service() {

    private var eventSink: EventChannel.EventSink? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        val phoneStateListener = object : PhoneStateListener() {
            override fun onCallStateChanged(state: Int, phoneNumber: String?) {
                super.onCallStateChanged(state, phoneNumber)
                when (state) {
                    TelephonyManager.CALL_STATE_IDLE -> eventSink?.success("Arama Bitti")
                    TelephonyManager.CALL_STATE_RINGING -> eventSink?.success("Çalıyor")
                    TelephonyManager.CALL_STATE_OFFHOOK -> eventSink?.success("Arama Başladı")
                }
            }
        }
    
        
        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)

        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onDestroy() {
        super.onDestroy()
        // Servis sonlandığında EventSink'i temizle
        eventSink?.endOfStream()
    }
}
*/
/*MainActivity buraaaadaaaaaaaaa kullandığın 
package com.example.arama_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.telephony.TelephonyManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel


class MainActivity : FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val callReceiver = object : EventChannel.StreamHandler, BroadcastReceiver() {
            var eventSink: EventChannel.EventSink? = null
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }


            override fun onReceive(p0: Context?, p1: Intent?) {

                val state: String? = p1?.getStringExtra(TelephonyManager.EXTRA_STATE)
                val incomingNumber: String? =
                    p1?.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)

                if(state.equals(TelephonyManager.EXTRA_STATE_RINGING)){
                    //eventSink?.success("Çalıyor")
                    //çalarsa
                    eventSink?.success("$incomingNumber-1-Çalıyor")
                }
                if ((state.equals(TelephonyManager.EXTRA_STATE_OFFHOOK))){
                    //açarsa
                    eventSink?.success("-2-Cevaplandı")
                }
                if (state.equals(TelephonyManager.EXTRA_STATE_IDLE)){

                    //kapatırsa
                    eventSink?.success("-0-Arama Bitti")
                }


//                val telephony: TelephonyManager =
//                    context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
//                telephony.listen(object : PhoneStateListener() {
//                    override fun onCallStateChanged(state: Int, incomingNumber: String) {
//                        super.onCallStateChanged(state, incomingNumber)
//                            eventSink?.success("$incomingNumber-$state")
//                    }
//                }, PhoneStateListener.LISTEN_CALL_STATE)

            }
        }

        registerReceiver(callReceiver, IntentFilter("android.intent.action.PHONE_STATE"))
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.app/callStream")
            .setStreamHandler(callReceiver)


    }

}
*/