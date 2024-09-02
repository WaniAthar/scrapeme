from django.urls import path
from .views import SignupView, UserLogoutView, ProfileView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('signup/', SignupView.as_view(), name='signup'),
    path('logout/', UserLogoutView.as_view(), name='logout'),
    path('profile/',ProfileView.as_view(), name='profile')
    # path('verifyOTP/', views.verifyOTP, name='verifyOTP'),
    
]
