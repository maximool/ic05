import csv

#Prend en entree le fichier des contrats par ID, mais avec les noms d'entreprise remplaces par leurs ID
# with open ("luxleakscorrected.csv") as csvfile :

with open ("../sources/luxleakscorrected.csv") as csvfile :

	
	csvReader = csv.reader(csvfile,delimiter=',',quotechar='|')
	
	#ent[0] = ['ID','Name','Parent','Countries','Industry']
	
	# contrats[0] = ['ID','Source','Target','Year','Industry','Investment','Currency','Date','Type','Document name','Document Cloud Link','Accounting firm','Story 1 link', 'Story 1 text']
	contrats = [['IDContrat','Source','Target','Year','Industry','Investment','Currency','Date','Type','Document name','Document Cloud Link','Accounting firm','Story 1 link', 'Story 1 text']]
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
			contrat = []
			contrat.append(row[0])
			contrat.append(row[1])
			contrat.append(entEcran)
			contrat.append(row[3])
			contrat.append(row[6])
			contrat.append(row[7])
			contrat.append(row[8])
			contrat.append(row[9])
			contrat.append(row[10])
			contrat.append(row[11])
			contrat.append(row[12])
			contrat.append(row[15])
			contrat.append(row[16])
			contrat.append(row[17])
			contrats.append(contrat)
			i = i+1
			
with open('links.csv', 'wb') as csvfile :

	contratsWriter = csv.writer(csvfile, delimiter=',',quotechar='|',quoting=csv.QUOTE_MINIMAL)
	
	for contrat in contrats :
		contratsWriter.writerow(contrat)
	
	
