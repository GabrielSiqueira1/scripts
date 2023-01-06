#!/bin/bash
echo "|--------------------------------------------------------------------------
---------------------------|"
echo "|Olá $USER"
x=$(date +%m)
y=$(date +%d)
if [ "$x" == "03" ] && [ "$y" -ge "21" ]; then
	echo "|Estamos no outono e a temperatura está entre 20ºC e 29ºC";
elif [ "$x" == "06" ] && [ "$y" -le "21" ]; then
	echo "|Estamos no outono e a temperatura está entre 18ºC e 28ºC";
elif [ "$x" -ge "04" ] && [ "$x" -le "05" ]; then
	echo "|Estamos no outono e a temperatura está entre 16ºC e 26ºC";
elif [ $x == "06" ] && [ $y -ge "21" ]; then
	echo "|Estamos no inverno e a temperatura está entre 14ºC e 25ºC";
elif [ $x == "09" ] && [ $y -le "23" ]; then
	echo "|Estamos no inverno e a temperatura está entre 14ºC e 25ºC";
elif [ $x -ge "07" ] && [ $x -le "08" ]; then
	echo "|Estamos no inverno e a temperatura está entre 14ºC e 25ºC";
elif [ $x == "09" ] && [ $y -ge "23" ]; then
	echo "|Estamos no primavera e a temperatura está entre 17ºC e 28ºC";
elif [ $x == "12" ] && [ $y -le "21" ]; then
	echo "|Estamos no primavera e a temperatura está entre 19ºC e 29ºC";
elif [ $x -ge "10" ] && [ $x -le "11" ]; then
	echo "|Estamos no primavera e a temperatura está entre 19ºC e 28ºC";
elif [ $x == "12" ] && [ $y -ge "21" ]; then
	echo "|Estamos no verão e a temperatura está entre 20ºC e 28ºC";
elif [ $x == "03" ] && [ $y -le "21" ]; then
	echo "|Estamos no verão e a temperatura está entre 20ºC e 29ºC";
elif [ $x -ge "01" ] && [ $x -le "02" ]; then
	echo "|Estamos no verão e a temperatura está entre 20ºC e 30ºC";
fi
echo "|Está agradável? Se eu não acertei a temperatura é porque o aquecimento
|global já está nos consumindo"
echo "|--------------------------------------------------------------------------
---------------------------|"
echo "|Este trabalho realiza a comparação entre os métodos de inserção estudados
|em algoritmos e "
echo "|estruturas de dados I e II, nesse caso o insertion sort e o bubble sort.
|Para realizar tal proeza"
echo "|você deseja que eu gere o arquivo ou você quer inserir; veja que o arquivo
|deve ter 1 número por linha"
echo "|dessa forma:"
for line in 9 5 6 7; do
echo $line
done
echo "|--------------------------------------------------------------------------
---------------------------|"
PS3="?- "
select choose in gerar inserir sair;do
if [ "$choose" == "" ]; then
echo "Por favor, escolha..."
echo
continue
elif [ $choose = sair ]; then
echo "..."
break
elif [ $choose = gerar ]; then
tam=
echo -n "Escolha um tamanho: "
read tam
echo "OK!"
c=0
while [ "$c" -le $tam ]; do
arr[$c]=$RANDOM
arrr[$c]=${arr[$c]}
c=$(expr $c + 1)
done
touch desordenacao.txt
echo "Arquivo desordenacao.txt criado."
echo "${arr[@]}" >> desordenacao.txt
break
elif [ $choose = inserir ]; then
echo -n "Por favor insira o arquivo: "
read file
# Ajustando array
arr=()
while read line; do
arr+=("$line")
done < $file
break
fi
done
# Tamanho do array
# echo ${#arr[@]}
# O primeiro sort será o insertion baseado no livro do cormen, note que quando o
# livro introduction to algorithms fala j = 2, significa
# a posição dois que neste caso do array é a primeira
if [ $choose = gerar ] || [ $choose = inserir ]; then
T1="$(date +%s)"
for (( j = 1 ; j < ${#arr[@]} ; j++ )); do
result=$(echo "scale=2;$j/${#arr[@]}*100."|bc)
echo -ne "Realizando insertion sort $result%\r"
key=${arr[j]}
i=$(expr $j - 1)
while [ $i -gt 0 ] && [ ${arr[i]} -gt $key ]; do
arr[$(expr $i + 1)]=${arr[i]}
i=$(expr $i - 1)
done
arr[$(expr $i + 1)]=$key
done
T2="$(expr $(date +%s) - $T1)"
if [ $choose = inserir ];then
arrr=()
while read line; do
arrr+=("$line")
done < $file
fi
echo -ne "Realizando insertion sort 100.00%."
echo
T1="$(date +%s)"
# Também retirado do livro do cormen, veja que nesse são apresentados
#pseudocódigos, portanto, realizou-se a conversão
# Suficiente dadas as limitações
for (( i = 0; i < ${#arrr[@]}; i++ )); do
result=$(echo "scale=2;$i/${#arrr[@]}*100."|bc)
echo -ne "Realizando bubble sort $result%\r"
for (( j = $(expr ${#arrr[@]} - 1); j >= $i; j--)); do
if [ ${arrr[j]} -lt ${arrr[$((j-1))]} ];then
tmp=${arrr[j]}
arrr[$j]=${arrr[$((j-1))]}
arrr[$((j-1))]=$tmp
fi
done
done
echo -ne "Realizando bubble sort 100.00%."
echo
echo
T3="$(expr $(date +%s) - $T1)"
touch ordenacao.txt
echo "" > ordenacao.txt
echo ${arrr[@]} >> ordenacao.txt
echo "Arquivo ordenacao.txt criado."
#igualdade
if [ $T3 == $T2 ]; then
echo "Os tempos de ordenação foram iguais porque a quantidade de números para
serem organizados é muito pequena."
elif [ $T3 -lt $T2 ]; then
echo "O bubble sort é mais eficiênte."
fi
resp=
afirmativa="^Yes$"
negacao="^No$"
echo "Gostaria de salvar os dados? (Yes or No)"
until [[ $resp =~ $afirmativa ]] || [[ $resp =~ $negacao ]]; do
echo -n "?-"
read resp
if [[ ! $resp =~ $afirmativa ]] && [[ ! $resp =~ $negacao ]]; then
echo "Desculpe-me mas a resposta não parece padrão. Tente novamente..."
fi
done
#registro
if [[ $resp =~ $afirmativa ]]; then
touch tempos.txt
echo "Arquivo tempos.txt criado."
echo "" > tempos.txt
echo "Tempo do insertion sort foi de $T2 segundos" >> tempos.txt
echo "Tempo do bubble sort foi de $T3 segundos" >> tempos.txt
echo "Muito obrigado!"
elif [[ $resp =~ $negacao ]]; then
echo "Tudo bem, muito obrigado e até uma outra hora."
fi
#leitura
echo "-----------------------------------------------------------------------
-----------------------"
echo "Ordenação:"
cat ordenacao.txt;
echo "-----------------------------------------------------------------------
-----------------------"
echo "Tempos:"
cat tempos.txt;
fi
