Ensure nginx is installed:
  pkg.installed:
    - name: nginx

Ensure apache2 is not running:
  service.dead:
    - name: apache2
    - enable: False

Run nginx:
  service.running:
    - name: nginx
