# Generated by Django 5.0.7 on 2024-11-06 20:09

import django.db.models.deletion
import django.utils.timezone
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_user_nickname'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='plan',
            field=models.CharField(choices=[('free', 'Free'), ('pro', 'Pro')], default='free', max_length=255, verbose_name='Plan'),
        ),
        migrations.AlterField(
            model_name='user',
            name='nickname',
            field=models.CharField(default='', max_length=255, unique=True, verbose_name='Nickname'),
        ),
        migrations.CreateModel(
            name='ScrapeSession',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('response', models.TextField(default='', verbose_name='Response')),
                ('date', models.DateTimeField(default=django.utils.timezone.now, verbose_name='Date')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL, verbose_name='User')),
            ],
            options={
                'verbose_name': 'Scrape Session',
                'verbose_name_plural': 'Scrape Sessions',
            },
        ),
    ]
