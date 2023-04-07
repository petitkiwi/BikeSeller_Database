-- utilisateur secondaire (droit de lecture)
drop user if exists 'bozo'@'localhost';
create user 'bozo'@'localhost' identified by 'bozo' ;
grant SELECT on velomax.* to 'bozo'@'localhost';

-- modification du mot de passe root
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
-- FLUSH PRIVILEGES;

-- CREATION DES TABLES

DROP DATABASE IF EXISTS VeloMax; 
CREATE DATABASE IF NOT EXISTS VeloMax; 
USE VeloMax;

DROP TABLE IF EXISTS Velo;
CREATE  TABLE IF NOT EXISTS Velo (
  numProduit VARCHAR(50) NOT NULL,
  nom VARCHAR(50) NOT NULL,
  grandeur VARCHAR(50) NULL,
  prixUnitaire INT NULL,
  ligneProduit VARCHAR(50) NULL,
  dateIntroVelo Datetime NULL, 
  dateDiscontinuationVelo DateTime NULL,
  stock int not null,
  PRIMARY KEY (numProduit) );

DROP TABLE IF EXISTS Programme;
CREATE  TABLE IF NOT EXISTS Programme (
  numProgramme INT NOT NULL,
  description VARCHAR(50) NOT NULL,
  cout INT NULL,
  duree INT NULL,
  rabais INT  NULL,
  PRIMARY KEY (numProgramme) );
  
DROP TABLE IF EXISTS Assemblage;
CREATE  TABLE IF NOT EXISTS Assemblage (
  nom VARCHAR(50) NULL,
  grandeur VARCHAR(50) NULL,
  cadre VARCHAR(50) NULL,
  guidon VARCHAR(50) NULL,
  freins VARCHAR(50) NULL,
  selle VARCHAR(50) NULL,
  derailleurAvant VARCHAR(50) NULL,
  derailleurArriere VARCHAR(50) NULL,
  roueAvant VARCHAR(50) NULL,
  roueArriere VARCHAR(50) NULL,
  reflecteurs VARCHAR(50) NULL,
  pedalier VARCHAR(50) NULL,
  ordinateur VARCHAR(50) NULL,
  panier VARCHAR(50) NULL,
  numProduit VARCHAR(50),
  FOREIGN KEY (numProduit)
		REFERENCES Velo (numProduit));
   
DROP TABLE IF EXISTS Fournisseur;
CREATE  TABLE IF NOT EXISTS Fournisseur (
  siret VARCHAR(50) NOT NULL PRIMARY KEY,
  nomEntreprise VARCHAR(50) NOT NULL,
  contact VARCHAR(50) NULL,
  adresse VARCHAR(50) NULL,
  numReac VARCHAR(50) NULL,
  libelleReac ENUM('Très bon','Bon','Moyen','Mauvais') NULL);

DROP TABLE IF EXISTS ClientIndividu;
CREATE  TABLE IF NOT EXISTS ClientIndividu (
  idClient VARCHAR(50) NOT NULL PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  courriel VARCHAR(50) NULL,
  telephone VARCHAR(50) NULL,
  rue VARCHAR(50) NULL,
  ville VARCHAR(50) NULL,
  codePostal VARCHAR(50) NULL,
  province VARCHAR(50) NULL,
  numProgramme INT NULL REFERENCES Programme (numProgramme),
  dateAdhesion Datetime NULL);
 
 DROP TABLE IF EXISTS ClientBoutique;
CREATE TABLE IF NOT EXISTS ClientBoutique (
  idClient VARCHAR(50) NOT NULL PRIMARY KEY,
  nomContact VARCHAR(50) NOT NULL,
  nomCompagnie VARCHAR(50) NULL,
  courriel VARCHAR(50) NULL,
  telephone VARCHAR(50) NULL,
  rue VARCHAR(50) NULL,
  ville VARCHAR(50) NULL,
  codePostal VARCHAR(50) NULL,
  province VARCHAR(50) NULL,
  totalAchats INT NULL,
  remise int NULL);
 
