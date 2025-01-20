# Package info
NAME         := wk-prompt
VERSION      := 0.1.0

# Install locations
PREFIX       := /usr/local
MANPREFIX    := $(PREFIX)/share/man

# Project directories
MAN_DIR      := .

# Project files
MAN_FILES    := $(wildcard $(MAN_DIR)/*.man)

all: $(MAN_FILES:.man=)

$(MAN_DIR)/%.1: $(MAN_DIR)/%.1.man
	cp -f $< $@
	sh clean_man_files.sh "General Commands Manual" "$@"

clean:
	rm -f $(MAN_FILES:.man=)

install: $(NAME) $(MAN_FILES:.man=)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(NAME) $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/$(NAME)
	for section in 1; do \
		mkdir -p $(DESTDIR)$(MANPREFIX)/man$${section}; \
		cp -f $(MAN_DIR)/*.$$section $(DESTDIR)$(MANPREFIX)/man$${section}; \
		chmod 644 $(DESTDIR)$(MANPREFIX)/man$${section}/$(NAME)*.$${section}; \
	done

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/$(NAME)
	for section in 1; do \
		rm -f $(DESTDIR)$(MANPREFIX)/man$${section}/$(NAME)*.$${section}; \
	done

.PHONY: all clean install uninstall
