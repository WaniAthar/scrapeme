from rest_framework import serializers
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth import get_user_model

User = get_user_model()


class UserSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True, max_length=255, )
    name = serializers.CharField(required=True, max_length=255, )
    last_login = serializers.DateTimeField(required=True,  )
    date_joined = serializers.DateTimeField(required=True, )

    

class SignUpSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True, max_length=255, )
    password = serializers.CharField(write_only=True, required=True, validators=[validate_password], )
    password2 = serializers.CharField(write_only=True, required=True, max_length=255)
    name = serializers.CharField(required=True, max_length=255, )

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError('Passwords do not match')
        return attrs
    def create(self, validated_data):
        validated_data.pop('password2')
        user = User.objects.create_user(**validated_data)
        return user