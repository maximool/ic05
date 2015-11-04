import csv

#Prend en entree le fichier des contrats par ID, mais avec les noms d'entreprise remplaces par leurs ID
# with open ("luxleakscorrected.csv") as csvfile :

with open ("../sources/luxleakscorrected.csv") as csvfile :

	
	csvReader = csv.reader(csvfile,delimiter=',',quotechar='|')
	
	#ent[0] = ['ID','Name','Parent','Countries','Industry']
	
	# company, parent company, year, countries, industry
	screens = [['Company', 'Countries']]
	i = 1
	line=0
	
	for row in csvReader:
		
		print line
		line=line+1
		if (line==1) : 
			continue
		
		# Creer un lien entre une entreprise et chacune de ses entreprises ecran (row[5])
		entsEcran = row[5].split(';')
		
		for entEcran in entsEcran :
			screen = []
			screen.append(entEcran.strip())
			screen.append('Luxembourg')
			screens.append(screen)
			i = i+1
			
with open('screenCompanies.csv', 'wb') as csvfile :

	writer = csv.writer(csvfile, delimiter=',',quotechar='|',quoting=csv.QUOTE_MINIMAL)
	
	for screen in screens :
		writer.writerow(screen)
	
	
