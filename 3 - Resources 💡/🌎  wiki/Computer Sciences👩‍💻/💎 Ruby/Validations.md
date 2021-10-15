Tags : #rails #Ruby #validations #frontend #backend
**Title:** ==React.js /JavaScript and Ruby on Rails guide==
Subject: Frontend Validations or Backend Validations
Associations: [[PR-721 - More Valid_country_names logic from model User]]
When: 2021-04-14 - 11:00

---
>Le problème avec une validation dans le modèle, c’est que la validation va s’effectuer dès que tu vas faire un save ou un update sur le user. A l’étape du reset de password, mais aussi à n’importe quel autre call api...  
Du coup la meilleure chose c’est d’éviter de mettre la validation sur le modèle, mais de mettre la validation dans un contract qui est appelé dans le point d’API utilisé pour mettre à jour le country, étant donné que c’est uniquement à ce moment là que tu updates ce champs.
-Claire Woman in Rails

	> -   Si tu veux laisser ta validation dans ton modèle, le mieux c’est de cleaner ta base (passer à nil tous les `country`  non valides)
	-   Si tu ne veux pas toucher aux valeurs de ta BDD, il faut que tu mettes ta validation ailleurs que dans le modèle. Tu vas valider l’inclusion du country dans une liste uniquement au moment où tu vas updater cette colonne country sur le user, pas à chaque fois que tu fais un save sur le user (pour l’update d’un autre champs).




---
#### Research 
[Conflict between Frontend and backend validations](https://medium.com/@ehayne00/front-end-validations-or-back-end-validations-80f66d4e1545)

