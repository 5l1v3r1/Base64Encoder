Base 64 encoder (RU)
=============
Простой модуль, написанный на Ассемблере и предназначенный для кодировки любых данных по алгоритму Base64,
всю пустую критику и благодарности оставьте при себе, мне на них похуй.
Это просто концептуальная разработка которая была просто созданна для облегчения жизни многих скрипт кидов, ламеров,
и простых смертных людей.

Юзать модуль следует так: invoke Base64Encode StrIn, StrOut, InLen. Где StrIn - указатель на буффер входных данных, 
StrOut - указатель на пустой буффер, в который будет помещена закодированная строка
(алгоритм подсчета размера этого буффера - ниже), 

InLen - размер входных данных. Для подсчета размеры выходных данных можно использовать

Мой код (код лишь для того, чтобы показать принцип, если вы хотите его использовать,
то его необходимо будет оптимизировать :-) )

Base 64 Encoder (EN)
=============
Simple module written in Assembler and designed to encode any data on algorithm Base64,
empty all the criticism and appreciation leave with them, I fuck them. 
It's just a conceptual development that was just making for easier lives of many script kids, lamers and 
ordinary mortals.
Use module as follows: invoke Base64Encode StrIn, StrOut, InLen. Where StrIn - a pointer to the buffer input data

StrOut - a pointer to an empty buffer, to contain the encoded string
(algorithm for calculating the size of this buffer - below), 

InLen - the size of the input data. To calculate the size of the output, you can use 

My code (code only to show the principle that if you want to use it, it will be necessary to optimize :-) )
