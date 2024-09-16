/*package com.example.arama_app.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager

class CallStatusReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == "android.intent.action.PHONE_STATE") {
            val callState = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
            if (callState == TelephonyManager.EXTRA_STATE_IDLE) {
                return 'Arama Bitti'
                // Ekran kapalıyken çağrı durumu "Arama Bitti"
                // işlemlerinizi burada gerçekleştirin
            }
        }
    }
}*/