DROP TABLE IF EXISTS Piece;
CREATE TABLE IF NOT EXISTS Piece(
numPiece VARCHAR(50) PRIMARY KEY NOT NULL,
description VARCHAR(100) NOT NULL,
nomFournisseur VARCHAR(50) NOT NULL,
numPieceCatalogue VARCHAR(50) NOT NULL,
prixUnitairePiece INT NOT NULL,
dateIntroPiece DateTime NULL,
dateDiscontinuationPiece Datetime NULL,
delaiApp VARCHAR(50) NULL,
siret VARCHAR(50) NOT NULL REFERENCES Fournisseur(siret),
stockPiece int not null);

DROP TABLE IF EXISTS Commande;
CREATE TABLE IF NOT EXISTS Commande(
numCommande VARCHAR(50) PRIMARY KEY NOT NULL,
dateCommande Datetime,
adresseLivraison VARCHAR(100) NULL,
dateLivraison DATE NOT NULL,
idClientIndiv INT REFERENCES ClientIndividu(idClient),
idClientBout INT REFERENCES ClientBoutique(idClient));

DROP TABLE IF EXISTS CommandePiece;
CREATE TABLE IF NOT EXISTS CommandePiece(
numCommande VARCHAR(50) NOT NULL REFERENCES Commande(numCommande) on delete cascade,
numPiece VARCHAR(50) NOT NULL REFERENCES Piece(numPiece),
qtteCommande INT NOT NULL,
PRIMARY KEY (numCommande, numPiece));

DROP TABLE IF EXISTS CommandeVelo;
CREATE TABLE IF NOT EXISTS CommandeVelo(
numCommande VARCHAR(50) NOT NULL REFERENCES Commande(numCommande) on delete cascade,
numProduit VARCHAR(50) NOT NULL REFERENCES Velo(numProduit),
qtteCommande INT NOT NULL,
PRIMARY KEY(numCommande, numProduit));


-- PEUPLEMENT DES TABLES 

-- insertion dans la table Velo (15)
INSERT INTO `VeloMax`.`Velo` VALUES (101, 'Kilimandjaro', 'Adultes', 569, 'VTT', "2022-05-19", "2022-05-25", 25);
INSERT INTO `VeloMax`.`Velo`  VALUES (102, 'NorthPole', 'Adultes', 329, 'VTT', "2022-05-18", "2022-05-25", 40);
INSERT INTO `VeloMax`.`Velo`  VALUES (103, 'MontBlanc', 'Jeunes', 399, 'VTT', "2022-04-18", "2022-05-25", 10);
INSERT INTO `VeloMax`.`Velo`  VALUES (104, 'Hooligan', 'Jeunes', 199, 'VTT', "2022-05-18", "2022-05-25", 16);
INSERT INTO `VeloMax`.`Velo`  VALUES (105, 'Orléans', 'Hommes', 229, 'Vélo de course', "2021-05-18", "2012-05-25", 14);
INSERT INTO `VeloMax`.`Velo`  VALUES (106, 'Orléans', 'Dames', 229, 'Vélo de course', "2022-05-18", "2012-02-25", 3);
INSERT INTO `VeloMax`.`Velo`  VALUES (107, 'BlueJay', 'Hommes', 349, 'Vélo de course', "2020-05-18", "2015-05-25", 21);
INSERT INTO `VeloMax`.`Velo`  VALUES (108, 'BlueJay', 'Dames', 349, 'Vélo de course', "2022-04-21", "2022-05-14", 20);
INSERT INTO `VeloMax`.`Velo`  VALUES (109, 'Trail Explorer', 'Filles', 129, 'Classique', "2022-05-18", "2022-05-15", 16);
INSERT INTO `VeloMax`.`Velo` VALUES (110, 'Trail Explorer', 'Garçons', 129, 'Classique', "2022-05-18", "2021-05-25", 16);
INSERT INTO `VeloMax`.`Velo` VALUES (111, 'Night Hawk', 'Jeunes', 189, 'Classique', "2021-07-18", "2022-05-25", 1);
INSERT INTO `VeloMax`.`Velo` VALUES (112, 'Tierra Verde', 'Hommes', 199, 'Classique', "2022-05-18", "2022-05-25", 34);
INSERT INTO `VeloMax`.`Velo`  VALUES (113, 'Tierra Verde', 'Dames', 199, 'Classique', "2012-05-18", "2021-05-25", 34);
INSERT INTO `VeloMax`.`Velo` VALUES (114, 'Mud Zinger I', 'Jeunes', 279, 'BMX', "2022-04-18", "2022-05-21", 15);
INSERT INTO `VeloMax`.`Velo`  VALUES (115, 'Mud Zinger II', 'Adultes', 359, 'BMX', "2022-05-18", "2020-05-25", 17);


