install :
	ln -s $(shell pwd)/zshrc .zshrc
	ln -s $(shell pwd)/Xressources .Xressources
	ln -s $(shell pwd)/config/Atom Atom
	ln -s $(shell pwd)/config/dunst dunst
	ln -s $(shell pwd)/config/i3 i3
	ln -s $(shell pwd)/config/polybar polybar

	mv .Xressources ${HOME}/
	mv .zshrc ${HOME}/
	mv Atom ${HOME}/.config/Atom
	mv dunst ${HOME}/.config/dunst
	mv i3 ${HOME}/.config/i3
	mv polybar ${HOME}/.config/polybar
clean :
	rm ${HOME}/zshrc_t
	rm ${HOME}/Xressources_t
	rm ${HOME}/.config/Atom
	rm ${HOME}/.config/dunst
	rm ${HOME}/.config/i3
	rm ${HOME}/.config/polybar
