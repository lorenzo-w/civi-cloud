# civi-cloud

Deploy a fully functional on-premise cloud infrastructure that encompasses all digital business needs of modern non-profits and SMEs.

## Components

### 1. SSO

- Purpose: full organizational & social identity solution
- Sub-charts:
  - [Keycloak](https://artifacthub.io/packages/helm/bitnami/keycloak)
  - [OAuth2 Proxy](https://artifacthub.io/packages/helm/oauth2-proxy/oauth2-proxy)
  - [Keycloak Config CLI](https://artifacthub.io/packages/helm/jkroepke/keycloak-config-cli)
  - [OpenLDAP Stack](https://artifacthub.io/packages/helm/helm-openldap/openldap-stack-ha)
- Config
  - directly via Keycloak `values.yaml`
  - or via yaml files referenced in `.Values.env.IMPORT_FILES_LOCATIONS` for keycloak-config-cli chart, see [example configs](https://github.com/adorsys/keycloak-config-cli/tree/main/contrib/example-config)
  - or via OpenLDAP `values.yaml`

### 2. Homer

- Purpose: startpage linking to all other apps
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/k8s-at-home/homer)
- Config:
  - via `.Values.configmap.config`
  - see [config docs](https://github.com/bastienwirtz/homer/blob/main/docs/configuration.md)
- SSO:
  - via oauth2-proxy

### 3. Dolibarr

- Purpose:
  - Membership management
  - Bookkeeping
- Package:
  - [Docker image](https://hub.docker.com/r/upshift/dolibarr)
- Config:
  - via Docker env
  - or via mounting `conf.php` into `/var/www/html/conf`

### 4. Nextcloud

- Purpose:
  - Filesharing
  - Collaborative document-editing
  - Shared calendars, contacts & tasks
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/nextcloud/nextcloud)
- Config:
  - System:
    - directly via `values.yaml`
    - or via [multiple](https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#multiple-config-php-file) `.config.php` files inserted into `.Values.nextcloud.configs`
  - Apps:
    - via `occ config:import config.json` in init container
  - External Storages:
    - [WebDav](https://docs.nextcloud.com/server/latest/admin_manual/configuration_files/external_storage/webdav.html) for Dolibarr
    - [FTP](https://docs.nextcloud.com/server/latest/admin_manual/configuration_files/external_storage/ftp.html) for Wordpress
- Apps:
  - Install via [occ command](https://docs.nextcloud.com/server/20/admin_manual/configuration_server/occ_command.html#apps-commands) in init container
  - List of apps:
    - [OCCWeb](https://apps.nextcloud.com/apps/occweb)
    - [Forms](https://apps.nextcloud.com/apps/forms)
    - [Polls](https://apps.nextcloud.com/apps/polls)
    - [Calendar](https://apps.nextcloud.com/apps/calendar)
    - [Tasks](https://apps.nextcloud.com/apps/tasks)
    - [OnlyOffice](https://apps.nextcloud.com/apps/onlyoffice)
    - [Contacts](https://apps.nextcloud.com/apps/contacts)
    - [GroupFolders](https://apps.nextcloud.com/apps/groupfolders)
    - [Mail](https://apps.nextcloud.com/apps/mail)
    - [OpenID](https://github.com/pulsejet/nextcloud-oidc-login)
    - [E3EE](https://apps.nextcloud.com/apps/end_to_end_encryption)
    - [Appointments](https://apps.nextcloud.com/apps/appointments)
    - [Circles](https://apps.nextcloud.com/apps/circles)
    - [Bookmarks](https://apps.nextcloud.com/apps/bookmarks)
    - [Draw.io](https://apps.nextcloud.com/apps/drawio)
    - [Impersonate](https://apps.nextcloud.com/apps/impersonate)
    - [Auto Tags](https://apps.nextcloud.com/apps/files_automatedtagging)
    - [Collectives](https://apps.nextcloud.com/apps/collectives)
    - [Workflow OCR](https://apps.nextcloud.com/apps/workflow_ocr)
    - [Shiftplan](https://apps.nextcloud.com/apps/shifts)
    - [Duplicate Finder](https://apps.nextcloud.com/apps/duplicatefinder)
    - [Recognize](https://apps.nextcloud.com/apps/recognize)
    - [Rocket.Chat](https://apps.nextcloud.com/apps/rocketchat_nextcloud)
    - [Passwords](https://apps.nextcloud.com/apps/passwords)
    - [Fulltext Search](https://apps.nextcloud.com/apps/fulltextsearch)
    - [Fulltext Search Files](https://apps.nextcloud.com/apps/files_fulltextsearch)
    - [Fulltext Search Bookmarks](https://apps.nextcloud.com/apps/bookmarks_fulltextsearch)
    - [Fulltext Search Elastic](https://apps.nextcloud.com/apps/fulltextsearch_elasticsearch)
    - [File Lock](https://apps.nextcloud.com/apps/files_lock)
    - [Link Editor](https://apps.nextcloud.com/apps/files_linkeditor)
    - [Extract](https://apps.nextcloud.com/apps/extract)
    - [File Access Control](https://apps.nextcloud.com/apps/files_accesscontrol)
    - [Shared Download Activities](https://apps.nextcloud.com/apps/files_downloadactivity)
    - [E-Signatures](https://apps.nextcloud.com/apps/electronicsignatures)
    - [Approval](https://apps.nextcloud.com/apps/approval)
    - [Metadata](https://apps.nextcloud.com/apps/metadata)
    - [App Order](https://apps.nextcloud.com/apps/apporder)
    - [Splash](https://apps.nextcloud.com/apps/unsplash)
    - [Breeze Dark Theme](https://apps.nextcloud.com/apps/breezedark)
- SSO:
  - via `config.json`, see [example file](https://github.com/YunoHost-Apps/nextcloud_ynh/blob/master/conf/config.json)
- Clients
  - Android
  - iOS
  - Desktop
- Subchart: VDirSyncer
  - Purpose: Sync Dolibarr and Nextcloud CalDAV & CardDAV
  - Package:
    - [PIP](https://pypi.org/project/vdirsyncer/)
    - [Run with Python container](https://hub.docker.com/_/python)
  - Config:
    - via [config file](https://vdirsyncer.pimutils.org/en/stable/tutorial.html?highlight=server%20to%20server#configuration)
    - configure [server to server](https://vdirsyncer.pimutils.org/en/stable/tutorial.html?highlight=server%20to%20server#advanced-collection-configuration-server-to-server-sync)

### 5. OnlyOffice

- [Via Docker](https://github.com/ONLYOFFICE/Docker-DocumentServer)
- [Config exampl](https://github.com/ONLYOFFICE/docker-onlyoffice-nextcloud)e for integration with Nextcloud

### 6. Rocket.Chat

- Purpose:
  - Filesharing
  - Collaborative document-editing
  - Shared calendars, contacts & tasks
  - Wiki articles
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/rocketchat-server/rocketchat)
- Config:
  - directly via `values.yaml`
  - or via [Docker env & setting id](https://docs.rocket.chat/guides/administration/misc.-admin-guides/settings-via-env-vars)
- SSO:
  - [Keycloak SAML tutorial](https://docs.rocket.chat/guides/administration/settings/saml/keycloak)
- Clients
  - Android
  - iOS
  - Desktop

### 7. Jitsi

- Purpose: video conferencing
- Package:
  - [Helm chart](https://github.com/jitsi-contrib/jitsi-helm)
- Config:
  - via `values.yaml`

### 8. Wordpress

- Purpose:
  - portfolio website
  - public articles
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/bitnami/wordpress)
- Config:
  - System:
    - directly via `values.yaml`
    - or via `wp-config.php` inserted into `.Values.wordpressExtraConfigContent`
  - Apps:
    - via `wp option update` in init container
- Plugins:
  - Install via `.Values.wordpressPlugins`
  - List of plugins:
    - [Broken Link Checker](https://de.wordpress.org/plugins/broken-link-checker/)
    - [Duplicate Page](https://de.wordpress.org/plugins/duplicate-page/)
    - [Contact Form 7](https://de.wordpress.org/plugins/contact-form-7/)
    - [Matomo Analytics](https://de.wordpress.org/plugins/matomo/)
    - [Permalink Manager](https://de.wordpress.org/plugins/permalink-manager/)
    - [Yoast SEO](https://de.wordpress.org/plugins/wordpress-seo/)
    - [Gutenberg](https://de.wordpress.org/plugins/gutenberg/)
    - [Super PWA](https://wordpress.org/plugins/super-progressive-web-apps/)
    - [SAML](https://wordpress.org/plugins/miniorange-saml-20-single-sign-on/)
    - [WP Super Cache](https://wordpress.org/plugins/wp-super-cache/)
    - [Advanced Custom Fields](https://wordpress.org/plugins/advanced-custom-fields/)
    - [Smush](https://wordpress.org/plugins/wp-smushit/)
    - External: [Frontity Embedded](https://github.com/frontity/frontity-embedded)
- SSO:
  - via [SAML plugin](https://wordpress.org/plugins/miniorange-saml-20-single-sign-on/)
  - [config options](https://plugins.trac.wordpress.org/browser/miniorange-saml-20-single-sign-on/tags/4.9.19/includes/lib/mo-saml-options-enum.php)

### 9. Frontity

- Purpose: Serve modern react webpage, which is embeddable into Wordpress
- Package:
  - [Node.js Docker image](https://hub.docker.com/_/node)
- Config:
  - supply repository to deploy via Docker env / chart values

### 10. Mautic

- Purpose:
  - Marketing
  - Newsletters
  - Social-media campaigning
- Package:
  - [Docker image](https://hub.docker.com/r/mautic/mautic/)
- Config:
  - directly via Docker env
  - or inject into `local.php` via Docker env vars prefixed with `MAUTIC_CONFIG_`
  - unofficial [list of options](https://www.saml.com/en/mautic-know-how/mautic/mautic-configuration-file-parameters/)
- SSO:
  - [via SAML](https://docs.mautic.org/en/authentication#saml-single-sign-on)

### 11. Discourse

- Purpose: civilized discussion platform
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/bitnami/discourse)
- Config:
  - via chart values
  - or via mounted `app.yml` mounted onto `/containers` on the docker container
- Plugins:
  - install [via ](https://meta.discourse.org/t/install-plugins-in-discourse/19157)`app.yml`
- SSO:
  - via [Discourse SAML Pugin](https://github.com/discourse/discourse-saml)

### 12. Mobilizon

- Purpose: Event registration
- Package:
  - [Docker image](https://hub.docker.com/r/framasoft/mobilizon)
- Config:
  - directly via Docker env, see example `docker-compose.yml`
  - or via [mounting ](https://docs.joinmobilizon.org/administration/install/docker/#advanced-configuration)`config.exs` into container
- SSO:
  - [via OIDC](https://docs.joinmobilizon.org/administration/configure/auth/#oauth)

### 13. N8N

- Purpose: workflow automation
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/open-8gears/n8n)
- Config:
  - via `values.yaml`
- SSO:
  - via oauth2-proxy

### 14. Blink

- Purpose: URL shortener
- Package:
  - [install via Docker](https://docs.blink.rest/Installation/2.3%20Advanced#docker)
- Config:
  - via Docker env
  - [Config docs](https://docs.blink.rest/Server%20Administration/3.1%20Configuration)
- SSO:
  - [via OIDC](https://docs.blink.rest/Installation/2.1%20Prerequisites#oidc-configuration)

### 15. Elasticsearch

- Purpose: provide text search to other apps
- Package:
  - [Helm chart](https://artifacthub.io/packages/helm/bitnami/elasticsearch)
- Config:
  - via chart values
- SSO:
  - Likely not necessary, as it's not exposed
