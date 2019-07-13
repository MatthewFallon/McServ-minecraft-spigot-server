.PHONY: default
default:


ETC_SYSTEMD := /etc/systemd/system/
SERVICE_FILE_MODE := --owner=root --group=root --mode=644

.PHONY: install
install: ${ETC_SYSTEMD}/minecraft.service


${ETC_SYSTEMD}/minecraft.service: etc/systemd/minecraft.service
	install ${SERVICE_FILE_MODE} --compare '$<' '$@'