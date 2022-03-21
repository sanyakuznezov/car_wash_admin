package com.example.car_wash_admin

import android.app.NotificationChannel
import android.app.NotificationManager
import android.graphics.Color
import android.media.RingtoneManager
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
      super.onMessageReceived(remoteMessage);
        // TODO(developer): Handle FCM messages here.
        // Not getting messages here? See why this may be: https://goo.gl/39bRNJ
        Log.i("MessagingService", "From: ${remoteMessage.from}")

        // Check if message contains a data payload.

        // Check if message contains a notification payload.
        if (remoteMessage.notification != null) {
            sendNotification(body = remoteMessage.notification!!.body.toString(), title = remoteMessage.notification!!.title.toString())
            Log.i("MessagingService", "Message Notification Body: " +remoteMessage.notification!!.title+ remoteMessage.notification!!.body)
        }

        // Check if message contains a notification payload.
        remoteMessage.notification?.let {
            Log.i("MessagingService", "notification: ${remoteMessage.data}")
        }

    }

    override fun onNewToken(p0: String) {
        Log.i("MessagingService", "Message data payload: ${p0}")

    }


    private fun sendNotification(body: String, title: String) {
        val NOTIFICATION_CHANEL_ID = "my_notifi_chanel"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name: CharSequence = "CRMStep"
            val d = "description"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(NOTIFICATION_CHANEL_ID, name, importance)
            channel.description = d
            channel.enableLights(true)
            channel.vibrationPattern = longArrayOf(0, 1000, 500, 1000)
            channel.enableVibration(true)
            channel.lightColor = Color.RED
            channel.setShowBadge(true)
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
        val uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val notificationManagerCompat = NotificationManagerCompat.from(applicationContext)
        val builder = NotificationCompat.Builder(applicationContext, NOTIFICATION_CHANEL_ID)
                .setContentTitle(title)
                .setContentText(body)
                .setSound(uri)
                .setSmallIcon(R.drawable.logo_v21)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
        val NOTIFICATION_ID = 1
        notificationManagerCompat.notify(NOTIFICATION_ID, builder.build())
    }

}