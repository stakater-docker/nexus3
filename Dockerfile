# https://github.com/sonatype/docker-nexus3
# https://hub.docker.com/r/sonatype/nexus3
FROM sonatype/nexus3:3.38.0

ENV NEXUS_PLUGINS ${NEXUS_HOME}/system

# https://github.com/flytreeleft/nexus3-keycloak-plugin
# update this version in github/workflows pull_request.yaml to reflect in docker hub images
ENV KEYCLOAK_PLUGIN_VERSION 0.5.0
# The release name in the release page: https://github.com/flytreeleft/nexus3-keycloak-plugin/releases
# update this version in github/workflows pull_request.yaml to reflect in docker hub images
ENV KEYCLOAK_PLUGIN_RELEASE_NAME v0.5.0
ENV KEYCLOAK_PLUGIN /org/github/flytreeleft/nexus3-keycloak-plugin/${KEYCLOAK_PLUGIN_VERSION}/nexus3-keycloak-plugin-${KEYCLOAK_PLUGIN_VERSION}

USER root

ADD https://github.com/flytreeleft/nexus3-keycloak-plugin/releases/download/${KEYCLOAK_PLUGIN_RELEASE_NAME}/nexus3-keycloak-plugin-${KEYCLOAK_PLUGIN_VERSION}.jar \
     ${NEXUS_PLUGINS}${KEYCLOAK_PLUGIN}.jar

RUN chmod 644 ${NEXUS_PLUGINS}${KEYCLOAK_PLUGIN}.jar
RUN echo "reference\:file\:${KEYCLOAK_PLUGIN}.jar = 200" >> ${NEXUS_HOME}/etc/karaf/startup.properties

# setup permissions
RUN chown nexus:nexus -R /opt/sonatype/nexus

USER nexus
