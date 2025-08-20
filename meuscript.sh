#!/bin/bash

opcao=${1}
case $opcao in

	1) echo " Detectar possíveis ataques de XSS (Cross-Site Scripting)"
           grep -iE "<script|%3Cscript" access.log
	   ;;

	2) echo "Localizar user-agent utilizado por um IP suspeito" 
           grep "172.17.0.3" access.log | cut -d '"' -f 6 | sort | uniq
	   ;;

	3) echo " Procurando por tentativas de Path Traversal"
           grep -E "172.17.0.3.*(\.\./|\.\.%2f)" access.log | head -n100
           ;;
	
	4) echo " Procurando por arquivos sensíveis (.env, .git, .htaccess, .bak)..."
           grep -iE "\.env|\.git|\.htaccess|\.bak|\.sql" access.log 
           ;;

  	5) echo " Detectando ataques de força bruta (erros 404)..."
           grep " 404 " access.log | cut -d " " -f 1 | sort | uniq -c | sort -nr | head
           ;;

   	*) echo "Modo de uso: Digite $0 e escolha qual opção 1,2,3,4,5"
           echo "Opção 1 - Detectar possíveis ataques de XSS (Cross-Site Scripting)"
	   echo "Opção 2 - Localizar user-agent utilizado por um IP suspeito"
	   echo "Opção 3 - Procurando por tentativas de Path Traversal"
	   echo "Opção 4 - Procurando por arquivos sensíveis (.env, .git, .htaccess, .bak)"
	   echo "Opção 5 - Detectando ataques de força bruta (erros 404)"
	   
esac
