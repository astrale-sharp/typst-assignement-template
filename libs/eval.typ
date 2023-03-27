#let title(x , point : 20) = {
  let p = place(dx : -15pt,dy : 28pt)[
      #set text(22pt)
      #rect(stroke : 1pt, radius: 20pt ,fill : rgb(255, 255, 255), inset: 6pt)[#point points]
    ]

  set text(29pt);
  align(center, rect(inset: 15pt, p + [*#x*] ))
}


#let question(body, point : 1,answer : []) = {
  (body : body, point : point, answer : answer, type : "question")
}

#let eval(
      ..args, // can contain question node or plain content that will be inserted between the questions
      show_correction : false,
      // formats the questions
      qfmt : i => [
         *_Question #{i+1})_*],
      // format the rectangle that will contain how much point the question is worth
      prfmt : x => [
              #h(1fr)
              #box(
                radius: 50pt,
                fill : gray.lighten(35%),
                width: 55pt, 
                height: 1.1em)[
                  #set align(center + horizon)
                  #x pt#{if x>1 {[s]}}
                ]],
      answerfmt : i => [#set text(red);\ *#i*]
    ) = {
      if not show_correction {
        answerfmt = i => []
      }
      let is_question(i) = {(
              type(i) == "dictionary"
              and i.type == "question"
        )}
      let q = args.pos().filter(is_question)
      let ca = q.map(i => i.body)
      let pa = q.map(i => i.point)
      let correction_array = q.map(i => if show_correction {i.answer} else {[]} )

      
      let ca = range(ca.len()) 
          .map(
            // format questions and adds a point rectangle
            i => qfmt(i) + ca.at(i) + prfmt(pa.at(i)) + 
            answerfmt(correction_array.at(i)) ) 
        // adds intermediary content
        let tmp = args.pos()
        while tmp.len() > ca.len() {ca.push[]} // just to make sure you can add content that comes after the last question
        while tmp.position(i => not is_question(i)) != none {
          let pos = tmp.position(i => not is_question(i))
         // repr(tmp.remove(pos))
          ca.at(pos) = [#tmp.remove(pos) \ ] + ca.at(pos)
        }
          
        ca.join([\ #v(-5pt)])

        v(1fr) 
        
         
        align(center,table(
        [Questions ], ..range(pa.len()).map(i => [#{i+1}]),[Total], //numéro de la question
        [Points], ..pa.map(repr), [#pa.fold(0, (i,j)=> i + j )],
        [Score], ..pa.map(i => []), [], // score à avoir
      
        columns: range(pa.len() + 2).map(i => auto),
        inset : 10pt,
        align : center  + horizon
        ))
        v(15pt)
}

#let template(body) = [
  #set text(font: "Caladea",12pt, fallback: true, slashed-zero: true, lang: "fr")
  #set page(
    "a4", margin: ( top : 1.5cm,    bottom : 1.35cm,    rest : 1cm),
    footer : align(horizon + right,text(8pt, counter(page).display()))
  )

  #let headercontent = [
    Classe: ..................... #h(1fr) 
    Nom et Prénom: ...................................................
  ]
  //footer: i => align(horizon + right,text(8pt, [#i]))
  //header : i => if i == 1 {align(horizon + left, headercontent)}, 
  #body
]