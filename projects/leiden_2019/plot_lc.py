from __future__ import print_function
import numpy as np
import matplotlib.pyplot as plt


def extract_lc(t,L):
    # takes the luminosity history and returns one flash
    Lav = 0.5*(max(L)+min(L))

    i = len(L)-1
    while L[i] > Lav:
        i = i-1
    i1 = i
    while L[i] < Lav:
        i = i-1
    while L[i] > Lav:
        i = i-1
    i2 = i

    t1 = t[i2:i1]
    L1 = L[i2:i1]
       
    if len(t1)>0:
        # return only the part that is within 1% of the peak luminosity
        t1 = t1[L1 > max(L1)-2]
        L1 = L1[L1 > max(L1)-2]
        # set the start time to zero
        t1 = t1 - t1[0]
    
    return t1, 10.0**L1  
    

fig = plt.figure(figsize=(8,5))
ax = fig.add_subplot(1,1,1)

# read the history file 
data = np.genfromtxt('LOGS/history.data', names=True, skip_header=5)

# extract the light curve of 1 burst
t, L = extract_lc(data['star_age'], data['log_L'])
t = t * 3.15e7
plt.plot(t,L)

plt.ylabel(r'$L\ [L_\odot]$', fontsize=12)
plt.tick_params(axis='both', which='major', labelsize=12)
plt.tick_params(axis='both', which='minor', labelsize=12)
ax.set_yscale('log')
plt.xlabel(r'${\rm Time}\ [{\rm s}]$', fontsize=11)

plt.show()
#plt.savefig('lc.pdf')
