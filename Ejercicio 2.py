#!/usr/bin/env python
# coding: utf-8

# #  EJERCICIO 2     

# 1- Tomamos el archivo sentimientos.txt como uno de los archivos de entrada, donde podemos acceder a los sentimientos y sus respectivos valores.

# In[1]:


# ---------------------------archivo de lectura sientimiento.txt------------
valores = {} 
for linea in open("Sentimientos.txt"): 
    termino, valor = linea.split("\t") 
    valores[termino] = int(valor) 
#print (valores.items())


# 2- De manera similar Ejercicio1, para calcular la suma de valores de sentimientos, se creó una función llamada soma_valor que recibe una lista de valores de sentimeintos. Esta función fue útil para implementar la versión 1 con una técnica para asignar valores a conjuntos de palabras o palabras que no tienen ningún valor asociado. El ejemplo sigue.
# 

# In[ ]:


Por Ejemplo:
    
SENTIMIENTO(S): beautiful = 3
-----------------------------------

SENTIMIENTO(S): better = 2
-----------------------------------

You : 5
believe : 5
your : 5
---------- COMPROBAR-----------
EL SEGUINTE TWEET: ['You', 'better', 'believe', 'your', 'beautiful'] , TIENE UN SENTIMIENTO ASSOCIADO DE: 5


# In[2]:


#----------------------funcion soma_valor -------------------
def soma_valor(valor):
    soma = 0
    for i in valor:
        soma+=i
  
    return soma


# 3- De acuerdo con los requisitos del ejercicio, a una palabra o conjunto de palabras que no tiene un valor asociado se le asignará un valor, una de las técnicas para asignar estos valores fue el número de palabras en el tweet dividido por el valor del sentimiento del tweet. La función med_tweer es responsable de implementar esta técnica. El ejemplo sigue

# In[ ]:


SENTIMIENTO(S): beautiful = 3
----------------------------------

SENTIMIENTO(S): better = 2
-----------------------------------

You : 1.0
believe : 1.0
your : 1.0
---------- COMPROBAR-----------
EL SEGUINTE TWEET: ['You', 'better', 'believe', 'your', 'beautiful'] , TIENE UN SENTIMIENTO ASSOCIADO DE: 5
____________________________________________________________________________________________________________


# In[3]:


#---------------------------function media tweet----------------
def med_tweer (len_tweet,v_sent):
            
            res=(len_tweet/v_sent)
    
            return round (res,3)
     
        


# 4- La función print_json es responsable de prácticamente todos los ejercicios. Le permite leer el archivo Tweet.txt a través de json_loads (), de forma análoga al Ejercicio 1, las líneas del archivo Tweet.txt están en el diccionario anidado, esta función sirve para descomprimir las líneas que están en el diccionario anidado y las otras técnicas para cumplir con los requisitos de ejercicio. Un poco diferente del ejercicio 1, aquí se agregó otro parámetro (valor_vers) que recibe el valor 1 o 2, un valor que determina la técnica para asignar valores a palabras o conjuntos de palabras que no tienen valores (Versión 1, asignando el valor del sentimiento del twittea las palabras o la Versión 2, asignando la media del valor del tweet, mientras que esta es la media del número de palabras del tweet divididas entre el valor de sentimiento del tweet).

# In[14]:


#----------------------funcion print_json -------------------

def print_json(data,k,valor_vers):
    
        if type(data) == dict:
                for k, v in data.items():
                    if (isinstance(v,str) or isinstance(v,dict)):
                        print_json(v,k,valor_vers)

        else:
            valor=[]
            list_sent=[]
            tweet_list=[]
            data=data.split(" ")
            if (type(data) is list and data !=None) : 
                                    
                for sent, k in valores.items():
                    if sent in data:
                        valor.append(k)
                        list_sent.append(sent)
                        print("SENTIMIENTO(S):", sent,"=",k,) 
                        print("-----------------------------------\n")        

                              
                num_ass=soma_valor(valor)
                if num_ass!=0:
                   
                    if valor_vers==1:
                        for tweet in data:
                            
                            if tweet not in list_sent:
                                print(tweet,":",num_ass)

                        print("---------- COMPROBAR-----------")
                        print("EL SEGUINTE TWEET:",data,"," " ""TIENE UN SENTIMIENTO ASSOCIADO DE:",num_ass)
                        print("________________________________________________________________________________________________________________\n")
                        
                    elif valor_vers==2:
                        
                        for tweet in data:
                            if tweet not in list_sent :
                                media=med_tweer(len(data),num_ass)
                                print(tweet,":",media)

                        print("---------- COMPROBAR-----------")
                        print("EL SEGUINTE TWEET:",data,"," " ""TIENE UN SENTIMIENTO ASSOCIADO DE:",num_ass)
                        print("______________________________________________________________________________________________________________________\n")
                        
                          


# 5- El siguiente script es responsable de leer el archivo Tweet.txt a través de json_loads (), es responsable de llamar a la función print_json y también validar los valores para elegir la versión para asignar números a palabras o conjuntos de palabras que no tienen valores , no se aceptarán valores distintos de 1 o 2 para avanzar en el programa.

# In[19]:


# ---------------------------archivo de lectura sientimiento.txt------------
import json
print("Este ejercicio se realiza en dos versiones. Elija la versión 1 (Valor 1) o la versión 2 (Valor 2):")
valor_vers=int(input("Elija la versión:"))
if valor_vers==1:
    print("Versión 1, asignando el valor del sentimiento del tweet a las palabras:\n")
elif  valor_vers==2:
    print("Versión 2, asignando la media del valor del tweet, siendo esta media el número de palabras del tweet dividido entre el valor de sentimiento del tweet;:\n")

if (valor_vers ==1 or valor_vers==2):
    for line in open('Tweets.txt', 'r'):
            valor=json.loads(line)
            print_json(valor,0,valor_vers)
else:
    print("Elija la versión 1 o 2!!")


# ### Conclusión y observaciones finales.

# 6- Análogamente al ejercicio 1, puedo decir el ejercicio fue útil para articular la teoría con la práctica que probablemente servirá para que el alumno tenga un buen ajuste en el mundo de los negocios. Creo que el propósito del ejercicio se logró de acuerdo con mi comprensión e interpretación del ejercicio. Aunque no es obligatorio, se deben agregar algunas tareas, como limpiar los tweets, eliminar imágenes y validar los datos con la función regesp. También se eligieron los dos métodos para asignar valores (versión 1 y versión 2) a conjuntos de tweetes que no tienen valores.
# Ya que conociendo los sentimientos en el archivo sentemientos.txt, tomamos la iniciativa de que no todos los tweets en el archivo Tweets.txt nos interesan. Por ejemplo, todos los tweets con valores enteros, valores nulos y None son descartados.

# ##### -----------------------------------------------------------------------------FIM---------------------------------------------------------------------------

# ######  PS. El texto fue escrito en portugués y traducido al español con google translate

# ###### Por: Adilson David Lopes Varela

# In[ ]:




