create table luxleaks (
	ID integer primary key,
	Company varchar,
	ParentCompany varchar,
	Year integer,
	Countries varchar,
	LuxembourgSubsidiaries varchar,
	Industry varchar,
	IntendedInvestment varchar,
	Currency varchar,
	etaD date,
/*
	etaD varchar,
*/
	TypeOfDocument varchar,
	DocumentName varchar,
	DocumentCloudLink varchar,
	CompanyNotice varchar,
	DocumentNotice varchar,
	AccountingFirm varchar,
	Story1Link varchar,
	Story1Text varchar,
	Story2Link varchar,
	Story2Text varchar,
	Story3Link varchar,
	Story3Text varchar,
	Story4Link varchar,
	Story4Text varchar,
	Story5Link varchar,
	Story5Text varchar
);
\copy luxleaks FROM 'luxleakscorrectednoheader.csv' WITH CSV DELIMITER ',' QUOTE '"'
