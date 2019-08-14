import numpy as np
from matplotlib import pyplot as plt
from matplotlib import rc
from matplotlib import rcParams
from math import *
#rc('text', usetex=True)

#rcParams['figure.figsize'] = 5.5,1.9
#plt.figure()
#x = np.linspace(-2.5,2.5,1000)
#y = np.tanh(x)
#plt.plot([-10,10],[0,0], "grey", linewidth=0.7)
#plt.plot([0,0],[-10,10], "grey", linewidth=0.7)
#plt.plot(x, y, 'k', label=r"$\tanh(\xi)$")
#plt.xlim((-2.4,2.4))
#plt.legend()
#plt.xlabel(r"$\xi$")
#plt.ylim(-1,1)
#plt.tight_layout()
#plt.savefig("tanh.pdf")
#plt.show()

s = ""
for i in range(9):
	if i%2 ==0:
		s += "+(%d:#2)" %(45*i)
	else:
		s += "+(%d:#3)" %(45*i)
	s+= "--"	
print(s)

t = 30
t = radians(t)
y = 0.5
h = 10
h2 = y/sin(t)
x2 = y/tan(t)
X = ((h+h2)**2 * (1+tan(t)**2))**0.5
x = X - x2 
l = X*sin(t)
print(l)
print(X-x2)


def lorentz(xi):
	l = np.array([[np.cosh(xi), np.sinh(xi)],
				  [np.sinh(xi), np.cosh(xi)]])
	return l

def rot(xi):
	R = np.array([[np.cos(xi), -np.sin(xi)],
			  [np.sin(xi), np.cos(xi)]])
	return R

def Lx(xi):
	lx = np.eye(3)
	l = lorentz(xi)
	print(type(lx))
	lx[0:2,0:2] = l
	return lx

def Ly(xi):
	ly = np.eye(3)
	l = lorentz(xi)
	ly[0::2,0::2] = l
	return ly	

xi = 0.5
px = Lx(xi)
py = Ly(xi)

mx = Lx(-xi)
my = Ly(-xi)
print("================")

print((mx @ px).round(4))

a = py @ px @ my @ mx  
print(mx)
print((a @ a.T).round(4))
print((np.arctan(tanh(xi))).round(4))


