.PHONY: build

MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# find targets
targets := $(patsubst $(MAKEFILE_DIR)/%/Dockerfile,%,$(wildcard $(MAKEFILE_DIR)/*/Dockerfile)))

build_targets := $(patsubst %,build/%,$(targets))
tag_targets := $(patsubst %,tag/%,$(targets))
push_targets := $(patsubst %,build/%,$(targets))
clean_targets := $(patsubst %,clean/%,$(targets))

.PHONY: $(build_targets) $(tag_targets) $(push_targets) $(clean_targets)

image_clean_targets := $(patsubst %,%.clean,$(images))
.PHONY: $(image_clean_targets)
$(image_clean_targets):
	$(eval iidfile := $(patsubst %.clean,%,$@))
	@echo $(iidfile)
	docker rmi $$(cat $(iidfile)) && rm $(iidfile)

targets/%.json:
	defaults.json

%.iid:
	docker build --iidfile "$(mkfile_dir)/images/$@" "${mkfile_dir}/$(basename $@)"

build/%: $(mkfile_dir)/%.iid
	docker build --iidfile "$(mkfile_dir)/images/$*.iid" "${mkfile_dir}/builds/"

buildargs.%.json
	$(eval buildarg_str := $())

clean: $(clean_targets)

$(clean_targets): clean/% :
	
