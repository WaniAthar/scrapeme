from django.db import models
from django.contrib.auth.models import AbstractBaseUser, UserManager, PermissionsMixin
from django.utils import timezone

class CustomUserManager(UserManager):

    def _create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError('You have not provided a valid email address')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email = None, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        
        return self._create_user(email, password, **extra_fields)
   
    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self._create_user(email, password, **extra_fields)

class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(max_length=255, unique=True, default='', verbose_name='Email Address')
    name = models.CharField(max_length=255, default='', verbose_name='Name')
    nickname = models.CharField(max_length=255, default='', verbose_name='Nickname', unique=True)
    is_active = models.BooleanField(default=True, verbose_name='Active')
    is_superuser = models.BooleanField(default=False, verbose_name='Super User')
    is_staff = models.BooleanField(default=False, verbose_name='Staff')

    date_joined = models.DateTimeField(default=timezone.now, verbose_name='Date Joined')
    last_login = models.DateTimeField(default=timezone.now, verbose_name='Last Login')
    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    EMAIL_FIELD = 'email'
    REQUIRED_FIELDS = ['name']

    class Meta:
        verbose_name = 'User'
        verbose_name_plural = 'Users'
        ordering = ('email',)

    def get_full_name(self):
        return self.name
    def get_short_name(self):
        return self.nickname