[users]
admin = password1, admin
user1 = user1, users

[main]
sessionManager = org.apache.shiro.web.session.mgt.DefaultWebSessionManager
securityManager.sessionManager = $sessionManager
securityManager.sessionManager.globalSessionTimeout = 86400000
shiro.loginUrl = /api/login

[roles]
admin = *
users = * 

[urls]
/api/version = anon
/api/configurations/** = authc, roles[admin]
/api/credential/** = authc, roles[admin]
/api/notebookRepos/** = authc, roles[admin]
/api/interpreter/** = authc, roles[admin]
/** = authc
