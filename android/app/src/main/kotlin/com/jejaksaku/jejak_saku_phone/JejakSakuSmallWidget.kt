package com.jejaksaku.jejak_saku_phone

import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews

class JejakSakuSmallWidget : BaseWidgetProvider() {
    override val layoutId = R.layout.widget_small

    override fun bind(context: Context, views: RemoteViews, data: SharedPreferences) {
        views.setTextViewText(R.id.companion_emoji, WidgetData.text(data, "companion_emoji", "🙂"))
        views.setTextViewText(R.id.task_summary, WidgetData.text(data, "task_summary", "Belum ada task"))
        views.setOnClickPendingIntent(R.id.widget_root, link(context, "chat"))
    }
}
