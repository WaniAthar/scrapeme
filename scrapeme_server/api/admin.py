from django.contrib import admin
from .models import *

class UserAdmin(admin.ModelAdmin):
    list_display = ('email', 'name', 'is_active', 'is_staff', 'is_superuser', 'date_joined', 'last_login')
    search_fields = ('email', 'name')
    list_filter = ('is_active', 'is_staff', 'is_superuser', 'date_joined', 'last_login')
    ordering = ('email', 'name', 'is_active', 'is_staff', 'is_superuser', 'date_joined', 'last_login')

    fieldsets = (
        ("Authentication", {'fields': ('email', 'password')}),
        ('Personal info', {'fields': ('name', 'is_active', 'is_staff', 'is_superuser')}),
        ('Permissions', {'fields': ('groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'date_joined')}),
    )



    
admin.site.register(User, UserAdmin)

admin.site.site_header = 'ScrapeMe Admin'
admin.site.site_title = 'ScrapeMe Admin'
admin.site.index_title = 'Welcome to ScrapeMe Admin'
admin.site.login_template = 'admin/login.html'