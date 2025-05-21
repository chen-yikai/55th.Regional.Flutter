package dev.eliaschen.flutter_55th

import android.content.Context
import android.os.Vibrator
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val channel = "dev.eliaschen.tomatobo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "vibrate" -> {
                    val virbrate = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
                    virbrate.vibrate(500)
                    result.success(null)
                }

                "writeCurrentTodo" -> {
                    val data = call.argument<String>("data")
                    try {
                        val file = File(getExternalFilesDir(null), "todo.json")
                        file.writeText(data ?: "")
                        result.success("writeCurrentTodo")
                    } catch (e: Exception) {
                        result.error("writeCurrentTodo", "Failed to write current todo", "")
                    }
                }

                "getCurrentTodo" -> {
                    try {
                        val file = File(getExternalFilesDir(null), "todo.json")
                        result.success(file.readText())
                    } catch (e: Exception) {
                        result.error("getCurrentTodo", "Failed to get current todo", "")
                    }
                }

                "writeHistory" -> {
                    try {
                        val data = call.argument<String>("data")
                        val file = File(getExternalFilesDir(null), "history.json")
                        file.writeText(data ?: "[]")
                        result.success("write history")
                    } catch (e: Exception) {
                        result.error("writeHistory", "", "")
                    }
                }

                "getHistory" -> {
                    try {
                        val file = File(getExternalFilesDir(null), "history.json")
                        if (file.exists()) {
                            result.success(file.readText())
                        } else {
                            result.success("[]")
                        }
                    } catch (e: Exception) {
                        result.error("getHistory", "", "")
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}