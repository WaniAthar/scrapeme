# Generated by Django 5.0.7 on 2024-09-02 11:53

import api.models
import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='user',
            options={'ordering': ('email',), 'verbose_name': 'User', 'verbose_name_plural': 'Users'},
        ),
        migrations.AlterModelManagers(
            name='user',
            managers=[
                ('objects', api.models.CustomUserManager()),
            ],
        ),
        migrations.RemoveField(
            model_name='user',
            name='billing_plan',
        ),
        migrations.RemoveField(
            model_name='user',
            name='blocked',
        ),
        migrations.RemoveField(
            model_name='user',
            name='first_name',
        ),
        migrations.RemoveField(
            model_name='user',
            name='last_name',
        ),
        migrations.RemoveField(
            model_name='user',
            name='restricted',
        ),
        migrations.RemoveField(
            model_name='user',
            name='subscribed',
        ),
        migrations.RemoveField(
            model_name='user',
            name='username',
        ),
        migrations.AddField(
            model_name='user',
            name='name',
            field=models.CharField(default='', max_length=255, verbose_name='Name'),
        ),
        migrations.AlterField(
            model_name='user',
            name='date_joined',
            field=models.DateTimeField(default=django.utils.timezone.now, verbose_name='Date Joined'),
        ),
        migrations.AlterField(
            model_name='user',
            name='email',
            field=models.EmailField(default='', max_length=255, unique=True, verbose_name='Email Address'),
        ),
        migrations.AlterField(
            model_name='user',
            name='is_active',
            field=models.BooleanField(default=True, verbose_name='Active'),
        ),
        migrations.AlterField(
            model_name='user',
            name='is_staff',
            field=models.BooleanField(default=False, verbose_name='Active'),
        ),
        migrations.AlterField(
            model_name='user',
            name='is_superuser',
            field=models.BooleanField(default=False, verbose_name='Active'),
        ),
        migrations.AlterField(
            model_name='user',
            name='last_login',
            field=models.DateTimeField(default=django.utils.timezone.now, verbose_name='Last Login'),
        ),
        migrations.DeleteModel(
            name='ChatHistory',
        ),
    ]