-- insertion dans la table Programme (4)
INSERT INTO `VeloMax`.`Programme` (`numProgramme`, `description`, `cout`, `duree`, `rabais`) VALUES (1, 'Fidélio', 15, 1, 0.05);
INSERT INTO `VeloMax`.`Programme` (`numProgramme`, `description`, `cout`, `duree`, `rabais`) VALUES (2, 'Fidélio Or', 25, 2, 0.08);
INSERT INTO `VeloMax`.`Programme` (`numProgramme`, `description`, `cout`, `duree`, `rabais`) VALUES (3, 'Fidélio Platine', 60, 2, 0.1);
INSERT INTO `VeloMax`.`Programme` (`numProgramme`, `description`, `cout`, `duree`, `rabais`) VALUES (4, 'Fidélio Max', 100, 3, 0.12);

-- insertion dans la table Assemblage (15)
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Kilimandjaro', 'Adultes', 'C32', 'G7', 'F3', 'S88', 'DV133', 'DR56', 'R45', 'R46', null, 'P12', 'O2', null);
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Kilimandjaro', 'Adultes', 'C32', 'G7', 'F3', 'S88', 'DV133', 'DR56', 'R45', 'R46',null ,'P12', 'O2',null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('NorthPole', 'Adultes', 'C34', 'G7', 'F3', 'S88', 'DV17', 'DR87', 'R48', 'R47',null ,'P12', null,null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('MontBlanc', 'Jeunes', 'C76', 'G7', 'F3', 'S88', 'DV17', 'DR87', 'R48', 'R47',null ,'P12', 'O2',null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Hooligan', 'Jeunes', 'C76', 'G7', 'F3', 'S88', 'DV87', 'DR86', 'R12', 'R32',null ,'P12', null,null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Orléans', 'Hommes', 'C43', 'G9', 'F9', 'S37', 'DV57', 'DR86', 'R19', 'R18','R02' ,'P34', null, null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Orléans', 'Dames', 'C44f', 'G9', 'F9', 'S35', 'DV57', 'DR86', 'R19', 'R18','R02' ,'P34', null, null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('BlueJay', 'Hommes', 'C43', 'G9', 'F9', 'S37', 'DV57', 'DR86', 'R19', 'R18','R02' ,'P34', 'O4', null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('BlueJay', 'Dames', 'C43f', 'G9', 'F9', 'S35', 'DV57', 'DR87', 'R19', 'R18','R02' ,'P34', 'O4', null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Trail Explorer', 'Filles', 'C01', 'G12', null, 'S02', null, null, 'R1', 'R2','R09' ,'P1', null, 'S01' );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Trail Explorer', 'Garçons', 'C01', 'G12', null, 'S03', null, null, 'R1', 'R2','R09' ,'P1', null, 'S05' );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Night Hawk', 'Jeunes', 'C15', 'G12', 'F9', 'S36', 'DV15', 'DR23', 'R11', 'R12','R10' ,'P15', null, 'S74' );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Tierra Verde', 'Hommes', 'C87', 'G12', 'F9', 'S36', 'DV41', 'DR76', 'R11', 'R12','R10' ,'P15', null, 'S74' );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Tierra Verde', 'Dames', 'C87f', 'G12', 'F9', 'S34', 'DV41', 'DR76', 'R11', 'R12','R10' ,'P15', null, 'S73' );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Mud Zinger I', 'Jeunes', 'C25', 'G7', 'F3', 'S87', 'DV132', 'DR52', 'R44', 'R47',null ,'P12', null, null );
INSERT INTO `VeloMax`.`Assemblage` (`nom`, `grandeur`, `cadre`, `guidon`, `freins`, `selle`, `derailleurAvant`, `derailleurArriere`, `roueAvant`, `roueArriere`, `reflecteurs`, `pedalier`, `ordinateur`, `panier`) VALUES ('Mud Zinger II', 'Adultes', 'C26', 'G7', 'F3', 'S87', 'DV133', 'DR52', 'R44', 'R47',null ,'P12', null, null );

