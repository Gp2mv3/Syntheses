import numpy as np
from matplotlib import pyplot as plt
from matplotlib import rc
from matplotlib import rcParams
from math import *
rc('text', usetex=True)

rcParams['figure.figsize'] = 5.5,1.9
plt.figure()
x = np.linspace(-2.5,2.5,1000)
y = np.tanh(x)
plt.plot([-10,10],[0,0], "grey", linewidth=0.7)
plt.plot([0,0],[-10,10], "grey", linewidth=0.7)
plt.plot(x, y, 'k', label=r"$\tanh(\xi)$")
plt.xlim((-2.4,2.4))
plt.legend()
plt.xlabel(r"$\xi$")
plt.ylim(-1,1)
plt.tight_layout()
plt.savefig("tanh.eps")
plt.show()
