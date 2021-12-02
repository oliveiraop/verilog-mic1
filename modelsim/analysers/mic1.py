#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


df=pd.read_csv('test-cases/log/mic1_tb.csv', delimiter=';')


# In[3]:


def is_setup():
    flag= False
    if((clock== '0') 
       and (rom_data == '00000000000000000000000000000000') 
       and (ram_data == '00000000000000000000000000000000')
       and (mir == '0000000000000000')
       and (c == '0')
       and (a == 'x')
       and (b == 'x')
       and (mar == 'x')
       and (mdr == 'x')
       and (pc == 'x')
       and (mbr == 'x') ):
        flag= True
    return flag


# In[4]:


def is_default():
    flag= False
    if((clock == 'x') 
       and (rom_data == 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx') 
       and (ram_data == 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
       and (mir == 'xxxxxxxxxxxxxxxx')
       and (c == 'x')
       and (a == 'x') and
       (b == 'x') and 
       (mar == 'x') and
       (mdr == 'x') and 
       (pc == 'x') and
       (mbr == 'x') ):
        flag= True
    return flag


# In[5]:


for i in range(len(df)):
    row = df[i:i+1]
    data = row.values[0]
    inpections_counter=data[0]
    clock=data[1]
    rom_data=data[2]
    ram_data=data[3]
    mir=data[4]
    c=data[5]
    a=data[6]
    b=data[7]
    mar=data[8]
    mdr=data[9]
    pc=data[10]
    mbr=data[11]
    
    if(inpections_counter == 0 and is_default()):
        print(f"A inicialização em {i+1} está ok")
  
    elif(inpections_counter == 0 and not is_default()):
        print(f"está ok")
        
    elif(inpections_counter == 1 and is_setup()):
        print(f"O setup em {i+1} está OK")
        
    elif(inpections_counter == 1 and not is_setup()):
        print(f"O setup em {i+1} está OK")
            
            
