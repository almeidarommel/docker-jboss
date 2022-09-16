# FROM docker-registry.default.svc:5000/sefaz-imagens/maven-ocp-sefaz:latest as compile
FROM image-registry.openshift-image-registry.svc:5000/h-sefaz-imagens/maven-ocp-sefaz:latest as compile
WORKDIR /opt/eap-app
COPY . /opt/eap-app
RUN mvn install  


# FROM docker-registry.default.svc:5000/sefaz-imagens/eap-73-oracle-ocp-sefaz:latest
FROM image-registry.openshift-image-registry.svc:5000/h-sefaz-imagens/eap-73-oracle-ocp-sefaz:latest
ENV LANG="en_US.UTF-8"
USER root
COPY --chown=jboss:root --from=compile /opt/eap-app/extensions.cli /opt/eap/extensions/
COPY --chown=jboss:root --from=compile /opt/eap-app/receita-rest/target/receita2-rest.war /deployments/