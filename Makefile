.PHONY: default
default: cache

ETC_SYSTEMD := /etc/systemd/system/

INSTALL_FILE_MODE := --owner=root --group=root --mode=644

BUILD_TOOLS_URL:=https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
BUILD_TOOLS_CACHE:=.cache/BuildTools.jar
BUILD_TOOLS_PATH:=/var/lib/BukkitBuildTools/BuildTools.jar

${BUILD_TOOLS_PATH}: ${BUILD_TOOLS_CACHE}
	install ${INSTALL_FILE_MODE} -T '$<' '$@'

SERVICE_FILE_SRC := etc/systemd/minecraft.service
SERVICE_FILE_PATH := ${ETC_SYSTEMD}/minecraft.service
${ETC_SYSTEMD}/minecraft.service: ${SERVICE_FILE_SRC}
	install ${INSTALL_FILE_MODE} -T '$<' '$@'

.PHONY: install
install:  ${BUILD_TOOLS_PATH}

.PHONY: cache
cache:
	curl -o ${BUILD_TOOLS_CACHE} ${BUILD_TOOLS_URL}
