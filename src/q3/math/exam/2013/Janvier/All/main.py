import numpy as np
a = np.array([[1,1,1],[0,1,0],[0,0,1]]);
b = np.array([0,-0.5,0.9]);
x = np.linalg.solve(a,b)
print x
print x
a = np.array([[1,1,1,1],[0,0,1,0],[0,0,0,1],[3,2,1,0]]);
b = np.array([0,-0.5,0.9,-0.9]);
x = np.linalg.solve(a,b)
print x
a = np.array([[1,1,1,1],[0,0,1,0],[0,0,0,1],[6,2,0,0]]);#f''(1)=-0.9
b = np.array([0,-0.5,0.9,0.9]);
x = np.linalg.solve(a,b)
print x
a = np.array([[1,1,1,1],[0,0,1,0],[0,0,0,1],[3,2,1,0]]);#f''(1)=-0.9
b = np.array([0,-0.5,0.7,-0.7]);
x = np.linalg.solve(a,b)
print x
a = np.array([[1,1,1,1],[0,0,1,0],[0,0,0,1],[6,2,0,0]]);#f'(1)=-0.9
b = np.array([0,-0.5,0.7,0.7]);
x = np.linalg.solve(a,b)
print x
