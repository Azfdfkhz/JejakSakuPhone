package com.jejaksaku.jejak_saku_phone

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/** Reads the data Flutter pushed through home_widget. Nothing is hardcoded here. */
object WidgetData {
    data class Reminder(val title: String, val at: Long)

    fun text(prefs: SharedPreferences, key: String, fallback: String): String =
        prefs.getString(key, null)?.takeIf { it.isNotBlank() } ?: fallback

    /** Nearest reminder that is still in the future, evaluated at render time. */
    fun nextReminder(prefs: SharedPreferences): Reminder? {
        val raw = prefs.getString("reminders_json", null) ?: return null
        return try {
            val arr = JSONArray(raw)
            val now = System.currentTimeMillis()
            (0 until arr.length())
                .map { arr.getJSONObject(it) }
                .map { Reminder(it.getString("title"), it.getLong("at")) }
                .filter { it.at > now }
                .minByOrNull { it.at }
        } catch (e: Exception) {
            null
        }
    }

    fun time(at: Long): String =
        SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date(at))
}

abstract class BaseWidgetProvider : HomeWidgetProvider() {
    abstract val layoutId: Int
    abstract fun bind(context: Context, views: RemoteViews, data: SharedPreferences)

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { id ->
            val views = RemoteViews(context.packageName, layoutId)
            bind(context, views, widgetData)
            appWidgetManager.updateAppWidget(id, views)
        }
    }

    protected fun link(context: Context, target: String): PendingIntent =
        HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            Uri.parse("jejaksaku://$target")
        )
}
