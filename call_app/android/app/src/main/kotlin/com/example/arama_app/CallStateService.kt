/*// CallStateService.kt

package com.example.arama_app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import android.util.Log

class CallReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == "android.intent.action.PHONE_STATE") {
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)

            if (state == TelephonyManager.EXTRA_STATE_RINGING) {
                // Arama başladığında buraya gelir
                Log.d("CallReceiver", "Incoming call detected")
                // Ekran kapalıyken bildirim gösterme veya diğer işlemleri burada gerçekleştirebilirsiniz.
            }
        }
    }
}

*/























































/*import android.app.Notification
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import androidx.core.app.NotificationCompat
import io.flutter.plugin.common.EventChannel

class CallStateService : Service() {

    private var eventSink: EventChannel.EventSink? = null
    private val CHANNEL_ID = "CallStateServiceChannel"

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        super.onCreate()
        startForegroundService()
        startCallStatusListener()
    }

    private fun startForegroundService() {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this,
            0, notificationIntent, 0
        )

        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Arama Durumu Servisi")
            .setContentText("Arama durumu dinleniyor...")
            .setSmallIcon(R.drawable.launch_background)
            .setContentIntent(pendingIntent)
            .build()

        startForeground(1, notification)
    }

    private fun startCallStatusListener() {
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

        val telephonyManager =
            getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
    }

    override fun onDestroy() {
        super.onDestroy()
        // Servis sona erdiğinde temizleme işlemleri yapabilirsiniz.
    }
}
*/