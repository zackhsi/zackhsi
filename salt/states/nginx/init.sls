Ensure apache2 is not running:
  service.dead:
    - name: apache2
    - enable: False

Ensure nginx is installed:
  pkg.installed:
    - name: nginx

Ensure nginx configuration:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - template: jinja
    - mode: 644
    - listen_in:
      - service: nginx

Run nginx:
  service.running:
    - name: nginx
