# Luxembourg leaks for Gephi

## Attention please
- projet réalisé dans le cadre de l'UV IC05 au Printemps 2015
- Maxime Margerin
- [Henry Nomichith](http://henry.nomichith.fr/)
- much Perl, very Gephi, wow
- le code est sous licence MIT et les documents produits autour (site web compris) sous licence CC-BY
- voir aussi le [site du projet](http://wwwetu.utc.fr/~mmargeri/luxleaks)

## Sources
- les métadonnées structurées (.csv) se trouvent [ici](http://iw-files.s3.amazonaws.com/apps/2014/12/luxleaks/data/20141209_LuxembourgLeaks.csv.zip)
- la [banque des documents](https://www.documentcloud.org/public/search/Source:%20%22Luxembourg%20Leaks%22) (.pdf, la conversion en .txt n'est pas très fiable)
- le principal [site] (http://www.icij.org/project/luxembourg-leaks/explore-documents-luxembourg-leaks-database)

## To do list
- retoucher le csv de manière à obtenir un graphe avec un enregistrement par entreprise
- chercher le siège social de l'entreprise mère ?
- créer des liens de type différents, on peut faire des partitions sur les liens

## Nouvelle structure du fichier
- liens entre entreprises et sociétés écran
- 1 fichier .csv pour les entreprises
	* ID pour les entreprises (à faire)
	* nom
	* société mère (ID, si différent)
	* pays (siège social à trouver)
	* domaines (secteur d'activité)
- 1 fichier .csv pour les liens (plusieurs lignes par contrat)
	* ID du contrat (à conserver)
	* Source : entreprise source (la filiale, pas la mère)
	* Target : entreprise écran
	* cabinet de conseil
	* somme
	* date (attribut temporel dans Gephi)
	* année (cf. attribut supérieur) ?
	* type du document
	* URL stories
	
- les contrats et les entreprises sont en relation
- pour ce qui est de la condition temporelle : c'est un peu lourd pour Gephi, il faut toujours une date de début. On a décidé de travailler à l'échelle du mois
- TODO : mettre un svg de l'UML sur le dépôt
- EDIT : le fichier a été "corrigé" : en fait le problème venait surtout du .csv mal formé, un des champs contenait des balises html `<b>` et ça provoquait des `<br>`

## Le point sur les CSV
- les cellules sont séparées par des virgules (',')
- les valeurs d'une cellule multivaluée sont séparées par des points-virgules (';')
- problème avec le split : on peu très bien ajouter des virgules dans une seule cellule mettant le contenu de la phrase avec virgules entre guillemets (voir par exemple le fichier `20141209_LuxembourgLeaks.csv`, ligne 380

## Paramètres pour les visualisation
- partition par type
- coloration par investissement
- classement des noeuds par occurence count, spline type 3, taille min 20, taille max 60

## Statistiques
### Notes
J'ai arrangé/refait des listes propres, ce sont les fichiers real*.csv
### Un fichier investissement par
- entreprises, pays et industries : OK
- vérification à la main, pas vu de problème important
- prise en compte de la devise et conversion en euro (taux de conversion en vigueur le 8 Juin au soir)
- voir le fichier investissement/traitement.sh pour plus de détails techniques
### Problème de statistiques
Aucun problème pour les entreprises, en revanche l'algorithme employé pour les pays et les industries à tendance à "gonfler" les valeurs. Je prends un exemple : si je détecte dans luxleakscorrected.csv une ligne  qui contient Media et Finance, la somme indiquée sur cette ligne est ajouté à Media et à Financ, la somme indiquée sur cette ligne est ajouté à Media et à Finance.
C'est le même principe pour les countries, les chiffres obtenus permettent de bien nuancer l'argent brassé par pays et par industrie mais la valeur dans les .csv n'est pas fidèle (on pourra le préciser lors de l'oral).
### Des stats générales
- de 2002 à 2011
- argent brassé en tout : 193 017 996 720 euros
- nombre d'entreprises : 384
- nombre de pays : 82
- nombre de secteurs industriels : 9 (médias, technologie, industrie manufacturière, santé, alimentaire, vente en gros, énergie, finance, transports)
- cabinets d'audit impliqués : 4 (Pricewaterhousecoopers dans 574 contrats sur 584, Loyens & Loeff dans 1, Ernst & Young dans 8, KPMG dans 1)
