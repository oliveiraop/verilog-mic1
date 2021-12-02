#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


df=pd.read_csv('../test-cases/log/mic1_tb.csv', delimiter=';',index_col=False)


# In[3]:



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


# In[4]:


print(mbr)


# In[ ]:


# ['inpections_counter','clock','rom_data','ram_data','mir','c','a','b','mar','mdr','pc',
# 'mbr']

