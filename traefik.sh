#! /bin/bash
# Traefik
echo "Installing Traefik"


## create yaml file
mkdir $DOCKERPATH/traefik
mkdir $DOCKERPATH/traefik/acme
cat > $DOCKERPATH/traefik/traefik.yaml << EOF1
global:
  checkNewVersion: true
  sendAnonymousUsage: false  # true by default

# (Optional) Log information
# ---
log:
  level: DEBUG  # DEBUG, INFO, WARNING, ERROR, CRITICAL
  format: common  # common, json, logfmt
  filePath: /etc/traefik/log/traefik.log

# (Optional) Accesslog
# ---
accesslog:
  format: common  # common, json, logfmt
  filePath: /etc/traefik/log/access.log

# (Optional) Enable API and Dashboard
# ---
api:
  dashboard: true  # true by default
  insecure: true  # Don't do this in production!

# Entry Points configuration
# ---
entryPoints:
  web:
    address: :80
    # (Optional) Redirect to HTTPS
    # ---
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https

  websecure:
    address: :443

serversTransport:
  insecureSkipVerify: false
# Configure your CertificateResolver here...
# ---
certificatesResolvers:
  production:
    acme:
      email: $CERTCONTACT
      storage: /etc/traefik/acme/acme.json
      caServer: "https://acme-v02.api.letsencrypt.org/directory"
      httpChallenge:
        entryPoint: web

providers:
  docker:
    exposedByDefault: true  # Default is true
  file:
    # watch for dynamic configuration changes
    directory: /etc/traefik
    watch: true
EOF1



