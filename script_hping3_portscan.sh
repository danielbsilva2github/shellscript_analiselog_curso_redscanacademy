#!/bin/bash
trap "echo -e '\nInterrompido pelo usuário.'; exit" SIGINT
banner() {
cat <<"EOF"
          SSSSSSSSSSSSSSS                                                    TTTTTTTTTTTTTTTTTTTTTTT                              lllllll'
        SS:::::::::::::::S                                                   T:::::::::::::::::::::T                              l:::::l '
        S:::::SSSSSS::::::S                                                   T:::::::::::::::::::::T                              l:::::l '
        S:::::S     SSSSSSS                                                   T:::::TT:::::::TT:::::T                              l:::::l '
        S:::::S                cccccccccccccccc  aaaaaaaaaaaaa  nnnn  nnnnnnnnTTTTTT  T:::::T  TTTTTTooooooooooo     ooooooooooo    l::::l '
        S:::::S              cc:::::::::::::::c  a::::::::::::a n:::nn::::::::nn      T:::::T      oo:::::::::::oo oo:::::::::::oo  l::::l '
        S::::SSSS          c:::::::::::::::::c  aaaaaaaaa:::::an::::::::::::::nn     T:::::T     o:::::::::::::::o:::::::::::::::o l::::l '
        SS::::::SSSSS    c:::::::cccccc:::::c           a::::ann:::::::::::::::n    T:::::T     o:::::ooooo:::::o:::::ooooo:::::o l::::l '
        SSS::::::::SS  c::::::c     ccccccc    aaaaaaa:::::a  n:::::nnnn:::::n    T:::::T     o::::o     o::::o::::o     o::::o l::::l '
          SSSSSS::::S c:::::c               aa::::::::::::a  n::::n    n::::n    T:::::T     o::::o     o::::o::::o     o::::o l::::l '
              S:::::Sc:::::c              a::::aaaa::::::a  n::::n    n::::n    T:::::T     o::::o     o::::o::::o     o::::o l::::l '
             S:::::Sc::::::c     ccccccca::::a    a:::::a  n::::n    n::::n    T:::::T     o::::o     o::::o::::o     o::::o l::::l '
 SSSSSSS     S:::::Sc:::::::cccccc:::::ca::::a    a:::::a  n::::n    n::::n  TT:::::::TT   o:::::ooooo:::::o:::::ooooo:::::ol::::::l'
 S::::::SSSSSS:::::S c:::::::::::::::::ca:::::aaaa::::::a  n::::n    n::::n  T:::::::::T   o:::::::::::::::o:::::::::::::::ol::::::l'
S:::::::::::::::SS   cc:::::::::::::::c a::::::::::aa:::a n::::n    n::::n  T:::::::::T    oo:::::::::::oo oo:::::::::::oo l::::::l'
SSSSSSSSSSSSSSS       cccccccccccccccc  aaaaaaaaaa  aaaa nnnnnn    nnnnnn  TTTTTTTTTTT      ooooooooooo     ooooooooooo   llllllll'



echo "Modo de Uso"
echo "./script.sh opcao"
echo "Exemplo ./script.sh -a"
echo ""
echo " -a - Portscan"
echo " -b - PingSweep"
echo " -c - NetCat"
echo " -d - NetCat - PingSweep - Scan ICMP"
echo " -e - PingSweep /dev/tcp nativo"
echo " -f - Portscan /dev/tcp nativo"
EOF
}

banner2() {
echo "Tool-Scan  - version 1.0"
echo "By Webrecon"
}

banner2

if [ "${1}" = "-a" ]; then
echo "Opcao a"
echo "Digite o IP - Ex: 192.168.0.1"
read ip
echo "Digite a porta inicial Ex: 22"
read portai
echo "Digite a porta final Ex: 1000"
read portaf
sudo hping3 "$ip" -S --scan "$portai-$portaf"


elif [ "${1}" = "-b" ]; then
echo "Opcao b"
echo "Digite a range da Rede - Ex: 192.168.0"
read ip
for i in $(seq 1 254);do
if [ -n "$(sudo hping3 -1 -c 1 $ip.$i 2>/dev/null | grep 'ttl')" ]; then echo "$ip.$i"; fi
done


elif [ "${1}" = "-c" ]; then
echo "Opcao c"
echo "Digite o IP - Ex: 192.168.0.1"
read ip
echo "Digite a porta inicial - Ex: 1"
read portai
echo "Digite a porta inicial - Ex: 6500"
read portaf
nc -v -n -z $ip $portai-$portaf


elif [ "${1}" = "-d" ]; then
echo "Digite uma Rede/24 - Ex: 192.168.0"
read ip
echo "Digite uma porta - Ex: 80"
read porta
for i in $(seq 1 254); do nc -zvw 1 $ip.$i $porta 2>/dev/null && echo "Host $ip.$i - $porta up"
done


elif [ "${1}" = "-e" ]; then
echo "Digite o IP - Ex: 192.168.0.1"
read ip
echo "Digite a porta inicial - Ex: 1"
read portai
echo "Digite a porta inicial - Ex: 6500"
read portaf
for i in $(seq 1 254); do timeout 0.5 echo -n 2>/dev/null < "/dev/tcp/$ip/$i" && echo "$i open"; done


elif [ "${1}" = "-f" ]; then
echo "Digite o IP - Ex: 192.168.0.1"
read ip
echo "Digite a porta inicial - Ex: 1"
read portai
echo "Digite a porta inicial - Ex: 6500"
read portaf
for i in $(seq $portai $portaf); do timeout 0.5 echo -n 2>/dev/null < /dev/tcp/$ip/$i && echo "$i open"; done



else
banner
fi