import csv

#Prend en entree le fichier des contrats par ID, mais avec les noms d'entreprise remplaces par leurs ID
# with open ("luxleakscorrected.csv") as csvfile :

with open ("sources/luxleakscorrected.csv") as csvfile :

	
	csvReader = csv.reader(csvfile,delimiter=',',quotechar='|')
	
	#ent[0] = ['ID','Name','Parent','Countries','Industry']
	
	countries = [['label']]
	line=0
	
	for row in csvReader:
		
		print line
		line=line+1
		if (line==1) : 
			continue
		
		# Creer un lien entre une entreprise et chacune de ses entreprises ecran (row[5])
		countriesInRow = row[4].split(';')
		
		for country in countriesInRow :
			countries.append([country.strip()])
						
with open('countries.csv', 'wb') as csvfile :

	writer = csv.writer(csvfile, delimiter=',',quotechar='|',quoting=csv.QUOTE_MINIMAL)
	
	for country in countries :
		writer.writerow(country)
	
	
