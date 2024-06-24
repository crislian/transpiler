
u3(pi, 0, pi) q[0]; // X gate

cx q[1], q[2];

u3(0.4451, -0.5*pi, -pi/2) q[2];

cx q[0], q[1];