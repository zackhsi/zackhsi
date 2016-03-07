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

Ensure default nginx server is absent:
  file.absent:
    - name: /etc/nginx/sites-enabled/default

{% for site in [
  'zackhsi',
] %}
Ensure nginx server configuration is available:
  file.managed:
    - name: /etc/nginx/sites-available/{{ site }}
    - source: salt://nginx/sites-available/{{ site }}
    - template: jinja
    - mode: 644
    - listen_in:
      - service: nginx

Ensure nginx server configuration is enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/{{ site }} 
    - target: /etc/nginx/sites-available/{{ site }}
    - listen_in:
      - service: nginx
{% endfor %}

Run nginx:
  service.running:
    - name: nginx