-- insertion dans la table Fournisseur
insert into velomax.Fournisseur values ("420783680","Amazon","Berler","67 boulevard du Général Leclerc",1,"Très bon");
insert into velomax.Fournisseur values ("351654651","Chain Reaction","Manilo","12 avenue du Parc",3,"Moyen");
insert into velomax.Fournisseur values ("578783753","Wiggle","Ver","501 chemin des prés",4,"Mauvais");
insert into velomax.Fournisseur values ("777656789","Velolilo","Lefez","13 avenue Rocaillou",1,"Très bon");
insert into velomax.Fournisseur values ("220446615","ManoMano","Jean","47 rue Lamotte",2,"Bon");
insert into velomax.Fournisseur values ("566566886","Probike","Pierre","1 place de Clichy",2,"Bon");
insert into velomax.Fournisseur values ("045544545","Gucci","Petit","4 place du Colonel Bourgeon",1,"Très bon");
insert into velomax.Fournisseur values ("320054565","Radco","Perrard","2 avenue du Trône",2,"Bon");
insert into velomax.Fournisseur values ("448623005","Decathlon","Sanchez","41 boulevard Lanes",3,"Moyen");
insert into velomax.Fournisseur values ("665113228","BitsyBike","Galmier","6 rue de Picardie",2,"Bon");
insert into velomax.Fournisseur values ("326120555","RiderPRO","Dupont-Besson","8 rue Drouot",2,"Bon");
insert into velomax.Fournisseur values ("2051541200","Machia","le Manoir","74 avenue de la Mairie",2,"Bon");
insert into velomax.Fournisseur values ("1010125556","Ma Bécane","Crouton","18 rue Vineuse",1,"Très bon");
insert into velomax.Fournisseur values ("587331012","Feu Vert","Landes","18 rue Guillermot",4,"Mauvais");
insert into velomax.Fournisseur values ("0252566845","ZOO","Tanguy","87 rue Alphonse Conor",1,"Très bon");

