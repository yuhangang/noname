package com.example.noname
import android.os.Build
import android.os.Bundle
import android.app.NotificationChannel
import android.app.NotificationManager

import android.content.Context
import android.graphics.Color
import io.flutter.embedding.android.FlutterActivity


import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {

     override fun onCreate(savedInstanceState: Bundle?) {
     if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {  
        val default_channel_id = getString(R.string.default_channel_id)
        val name = "Podcast App"
        val descriptionText = "This is default channel"
        val importance = NotificationManager.IMPORTANCE_DEFAULT
        val mChannel = NotificationChannel(default_channel_id, name, importance)
        mChannel.description = descriptionText
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.createNotificationChannel(mChannel)
     }
     super.onCreate(savedInstanceState);

    
    
}

 override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }


}