package com.jejaksaku.jejak_saku_phone

import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews

class JejakSakuMediumWidget : BaseWidgetProvider() {
    override val layoutId = R.layout.widget_medium

    override fun bind(context: Context, views: RemoteViews, data: SharedPreferences) {
        views.setTextViewText(R.id.companion_emoji, WidgetData.text(data, "companion_emoji", "🙂"))

        val next = WidgetData.nextReminder(data)
        views.setTextViewText(
            R.id.reminder_text,
            if (next == null) "Tidak ada reminder"
            else "Reminder ${WidgetData.time(next.at)}\n${next.title}"
        )

        val attendance = WidgetData.text(data, "attendance_label", "Pilih status")
        views.setTextViewText(R.id.attendance_button, "$attendance ▾")

        views.setOnClickPendingIntent(R.id.reminder_pill, link(context, "reminder"))
        views.setOnClickPendingIntent(R.id.doc_button, link(context, "camera"))
        views.setOnClickPendingIntent(R.id.attendance_button, link(context, "attendance"))
        views.setOnClickPendingIntent(R.id.chat_pill, link(context, "chat"))
        views.setOnClickPendingIntent(R.id.companion_frame, link(context, "home"))
    }
}
