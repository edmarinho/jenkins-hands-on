# jenkins-hands-on


Procedimento de instalação official
https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

Plugins
https://plugins.jenkins.io/


Mudar porta padrão
A porta padrão para acesso ao Jenkins é a 8080. Mas podemos alterar a porta.
Acesse o arquivo /etc/default/jenkins e altere o valor do parâmetro HTTP_PORT.
vim /etc/default/jenkins
HTTP_PORT=80
systemctl restart jenkins

Reiniciar o Jenkins
systemctl restart jenkins
<URL-ACCESS-TO-JENKINS>/restart

Pipeline Syntax
<URL-ACCESS-TO-JENKINS>/pipeline-syntax