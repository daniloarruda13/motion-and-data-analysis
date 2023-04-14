 function t_flight=calc_t_flight(g,v0,theta,y0)

  % calculate time of flight
  %
  % Usage: t_flight=calc_t_flight(g,v0,theta,y0)
  %
  % where: g = gravitational acceleration (positive)
  %        v0 = initial velocity (magnitude)
  %        theta = launch angle (degrees)
  %        y0 = launch distance from ground

  % Solve -0.5*g*t^2+v0*sin(2*pi*(theta/180))*t+y0=0

  b=v0*sin(pi*(theta/180));
  a=-g/2;
  c=y0;

  t_flight=(-b-sqrt(b^2-4*a*c))/(2*a);