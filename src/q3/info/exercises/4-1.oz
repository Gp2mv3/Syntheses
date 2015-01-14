declare
Carte = carte(menu(entree: 'salade verte aux lardons'
		   plat: 'steak frites'
		   prix: 10)
	      menu(entree: 'salade de crevettes grises'
		   plat: 'saumon fume et pommes de terre'
		   prix: 12)
	      menu(plat: 'choucroute garnie'
		   prix: 9))

{Browse Carte.2}          % second menu
{Browse Carte.2.plat}     % plat du second menu (atom)
{Browse Carte.1.entree}   % entree du premier menu (atom)
{Browse {Arity Carte}}    % affiche [1 2 3]
{Browse {Arity Carte.1}}  % affiche [entree plat prix]
