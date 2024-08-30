from django.contrib import admin
from .models import *

class UserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'billing_plan', 'subscribed', 'blocked', 'restricted')
    search_fields = ('username', 'email')
    list_filter = ('billing_plan', 'subscribed', 'blocked', 'restricted')

class ChatHistoryAdmin(admin.ModelAdmin):
    list_display = ('user', 'message', 'timestamp', 'is_bot_message')
    search_fields = ('user', 'message')
    list_filter = ('is_bot_message',)

    
admin.site.register(User, UserAdmin)
admin.site.register(ChatHistory, ChatHistoryAdmin)

