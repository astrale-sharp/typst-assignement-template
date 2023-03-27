#import "./libs/eval.typ" : eval, title, question, template
#import "./libs/science.typ" : display_float
#show: it => template(it)


#title[Physics Exam in french]

#eval(
  show_correction : false,
  question[ The default number of point is one.],
  question(
    point : 5,
    [
        Un.e scientique s'intéresse à créer un habitat autonome en énergie avec un budjet limité. Iel doit choisir entre deux modèles de panneaux solaire :
        Rappel : le prix d'un wattheure (= 3 600 Joules) est de $0.0001 euro$.

        Il vous faudra expliquer votre démarche, des points seront données sur la qualité de la démarche et de l'explication *même si aucun résultat n'a été trouvé!*

        _Si vous avez le temps vous pourrez *Déterminer* au bout de combien de temps on gagne deux fois plus d'argent avec le modèle B par rapport au modèle A._
    

        _Aide : On a  coût = prix initial - prix de l'énergie générée. (en effet l'énergie généré rapporte de l'argent et réduit donc le coût)_
    ],
    answer : [
      + On calcule le coût de chaque modèle en fonction du temps t qu'on exprime en heure: 
      
        coût = prix initial - prix de l'énergie générée

        $"coût"_A = 300 - P_A times t times "prix d'un wattheure" = 300 - t times #{315 * 0.0001}$
  
        $"coût"_B = 500 - P_B times t times "prix d'un wattheure" = 500 - t times #{625 / 10000}$
  
      + $"Si" t = 1 "an" = #{365*24}h "alors"$
        
        $"coût"_A = #{str(300 - 365*24*0.0315).slice(0,5)} euro "et" 
        "coût"_B = #{500 - 365*24*0.0625} euro$
      + On considère $t_E$ le temps au bout duquel
        les deux prix sont égaux.

        On a donc 
        #[#set align(center)
          $
          "coût"_A &= "coût"_B \
           300 - t_E times 0.0315 &= 500 - t_E times 0.0625\
           300 - 500 &= - t_E * (0.0625 - 0.0315)\
           #{300 - 500} &=  - t_E * #{0.0625 - 0.0315}\
          t_E &= 200/(0.031) = #{str(200/(0.031)).slice(0,6) } "heure"  
          $]

        On vérifie : 
        $"coût" A (t = 6451.6 h) = #{str(300 - 6451.6*0.0315).slice(0,4)} euro$

        $"coût" B (t = 6451.6 h) = #{str(500 - 6451.6*0.0625).slice(0,4)} $
      
    ]),
    question[*Déterminer* le coût de chaque modèle après un an d'utilisation en permanence (le coût pourra être négatif, ce qui signifie que de l'argent a été gagné)],
    question[*Déterminer* au bout de combien de temps chaque modèle à rapporter assez d'argent pour rembourser son prix initial.],
    question[*Déterminer* au bout de combien de temps en heure les prix des modèles A et B sont égaux. #repeat[ ]],
    )
