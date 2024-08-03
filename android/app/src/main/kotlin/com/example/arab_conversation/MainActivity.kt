package com.example.arab_conversation

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        installSplashScreen()
    }

}
