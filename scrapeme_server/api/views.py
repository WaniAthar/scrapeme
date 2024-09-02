from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework import permissions
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from .serialisers import  SignUpSerializer, UserSerializer
from rest_framework import status



class SignupView(APIView):

    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def post(self, request):
            serializer = SignUpSerializer(data=request.data)
            if serializer.is_valid():
                 try:  
                    user = serializer.save()
                    refresh = RefreshToken.for_user(user)
                    access = str(refresh.access_token)
                    refresh =str(refresh)
                    return Response({'message': 'Successfully signed up','access':access,'refresh':refresh}, status=status.HTTP_201_CREATED)
                 except Exception as e:
                        return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
            return Response({'errors':serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
   
class ProfileView(APIView):
     permission_classes = [permissions.IsAuthenticated]
     authentication_classes = [JWTAuthentication]
     def get(self, request ):
        try:
            user = request.user
            serializer = UserSerializer(user)
            return Response({'success':True,'data':serializer.data})
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
class UserLogoutView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    authentication_classes = [JWTAuthentication]
    def post(self, request):
        try:
            refresh_token = RefreshToken(request.data.get('refresh'))
            refresh_token.blacklist()
            return Response({'message': 'Successfully logged out'})
        except Exception as e:
                return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
      





