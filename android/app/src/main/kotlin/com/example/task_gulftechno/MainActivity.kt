package com.example.task_gulftechno

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "test_activity"
    private lateinit var _result: MethodChannel.Result

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            // Note: this method is invoked on the main thread.
            // TODO
            if (call.method == "startNewActivity") {
                _result = result
                val intent = Intent(this@MainActivity, QrCodeActivity::class.java)
                intent.putExtra("result", call.argument<String>("result"))
                startActivityForResult(intent, 9689)
            }
            else result.notImplemented()
        }

        }

    override fun onActivityResult(requestCode: Int, result: Int, intent: Intent?) {
        if(requestCode != 9689)
            return super.onActivityResult(requestCode, result, intent)
        if (result == Activity.RESULT_OK) {
            _result.success(intent!!.getStringExtra("resultData"))
        }
        else
            _result.success(null)
    }
}
