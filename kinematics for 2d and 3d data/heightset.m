function heightset=heightset(x0,y0,v0,angle)

 % Projectile motion simulation
 %https://en.wikipedia.org/wiki/Projectile_motion

  g=9.81; % m/s^2

  t_flight=calc_t_flight(g,v0,angle,y0);


  t=linspace(0,t_flight,98);
  xdot0=v0*cos(pi*(angle/180));
  ydot0=v0*sin(pi*(angle/180));
  x=xdot0*t+x0;
  y=-(g/2)*t.^2+ydot0*t+y0;
  
  heightset=max(y);
  
end
