from django.conf.urls import url

from homepage.pages.chat.views import index, chat_api

urlpatterns = [
    url(r'^chat_api$', chat_api),
    url(r'', index, name='index'),
]
