package com.jejaksaku.jejak_saku_phone

import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews

class JejakSakuLargeWidget : BaseWidgetProvider() {
    override val layoutId = R.layout.widget_large

    override fun bind(context: Context, views: RemoteViews, data: SharedPreferences) {
        views.setTextViewText(R.id.companion_emoji, WidgetData.text(data, "companion_emoji", "🙂"))
        views.setTextViewText(R.id.greeting, WidgetData.text(data, "greeting", "Halo!"))
        views.setTextViewText(R.id.sync_label, WidgetData.text(data, "sync_label", "Tersimpan lokal"))

        val next = WidgetData.nextReminder(data)
        views.setTextViewText(
            R.id.next_schedule,
            if (next == null) "Belum ada jadwal"
            else "Berikutnya\n${WidgetData.time(next.at)} • ${next.title}"
        )

        views.setOnClickPendingIntent(R.id.schedule_row, link(context, "reminder"))
        views.setOnClickPendingIntent(R.id.chat_pill, link(context, "chat"))
        views.setOnClickPendingIntent(R.id.action_photo, link(context, "camera"))
        views.setOnClickPendingIntent(R.id.action_task, link(context, "chat?cmd=/task"))
        views.setOnClickPendingIntent(R.id.action_schedule, link(context, "chat?cmd=/jadwal"))
    }
}
