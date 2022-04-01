from django.conf.urls import patterns, include, url


urlpatterns = patterns('',
    # Examples:
    (r'^$', 'easeserver.views.index'),
    (r'^api/user/$', 'easeserver.api.api_user'),
    (r'^skin_config/$', 'easeserver.views.skin_config'),
    (r'^install/$', 'easeserver.views.install'),
    (r'^base/$', 'easeserver.views.base'),
    (r'^login/$', 'easeserver.views.login'),
    (r'^logout/$', 'easeserver.views.logout'),
    (r'^file/upload/$', 'easeserver.views.upload'),
    (r'^file/download/$', 'easeserver.views.download'),
    (r'^error/$', 'easeserver.views.httperror'),
    (r'^juser/', include('juser.urls')),
    (r'^jasset/', include('jasset.urls')),
    (r'^jlog/', include('jlog.urls')),
    (r'^jperm/', include('jperm.urls')),
    (r'^node_auth/', 'easeserver.views.node_auth'),

)