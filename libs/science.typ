
#let display_float(f, digits: 4) = {
    let exp = calc.floor(calc.log(f))
    let div = if exp < 0 {1/calc.pow(10, -exp)} else {calc.pow(10, exp)}
    let mant = f / div
    let mant = calc.round(mant, digits: digits)

    [$#mant times 10^#exp $]
}

#display_float(9000,digits : 1) 

#display_float(0.01, digits : 4) 

#display_float(10.001 ,digits : 4) 

#display_float(7) 

#display_float(450, digits : 0) 


#display_float(7.1234, digits : 2) 

