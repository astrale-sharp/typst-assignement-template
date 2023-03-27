#import "expression.typ" : node,expression

#let oldnode = node
#let oldexpr = expression
#let state = state("expr",("type":"exprstate"))
#let node(x,data) = {
  state.update(
    i => {
      i.insert(x,oldnode(x,data))
      i
    }
  )
}

#let expression(x,..y) = {
  locate(loc => {
  oldexpr(x,..y, 
  nodes : state.at(loc))
  })
}

#node("a",40)

#node("b",50)

#expression(
  ":a^2 * :b^2",      
    digit : 0,
)