-- insertion dans la table ClientIndividu (particuliers)
insert into velomax.ClientIndividu values ("1","Lagroi","Guillaume","gui.lagroi@gmail.com","0679431846","17 rue Vineux","Paris","75016","IDF",1,"2021-10-10");
insert into velomax.ClientIndividu values ("2","Meunier","Mélusine","meludu92@orange.fr","0761956643","5 avenue de la faille","Vaucresson","92420","IDF",2,"2021-05-05");
insert into velomax.ClientIndividu values ("3","Lajon","Charlotte","chachalaj@gmail.com","0679231846","8 rue Bo","Albon","26140","Drome",3,"2020-09-09");
insert into velomax.ClientIndividu values ("4","Morello","Corinne","morellocorinne@gmail.com","0134692255","1 boulevard du champagne","Chalancon","26340","Drome",4,"2020-01-01");
insert into velomax.ClientIndividu values ("5","Poitiers","Tanguy","tpoitiers@gmail.com","0678784536","4 rue des feuilles mortes","Paris","75011","IDF",1,"2022-02-02");
insert into velomax.ClientIndividu values ("6","de la Fromagère","Poline","podlf@gmail.com","0715963351","17 rue du Vin","Alvin","57320","Moselle",2,"2021-12-24");
insert into velomax.ClientIndividu values ("7","Province","Danil","danil.province@hotmail.com","0673331846","4 allée Victor Hugo","Angecourt","08450","Ardennes",3,"2021-07-07");
insert into velomax.ClientIndividu values ("8","Beulette","Pierre-André","beulettefamily@gmail.com","0679401006","33 allée Vermont","Vilaine","35003","IDF",1,"2022-05-09");
insert into velomax.ClientIndividu values ("9","Vanille","Vincent","vvmaster@gmail.com","0697816294","15 rue de Jade","Paris","75016","IDF",1,"2022-04-18");
insert into velomax.ClientIndividu values ("10","Quantinu","Zoé","zoe.quantinu@outlook.fr","0631366597","1 avenue de la Paix","Bouzonville","57320","Moselle",2,"2021-11-29");
insert into velomax.ClientIndividu values ("11","Zhao","Xin","banyasuo@gmail.com","0769563419","4 boulevard du kiosque","Lachau","26560","Drome",3,"2022-01-01");
insert into velomax.ClientIndividu values ("12","Gros","Eric","ericgros@hotmail.com","0632659897","23 rue des pissenlits","Miscon","26310","Drome",1,"2022-03-13");
insert into velomax.ClientIndividu values ("13","Jean","Paula","paula.jean22@gmail.com","0707120033","15 avenue Pascal Obispo","Paris","75003","IDF",2,"2021-12-12");
insert into velomax.ClientIndividu values ("14","Cariere","Laurent","laurentlanouille@gmail.com","0134956784","7 allée des faons","Bossey","74160","Haute-Savoie",1,"2022-01-11");
insert into velomax.ClientIndividu values ("15","Vandandino","Pedro","pedroenfrancia@gmail.com","0639636846","8 rue Pikachu","Paris","75016","IDF",2,"2020-05-22");

