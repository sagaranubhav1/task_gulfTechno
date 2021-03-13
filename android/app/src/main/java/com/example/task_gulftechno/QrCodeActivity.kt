package com.example.task_gulftechno

import android.Manifest
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.karumi.dexter.Dexter
import com.karumi.dexter.PermissionToken
import com.karumi.dexter.listener.PermissionDeniedResponse
import com.karumi.dexter.listener.PermissionGrantedResponse
import com.karumi.dexter.listener.PermissionRequest
import com.karumi.dexter.listener.single.PermissionListener
import me.dm7.barcodescanner.zxing.ZXingScannerView
import com.google.zxing.Result

class QrCodeActivity : AppCompatActivity(), ZXingScannerView.ResultHandler {

        var scannerView: ZXingScannerView? = null
        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            scannerView = ZXingScannerView(this)
            setContentView(scannerView)
            Dexter.withContext(applicationContext)
                    .withPermission(Manifest.permission.CAMERA)
                    .withListener(object : PermissionListener {
                        override fun onPermissionGranted(permissionGrantedResponse: PermissionGrantedResponse?) {
                            scannerView!!.startCamera()
                        }

                        override fun onPermissionDenied(permissionDeniedResponse: PermissionDeniedResponse?) {}
                        override fun onPermissionRationaleShouldBeShown(permissionRequest: PermissionRequest?, permissionToken: PermissionToken) {
                            permissionToken.continuePermissionRequest()
                        }
                    }).check()
        }

        override fun handleResult(rawResult: Result) {
            val resultIntent = Intent()
            resultIntent.putExtra("resultData", rawResult.text)
            setResult(RESULT_OK, resultIntent)
            finish()
        }

        override fun onPause() {
            super.onPause()
            scannerView?.stopCamera()
        }

        override fun onResume() {
            super.onResume()
            scannerView?.setResultHandler(this)
            scannerView?.startCamera()
        }
}
