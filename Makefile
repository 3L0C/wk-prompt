# Package info
NAME         := wk-prompt
VERSION      := 0.2.0

# Install locations
PREFIX       := /usr/local
MANPREFIX    := $(PREFIX)/share/man

$(NAME).1: $(NAME).1.scd
	scdoc < $< > $@

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(NAME) $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/$(NAME)
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f $(NAME).1 $(DESTDIR)$(MANPREFIX)/man1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/$(NAME)
	rm -f $(DESTDIR)$(MANPREFIX)/man1/$(NAME).1

.PHONY: install uninstall
