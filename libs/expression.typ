#import "science.typ" : sfmt

#let node(label, value) = {
  assert(type(label)=="string")
  assert(type(value) in ("float","integer"))
  (label : label, value : value, type : "node")
}

// #let is_node(node) = {
//   type(node)=="dictionary" and node.type == "node"
// }

#let show_node(node) = {
  eval("$" + node.label + "=" + str(node.value) + "$")
}

#let expr_to_val(..nodes) = {
    // args must be string or node
    assert(nodes.pos().all(i => type(i) == "string" or is_node(i)))
    let v = "#{" + nodes.pos().map(i => if is_node(i) {str(i.value)} else {i}).join("") + "}"
    v
}

#let expr_to_label(..nodes) = {
    // args must be string or node
    assert(nodes.pos().all(i => type(i) == "string" or is_node(i)))
    let s = nodes.pos().map(i => if is_node(i) {i.label} else {i}).join(" ")
    s.replace("*","times")
}

#let expr_to_dev(..nodes) = {
    // args must be string or node
    assert(nodes.pos().all(i => type(i) == "string" or is_node(i)))
    let s = nodes.pos().map(i => if is_node(i) {str(i.value)} else {i}).join(" ")
    s.replace("*","times")
}

#let a = node("P_a",700.2);//#show_node(a)

#let b = node("P_d",5);//#show_node(b)





#let expression(
  x,
  nodes : (),
  digit : none,
  show_labels : true,
  show_values : true,
  show_result : true
  ) = {
  let matches = x.matches(regex(":\\w"))
  let mathematize(x) = "$" + x +"$"
  let replace(value,q) = {
    let res = value
    for k in matches {
      let tok = k.text
       res = res.replace(tok,str(q(nodes.at(tok.trim(":")))))
    }
    res
  }
  
  let labels = if show_labels {
    replace(x,i=> i.label).replace("*","times") + " = " } else {""}
  
  let values = if show_values {
    replace(x,i=> i.value).replace("*","times")
    } else {""}


    
  let result = if show_result {
    let tmp = replace(x,i=> i.value)
    for m in tmp.matches(regex("(\\w|\\a)+\\^(\\w|\\a)+")) {
      tmp = tmp.replace(m.text, "calc.pow(" + m.text.split("^").at(0) +"," + m.text.split("^").at(1) + ")")
    }
    let tmp = eval(tmp)
    " = " + sfmt(
      number_of_digit : digit,
      tmp
    )
  } else {""}


  eval(mathematize(labels + values))  + result
  
  
}


On considère que 
#let a = node("P_\"some\"",10);#show_node(a) m.s 
et
#let b = node("d",5158);#show_node(b) m

#let e = expression.with(
  nodes : ("a" : a,"b" : b)
)

#e(
  digit : 0,
  ":a^2 * :a^2",      
)


#e(":a") m


// #r(
//   "(:a + :b)/ (:b)  - 5"
// )




// #e3(
//   "(:a * :b)/ (:b)  - 5",      
// )

















