INSTALL = /usr/bin/install -c

EMACS= emacs --no-init-file --no-site-file -batch \
--eval "(setq load-path (cons \".\" load-path))" $(EMACSARG)

AUTOLOAD= --eval "(setq load-path (cons \"..\" load-path))" \
--eval "(let ((generated-autoload-file (expand-file-name \"$@\"))) \
  (mapcar (function update-file-autoloads) command-line-args-left) \
  (save-buffers-kill-emacs t))"

%.elc: %.el
	@$(EMACS) -f batch-byte-compile $<


install: $(ELC) $(AUTOFILE).elc
	@mkdir -p -m 0755 $(INSTALLDIR) ;                    \
    for i in $(ELC) $(AUTOFILE) ; do                             \
         $(INSTALL) $$i $(INSTALLDIR) ;                  \
    done ;                                               \

clean:
	rm -f $(ELC) $(AUTOFILE).el $(AUTOFILE).elc
