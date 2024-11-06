from rest_framework import serializers
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth import get_user_model

User = get_user_model()


class UserSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True, max_length=255, )
    nickname = serializers.CharField(required=True, max_length=255, )
    name = serializers.CharField(required=True, max_length=255, )
    last_login = serializers.DateTimeField(required=True,  )
    date_joined = serializers.DateTimeField(required=True, )

    

class SignUpSerializer(serializers.Serializer):
    email = serializers.EmailField(
        required=True, 
        max_length=255,
    )
    password = serializers.CharField(write_only=True, required=True, validators=[validate_password], )
    password2 = serializers.CharField(write_only=True, required=True, max_length=255)
    name = serializers.CharField(required=True, max_length=255, )
  

    def validate_email(self, value):
        if User.objects.filter(email=value).exists():
            raise serializers.ValidationError('Email already exists')
        return value
    def validate_password2(self, value):
        if value != self.initial_data.get('password'):
            raise serializers.ValidationError('Passwords do not match')
        return value
 
    def create(self, validated_data):
        validated_data.pop('password2')
        validated_data['nickname'] = validated_data['name'].split()[0]
        user = User.objects.create_user(**validated_data)
        return user