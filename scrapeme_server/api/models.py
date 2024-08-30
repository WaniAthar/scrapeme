from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    email = models.EmailField(max_length=254, unique=True)
    billing_plan = models.CharField(max_length=254, default='free')
    subscribed = models.BooleanField(default=False)
    blocked = models.BooleanField(default=False)
    restricted = models.BooleanField(default=False)

    
class ChatHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    is_bot_message = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user.username} - {self.timestamp}"

    class Meta:
        ordering = ['timestamp']
        verbose_name_plural = 'Chat histories'