-- insertion dans la table ClientBoutique
INSERT INTO VeloMax.ClientBoutique VALUES ('1', 'Clerment', 'BikeShop', 'bikeshop@bikeshop.fr', '0908070605', 'rue David', 'Paris', '75007', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('2', 'Chopper', 'Dorado', 'Dorado@Dorado.fr', '0903070605', 'rue Mantis', 'Paris', '75017', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('3', 'Reaper', 'Illios', 'Illios@Illios.fr', '0904070605', 'rue de l''Amalgame', 'Paris', '75009', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('4', 'Soldier', 'Hanamura', 'hanamura@hanamura.fr', '0905070605', 'rue Ragnaros', 'Paris', '75008', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('5', 'Anna', 'Anubis', 'anubis@anubis.fr', '0906070605', 'rue Deflecto', 'Paris', '75019', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('6', 'Mercy', 'Volskaya', 'volskaya@volskaya.fr', '0907070605', 'rue des Pillards', 'Paris', '75005', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('7', 'Chacal', 'Horizon', 'horizon@horizon.fr', '0908071605', 'rue des Myrmidons', 'Paris', '750015', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('8', 'Doomfist', 'Rialto', 'rialto@rialto.fr', '0908070605', 'rue Murozond', 'Paris', '75016', 'Ile de France', null, null);
INSERT INTO VeloMax.ClientBoutique VALUES ('9', 'Reinhardt', 'Oasis', 'oasis@oasis.fr', '0904070705', 'rue de Athissa', 'Paris', '75004', 'Ile de France', null, null);

-- insertion dans la table Commande
INSERT INTO VeloMax.Commande (numCommande,idClientIndiv,  dateCommande, adresseLivraison, dateLivraison) VALUES ('1', '7', '2022-11-26', '18 rue Lepic', '2022-12-02' );
INSERT INTO VeloMax.Commande (numCommande,idClientBout, dateCommande, adresseLivraison, dateLivraison) VALUES ('2', '2', '2022-10-24', '18 rue Andros', '2022-10-28' );
INSERT INTO VeloMax.Commande (numCommande,idClientBout, dateCommande, adresseLivraison, dateLivraison) VALUES ('3', '3','2022-07-16', '18 rue Yoplait', '2022-07-18' );
INSERT INTO VeloMax.Commande (numCommande,idClientIndiv, dateCommande, adresseLivraison, dateLivraison) VALUES ('4', '4', '2022-08-17', '18 rue Marie', '2022-08-20' );
INSERT INTO VeloMax.Commande (numCommande,idClientIndiv,  dateCommande, adresseLivraison, dateLivraison) VALUES ('5', '15', '2022-11-26', '18 rue Lepic', '2022-12-02' );
INSERT INTO VeloMax.Commande (numCommande,idClientBout, dateCommande, adresseLivraison, dateLivraison) VALUES ('6', '6', '2022-10-24', '18 rue Andros', '2022-10-28' );
INSERT INTO VeloMax.Commande (numCommande,idClientBout, dateCommande, adresseLivraison, dateLivraison) VALUES ('7', '13','2022-07-16', '18 rue Yoplait', '2022-07-18' );
INSERT INTO VeloMax.Commande (numCommande,idClientIndiv, dateCommande, adresseLivraison, dateLivraison) VALUES ('8', '8', '2022-08-17', '18 rue Marie', '2022-08-20' );
INSERT INTO VeloMax.Commande (numCommande,idClientIndiv,  dateCommande, adresseLivraison, dateLivraison) VALUES ('9', '9', '2022-11-26', '18 rue Lepic', '2022-12-02' );
INSERT INTO VeloMax.Commande (numCommande,idClientBout, dateCommande, adresseLivraison, dateLivraison) VALUES ('10', '1', '2022-10-24', '18 rue Andros', '2022-10-28' );

-- insertion dans la table CommandeVelo
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`,`numProduit`, `qtteCommande`) VALUES (1, 103, 3);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (1, 106, 2);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (2, 101, 1);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (2, 103, 2);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`,`numProduit`, `qtteCommande`) VALUES (3, 104, 1);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (3, 105, 1);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (3, 107, 1);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`,`numProduit`, `qtteCommande`) VALUES (7, 106, 1);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (8, 105, 1);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (9, 114, 4);
INSERT INTO `VeloMax`.`CommandeVelo` (`numCommande`, `numProduit`, `qtteCommande`) VALUES (9, 103, 2);

-- insertion dans la table CommandePiece
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (1, '20', 1);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (4, '47', 2);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (4, '3', 2);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (4, '11', 2);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (4, '35', 2);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (7, '59', 1);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (5, '16', 2);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (5, '7', 1);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (5, '38', 2);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (6, '55', 1);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (10, '38', 1);
INSERT INTO `VeloMax`.`CommandePiece` (`numCommande`,`numPiece`, `qtteCommande`) VALUES (10, '33', 1);

-- insertion dans la table Piece
insert into velomax.Piece values("1", 'cadre', 'Amazon',"1", 220, '2012-01-15','2030-01-15','5',"420783680",2);
insert into velomax.Piece values("3", 'cadre', 'Chain Reaction',"1", 707, '2012-01-15','2030-01-15','15',"351654651",6);
insert into velomax.Piece values("4", 'cadre', 'Wiggle',"1", 500, '2012-01-15','2030-01-15','10',"578783753",5);
insert into velomax.Piece values("5", 'cadre', 'Velolilo',"1", 412, '2012-01-15','2030-01-15','3',"777656789",9);

insert into velomax.Piece values("8", 'guidon', 'Velolilo',"2", 15, '2012-01-15','2030-01-15','3',"777656789",5);
insert into velomax.Piece values("9", 'guidon', 'ManoMano',"2", 80, '2012-01-15','2030-01-15','7',"220446615",4);
insert into velomax.Piece values("10", 'guidon', 'Wiggle',"2", 67, '2012-01-15','2030-01-15','4',"566566886",10);


insert into velomax.Piece values("12", 'freins', 'Velolilo',"3", 31, '2012-01-15','2030-01-15','3',"777656789",40);
insert into velomax.Piece values("13", 'freins', 'ManoMano',"3", 27, '2012-01-15','2030-01-15','7',"220446615",12);
insert into velomax.Piece values("15", 'freins', 'Probike',"3", 57, '2012-01-15','2030-01-15','10',"566566886",6);


insert into velomax.Piece values("17", 'selle', 'ManoMano',"4", 32, '2012-01-15','2030-01-15','3',"220446615",2);
insert into velomax.Piece values("18", 'selle', 'Gucci',"4", 49, '2012-01-15','2030-01-15','7',"045544545",12);
insert into velomax.Piece values("19", 'selle', 'Radco',"4", 55, '2012-01-15','2030-01-15','15',"320054565",3);
insert into velomax.Piece values("20", 'selle', 'Decathlon',"4", 41, '2012-01-15','2030-01-15','10',"448623005",10);


insert into velomax.Piece values("22", 'derailleurAvant', 'Decathlon',"5", 11, '2012-01-15','2030-01-15','7',"448623005",12);
insert into velomax.Piece values("23", 'derailleurAvant', 'BitsyBike',"5", 15, '2012-01-15','2030-01-15','10',"665113228",20);
insert into velomax.Piece values("25", 'derailleurAvant', 'RiderPRO',"5", 19, '2012-01-15','2030-01-15','10',"326120555",6);


insert into velomax.Piece values("27", 'derailleurArriere', 'Machia',"6", 12, '2012-01-15','2030-01-15','5',"2051541200",15);
insert into velomax.Piece values("28", 'derailleurArriere', 'BitsyBike',"6", 13, '2012-01-15','2030-01-15','10',"665113228",20);
insert into velomax.Piece values("31", 'derailleurArriere', 'Decathlon',"6", 14, '2012-01-15','2030-01-15','7',"448623005",35);

insert into velomax.Piece values("32", 'roueAvant', 'Velolilo',"7", 96, '2012-01-15','2030-01-15','3',"777656789",12);
insert into velomax.Piece values("34", 'roueAvant', 'BitsyBike',"7", 160, '2012-01-15','2030-01-15','10',"665113228",30);
insert into velomax.Piece values("35", 'roueAvant', 'Decathlon',"7", 140, '2012-01-15','2030-01-15','7',"448623005",50);
insert into velomax.Piece values("36", 'roueAvant', 'Amazon',"7", 140, '2012-01-15','2030-01-15','5',"420783680",20);

insert into velomax.Piece values("37", 'roueArriere', 'Ma Bécane',"8", 126, '2012-01-15','2030-01-15','3',"1010125556",16);
insert into velomax.Piece values("38", 'roueArriere', 'BitsyBike',"8", 160, '2012-01-15','2030-01-15','10',"665113228",35);
insert into velomax.Piece values("39", 'roueArriere', 'Decathlon',"8", 160, '2012-01-15','2030-01-15','7',"448623005",50);

insert into velomax.Piece values("42", 'reflecteurs', 'ManoMano',"9", 8, '2012-01-15','2030-01-15','3',"220446615",40);

insert into velomax.Piece values("50", 'pedalier', 'Decathlon',"10", 125, '2012-01-15','2030-01-15','7',"448623005",20);
insert into velomax.Piece values("51", 'pedalier', 'Ma Bécane',"10", 104, '2012-01-15','2030-01-15','3',"1010125556",10);

insert into velomax.Piece values("52", 'ordinateur', 'ManoMano',"11", 58, '2012-01-15','2030-01-15','14',"220446615",6);

insert into velomax.Piece values("57", 'panier', 'Feu Vert',"12", 18, '2012-01-15','2030-01-15','15',"587331012",15);
insert into velomax.Piece values("58", 'panier', 'ManoMano',"12", 37, '2012-01-15','2030-01-15','8',"220446615",20);
insert into velomax.Piece values("59", 'panier', 'Velolilo',"12", 37, '2012-01-15','2030-01-15','7',"777656789",20);
insert into velomax.Piece values("60", 'panier', 'BitsyBike',"12", 36, '2012-01-15','2030-01-15','10',"665113228",5);
insert into velomax.Piece values("61", 'panier', 'ZOO',"12", 24, '2012-01-15','2030-01-15','10',"0252566845",30);